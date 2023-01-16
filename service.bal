import ballerina/http;

listener http:Listener listenerName = check new (9090);

service /echo on listenerName {

    resource function post .(http:Caller caller, http:Request request) returns error? {

        check caller->respond(request.getTextPayload());

    }

}
