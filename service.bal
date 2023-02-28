import ballerina/log;
import ballerina/http;

configurable string SERVICE_2_URL = ?;

service / on new http:Listener(9091) {

    resource function get greeting(string name) returns string|error {
        if name is "" {
            return error("name should not be empty!");
        }
        log:printInfo("received name to svc 1 is " + name);

        http:Client cl = check new (SERVICE_2_URL);

        http:Response re = <http:Response>check cl->/greeting(name = name);

        return "from chain: " + check re.getTextPayload();
    }
}
