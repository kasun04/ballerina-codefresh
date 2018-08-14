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
    imagePullPolicy: "Always", 
    imagePullSecrets: ["codefresh-generated-r.cfcr.io-cfcr-default"]
}

service<http:Service> hello bind listener {
    sayHello(endpoint caller, http:Request req) {
        http:Response res = new;
        res.setPayload("Hello World!");
        _ = caller->respond(res);
    }
}
