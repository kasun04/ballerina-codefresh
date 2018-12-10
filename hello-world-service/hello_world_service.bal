import ballerina/http;
import ballerina/log;
import ballerinax/kubernetes;

@kubernetes:Service {
    serviceType: "LoadBalancer",
    name: "ballerina-codefresh-demo" 
}

@kubernetes:Deployment {
    singleYAML: false, 
    baseImage:"kasunindrasiri/ballerina_cf:0.990.0",
    image: "r.cfcr.io/kasunindrasiri/kasunindrasiri/ballerina-codefresh-hello:master",
    name: "ballerina-codefresh-demo",
    buildImage: false,
    imagePullPolicy: "Always", 
    imagePullSecrets: ["codefresh-generated-r.cfcr.io-cfcr-default"]
}

service hello on new http:Listener(9090) {
    resource function sayHello (http:Caller caller, http:Request req) {
        http:Response res = new;
        res.setPayload("Hello World from Ballerina!");
        _ = caller->respond(res);
    }
}
