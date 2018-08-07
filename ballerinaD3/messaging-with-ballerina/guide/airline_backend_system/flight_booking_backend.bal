import ballerina/mb;
import ballerina/log;
import ballerina/http;
import ballerina/io;

documentation { Define the message queue endpoint for new reservations. }
endpoint mb:SimpleQueueSender queueSenderBooking {
    host: "",
    port: 5672,
    queueName: "NewBookingsQueue"
};

documentation { Define the message queue endpoint for cancel reservations. }
endpoint mb:SimpleQueueSender queueSenderCancelling {
    host: "",
    port: 5672,
    queueName: "BookingCancellationQueue"
};

documentation { Attributes associate with the service endpoint. }
endpoint http:Listener airlineReservationEP {
    port: 9090
};

documentation { Airline reservation service exposed via HTTP/1.1. }
@http:ServiceConfig {
    basePath: "/airline"
}

service<http:Service> airlineReservationService bind airlineReservationEP {

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/reservation"
    }
}


