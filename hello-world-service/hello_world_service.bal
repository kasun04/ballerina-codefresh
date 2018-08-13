import ballerina/http;
import ballerina/log;
import ballerinax/kubernetes;

// By default, Ballerina exposes a service via HTTP/1.1.

@kubernetes:Service {
    serviceType: "LoadBalancer",
    name: "ballerina-codefresh-demo" 
}
endpoint http:Listener listener {
    port: 9090
};

@kubernetes:Deployment {
    image: "r.cfcr.io/kasunindrasiri/kasunindrasiri/ballerina-codefresh-hello:master",
    name: "ballerina-codefresh-demo",
    buildImage: false, 
    imagePullPolicy: "Always"
}

service<http:Service> hello bind listener {

    // Invoke all resources with arguments of server connector and request.
    sayHello(endpoint caller, http:Request req) {
        http:Response res = new;


        // Use a util method to set a string payload.
        res.setPayload("Hello World!");

        // Send the response back to the caller.
        caller->respond(res) but { error e => log:printError(
                           "Error sending response", err = e) };
    }
}
