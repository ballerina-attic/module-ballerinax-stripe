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

function mapToPlanRecord(http:Response response) returns @tainted Plan|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        check checkForErrorResponse(payload);
        Plan|error plan = Plan.constructFrom(payload);
        if (plan is error) {
            return Error(message = "Response cannot be converted to Plan record", cause = plan);
        } else {
            return plan;
        }
    }        
}

function mapToPlans(http:Response response) returns @tainted Plan[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var plans = payload.data;
        if (plans is error) {
            return setJsonResError(plans);
        }
        json plansJson = <json> plans;
        check checkForErrorResponse(plansJson);
        Plan[]|error plansList = Plan[].constructFrom(plansJson);
        if (plansList is error) {
            return Error(message = "Response cannot be converted to Plan record array", cause = plansList);
        } else {
            return plansList;
        }
    }        
}
