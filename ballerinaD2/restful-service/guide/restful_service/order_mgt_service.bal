import ballerina/http;
import ballerinax/docker;

@docker:Config {
    registry:"ballerina.guides.io",
    name:"restful_service",
    tag:"v1.0"
}

@docker:Expose{}
endpoint http:Listener listener {
    port:9090
};

map<json> ordersMap;

//service

@http:ServiceConfig { basePath: "/ordermgt" }
service<http:Service> orderMgt bind listener {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/order/{orderId}"
    }
    findOrder(endpoint client, http:Request req, string orderId){
        //Implementation
        json? payload = ordersMap[orderId];
        http:Response response;
        if (payload == null){
            payload = "Order: "+ orderId + " cannot be found.";
        }
        response.setJsonPayload(untaint payload);
        _= client->respond(response);

    }

    @http:ResourceConfig {
        methods:["POST"],
        path: "/order"
    }
    addOrder(endpoint client, http:Request req){
        json orderReq = check req.getJsonPayload();
        string orderId = orderReq.Order.ID.toString();
        ordersMap[orderId] = orderReq;

        //resp
        json payload = { status: "Order Created.", orderId: orderId };
        http:Response response;
        response.setJsonPayload(untaint payload);

        response.statusCode = 201;
        response.setHeader("Location", "http://localhost:9090/ordermgt/order/"+orderId);

        _ = client->respond(response);
        
        }

    @http:ResourceConfig {
        methods: ["PUT"],
        path: "order/{orderId}"
    }
    updateOrder(endpoint client, http:Request req, string orderId){
        json updateOrder = check req.getJsonPayload();

        json existingOrder = ordersMap[orderId];
        if (existingOrder != null){
            existingOrder.Order.Name = updateOrder.Order.Name;
            existingOrder.Order.Description = updateOrder.Order.Description;
            ordersMap[orderId] = existingOrder;

        } else {
            existingOrder = "Order : "+ orderId + "cannot be found.";
        }

        http:Response response;
        response.setJsonPayload(untaint existingOrder);
        _ = client->respond(response);
    }

    @http:ResourceConfig {
        methods: ["DELETE"],
        path: "/order/{orderId}"
    }
    cancelOrder(endpoint client, http:Request req, string orderId) {
        http:Response response;
        //remove order from map
        _ = ordersMap.remove(orderId);

        json payload = "Order "+ orderId + "removed.";
        // set payload with order status.
        response.setJsonPayload(untaint payload);

        _ = client->respond(response);
    }

}