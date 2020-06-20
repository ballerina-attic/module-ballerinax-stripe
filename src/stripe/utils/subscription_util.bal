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

import ballerina/http;

type subscriptionArr Subscription[];

function mapToSubscriptionRecord(http:Response response) returns @tainted Subscription|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        check checkForErrorResponse(payload);    
        convertJsonToCamelCase(payload);
        Subscription|error subscription = payload.cloneWithType(Subscription);
        if (subscription is error) {
            return Error("Response cannot be converted to Subscription record", subscription);
        } else {
            return subscription;
        }
    }        
}

function mapToSubscriptions(http:Response response) returns @tainted Subscription[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var subscriptions = payload.data;
        if (subscriptions is error) {
            return setJsonResError(subscriptions);
        }
        json subscriptionsJson = <json> subscriptions;
        check checkForErrorResponse(subscriptionsJson);
        json[] subscriptionsJsonArr = <json[]> subscriptionsJson;
        convertJsonArrayToCamelCase(subscriptionsJsonArr);
        Subscription[]|error subscriptionsList = subscriptionsJsonArr.cloneWithType(subscriptionArr);
        if (subscriptionsList is error) {
            return Error("Response cannot be converted to Subscription record array", subscriptionsList);
        } else {
            return subscriptionsList;
        }
    }        
}
