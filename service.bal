import ballerina/log;
import ballerina/http;

configurable string SERVICE_2_SVC_PORT = ?;
configurable string SERVICE_2_URL = ?;
configurable string APIM_TOKEN_ENDPOINT = ?;
configurable string SERVICE_2_CONSUMER_KEY = ?;
configurable string SERVICE_2_CONSUMER_SECRET = ?;

http:Client serviceTwo = check new (SERVICE_2_URL,
    auth = {
        tokenUrl: APIM_TOKEN_ENDPOINT,
        clientId: SERVICE_2_CONSUMER_KEY,
        clientSecret: SERVICE_2_CONSUMER_SECRET,
        scopes: ["admin"]
    }
);

service / on new http:Listener(9091) {

    resource function get greeting(string name) returns string|error {
        if name is "" {
            return error("name should not be empty!");
        }
        log:printInfo("received name to svc 1 is " + name);

        http:Client cl = check new (SERVICE_2_SVC_PORT);
        http:Response re = <http:Response>check cl->/greeting(name = name);

        return "from chain: " + check re.getTextPayload();
    }

    resource function get routeExt(string name) returns string|error {
        if name is "" {
            return error("name should not be empty!");
        }
        log:printInfo("received name to svc 1 is " + name);

        http:Response re = <http:Response>check serviceTwo->/greeting(name = name);

        return "from chain: " + check re.getTextPayload();
    }
}
