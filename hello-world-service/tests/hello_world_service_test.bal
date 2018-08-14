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
    endpoint http:Client httpEndpoint { url: "http://localhost:9090" };
    string response1 = "Hello World from Ballerina!";

    var response = httpEndpoint->get("/hello/sayHello");
    match response {
        http:Response resp => {
            var res = check resp.getTextPayload();
            test:assertEquals(res, response1);
        }
        error err => test:assertFail(msg = "Failed to call the endpoint:");
    }
}

function stopService() {

}