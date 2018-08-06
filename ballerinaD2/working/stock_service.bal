
import ballerina/http;
import ballerina/io;
import ballerina/log;

string getQuery = "/digitalstrategy/bureaudirectory.json";


endpoint http:Client clientEndpoint{
    url: "https://www2.ed.gov"
};

function main(string... args) {
    http:Request req = new;
    var response = clientEndpoint->get(getQuery);

    match response {
        http:Response resp => {
            io:println("GET request:");
            var msg = resp.getJsonPayload();
            match msg {
                json jsonPayload => {
                    io:println(jsonPayload);
                }
                error err => {
                    log:printError(err.message, err=err);                
                }
            }
        }
        error err => { log:printError(err.message, err = err); }
    }

}



