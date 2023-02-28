import ballerina/log;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    resource function get greeting(string name) returns string|error {
        if name is "" {
            return error("name should not be empty!");
        }
        log:printInfo("greeting name: " + name);
        return "greeting, " + name;
    }

    resource function get hello(string name) returns string|error {
        if name is "" {
            return error("name should not be empty!");
        }
        log:printInfo("hello name: " + name);
        return "hello, " + name;
    }
}
