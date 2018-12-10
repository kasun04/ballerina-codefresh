import ballerina/test;
import ballerina/io;
import ballerina/http;

boolean serviceStarted;

function startService() {
}

@test:Config {
    before: "startService",
    after: "stopService"
}
function testFunc() {
    http:Client httpEndpoint = new("http://localhost:9090");

    string response1 = "Hello World from Ballerina!";

    var response = httpEndpoint->get("/hello/sayHello");
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), response1);
    } else if (response is error) {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}

function stopService() {

}