import ballerina/http;
import ballerina/log;
import ballerinax/kubernetes;

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
        res.setPayload("Hello World from Ballerina and Codefresh!");
        _ = caller->respond(res);
    }
}
