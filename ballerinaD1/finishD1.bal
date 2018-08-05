import ballerina/io;
import ballerina/http;
import ballerina/log;

endpoint http:Client clientFinish {
    url: "http://mocky.io"
};


function main(string... arg){
    var respFinish = clientFinish->get("/v2/5b662ac6330000ec17f6aaba");

    match respFinish {
        http:Response response => {

            match (response.getTextPayload()) {
                string res =>log:printInfo(res);
                error err =>log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }

}

