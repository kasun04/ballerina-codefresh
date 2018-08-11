import ballerina/http;
import ballerina/log;
import ballerinax/kubernetes;

// By default, Ballerina exposes a service via HTTP/1.1.

@kubernetes:Service {
    serviceType: "NodePort",
    name: "ballerina-codefresh-demo"
}
endpoint http:Listener listener {
    port: 9090
};

@kubernetes:Deployment {
    image: "kasunindrasiri/ballerina-codefresh-hello",
    name: "ballerina-codefresh-demo",
    buildImage: false
}

service<http:Service> hello bind listener {

    // Invoke all resources with arguments of server connector and request.
    sayHello(endpoint caller, http:Request req) {
        http:Response res = new;
        // Use a util method to set a string payload.
        res.setPayload("Hello, World with Codefresh!");

        // Send the response back to the caller.
        caller->respond(res) but { error e => log:printError(
                           "Error sending response", err = e) };
    }
}
