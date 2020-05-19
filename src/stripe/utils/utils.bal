// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/encoding;
import ballerina/http;
function getEncodedUri(string value) returns string {
    string|error encoded = encoding:encodeUriComponent(value, UTF8);
    if (encoded is string) {
        return encoded;
    } else {
        return value;
    }
}

function createPostRequest(http:Client stripeClient, string queryString, string path) returns http:Response|Error {
    http:Request req = new;
    req.setPayload(queryString);
    req.setHeader(CONTENT_TYPE, FORM_URL_ENCODED);
    http:Response|error response = stripeClient->post(path, req);
    if (response is error) {
        return setResError(response);
    } else {
        return response;
    }
}

function createGetRequest(http:Client stripeClient, string path) returns http:Response|Error {
    http:Response|error response = stripeClient->get(path);
    if (response is error) {
        return setResError(response);
    } else {
        return response;
    }
}

function createDeleteRequest(http:Client stripeClient, string path) returns http:Response|Error {
    http:Response|error response = stripeClient->delete(path);
    if (response is error) {
        return setResError(response);
    } else {
        return response;
    }
}

function setResError(error errorResponse) returns Error {
    return Error(message = "Error received from the Stripe server", cause = errorResponse);
}

function setJsonResError(error errorResponse) returns Error {
    return Error(message = "Error occurred while accessing the JSON payload of the response", 
                        cause = errorResponse);
}

function checkDeleteResponse(http:Response response) returns @tainted Error? {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var deleted = payload.deleted;
        if (deleted is error) {
            var message = payload.'error.message;
            if (message is string) {
                return setJsonResError(error(message));
            } else {
                return Error(message = "Error occurred while accessing the JSON payload of the response");
            }           
        } else {
            if (deleted.toString() == "true") {
                return ();
            }
        }
    }     
}

function checkForErrorResponse(json jsonResp) returns Error? {
    json|error errorResp = jsonResp.'error;
    if (errorResp is error) {
        return ();
    } else {    
        return Error(message = errorResp.toJsonString());
    }
}

function createQuery(string parent, any anyRecord) returns string {  
    string queryString = "";  
    if (anyRecord is record {| any|error...; |}) {        
        foreach [string, any|error] [key, value] in anyRecord.entries() {
            if (value is string|boolean|int|float) {
                queryString = queryString + printWithParent(parent, key, value) + AND;
            } else if (value is string[]) {
                string subQuery = "";
                foreach var str in value {
                    int count = 0;
                    if (key != TAX_RATES) {
                        subQuery = subQuery + str;
                        queryString = queryString + printWithParent(parent, key + "[]", subQuery) + AND;
                    } else {
                        subQuery = subQuery + "\"" + str + "\",";
                    }
                } 
                if (key == TAX_RATES) {
                    subQuery = subQuery.substring(0, subQuery.length() - 1);
                    queryString = queryString + printWithParent(parent, key + "[0]", "[" + subQuery + "]") + AND;
                }
            } else if (value is record {}) {
                if (parent == "") {
                    queryString = queryString + createQuery(key, value);
                } else {
                    queryString = queryString + createQuery(parent + "[" + key + "]", value);
                }
            } 
            else if (value is record {}[]) {
                int count = 0;
                foreach var recordItem in value {
                    if (parent == "") {
                        queryString = queryString + createQuery(key + "[" + count.toString() + "]", recordItem);
                    } else {
                        queryString = queryString + createQuery(parent + "[" + key + "][" + count.toString() + "]", recordItem);
                    }
                    count = count + 1;
                }
            }
        }
    }
    return queryString;
}

function printWithParent(string parent, string key, any value) returns string {
    string parentString = "";
    if (parent == "") {
        parentString = key + "=" + getEncodedUri(value.toString());
    } else {
        parentString = parent + "[" + key + "]=" + getEncodedUri(value.toString());
    }
    return parentString;
}
