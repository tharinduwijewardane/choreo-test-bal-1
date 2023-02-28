import ballerina/http;
import ballerina/log;

service / on new http:Listener(9092) {

    resource function get greeting(http:Caller caller, http:Request req) returns error? {

        log:printInfo(req.getHeaderNames().toString());
        log:printInfo("X-B3-TraceId header value is " + check req.getHeader("X-B3-TraceId"));
        log:printInfo("X-B3-SpanId header value is " + check req.getHeader("X-B3-SpanId"));
        log:printInfo("X-B3-Sampled header value is " + check req.getHeader("X-B3-Sampled"));
        string name = req.getQueryParamValue("name").toString();
        if name is "" {
            return error("name should not be empty!");
        }

        log:printInfo("received name to svc 2 is " + name);

        http:Response res = new;
        res.setTextPayload("Hello, " + name);
        error? result = caller->respond(res);
        if result is error {
            log:printError("error responding");
        }
    }
}
