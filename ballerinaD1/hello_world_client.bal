
import ballerina/http;
import ballerina/log;

endpoint http:Client clientEP {
    url:"http://www.mocky.io"
};

function main(string... arg){

    var resp = clientEP->get("/v2/5ae082123200006b00510c3d/");

    match resp {
        http:Response response => {
            match (response.getTextPayload()){
                string res => log:printInfo(res);
                error err => log:printError(err.message);
            }
        }
        error err => log:printError(err.message);
    }

}