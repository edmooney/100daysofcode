import ballerina/io;

function main(string... args){
    worker w1 {
        io:println("Hello 100days #m");
    }

    worker w2 {
        io:println("Hello 100days #n");

    }

    worker w3 {
        io:println("Hello 100days #k");
    }
}

