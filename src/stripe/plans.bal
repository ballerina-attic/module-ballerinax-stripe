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

# Represents the Billing Plans in Stripe. This acts as a client to create, 
# retrieve, update, delete, and list the plans in a Stripe Account.
public type Plans client object {
    private http:Client plans;
    
    function init(http:Client stripeClient) {
       self.plans = stripeClient;
    }

    # Creates a plan.
    # ```ballerina
    # stripe:Plan planParams = { currency: "usd", interval: stripe:MONTH, product: "<product-id>", amount: 2000 };
    # stripe:Plan|stripe:Error createdPlan = plans->create(planParams);
    # ```
    #
    # + plan - Billing plan configurations
    # + return - `Plan` record or else a `stripe:Error` in case of a failure
    public remote function create(Plan plan) returns @tainted Plan|Error {
        string queryString = createQuery(EMPTY, plan);
        http:Response response = check createPostRequest(self.plans, queryString, PLAN_PATH);
        return mapToPlanRecord(response);
    }
 
    # Retrieves a plan.
    # ```ballerina
    # stripe:Plan|stripe:Error retrievedPlan = plans->retrieve("<plan-id>");
    # ```
    #
    # + planId - Plan ID
    # + return - `Plan` record or else a `stripe:Error` in case of a failure
    public remote function retrieve(string planId) returns @tainted Plan|Error {
        string path = PLAN_PATH + BACK_SLASH + planId;
        http:Response response = check createGetRequest(self.plans, path);
        return mapToPlanRecord(response);
    }
 
    # Updates a plan.
    # ```ballerina
    # stripe:Plan planParams = { nickname: "PlanNickName" };
    # stripe:Plan|stripe:Error updatedPlan = plans->update("<plan-id>", planParams);
    # ```
    #
    # + planId - Plan ID
    # + plan - Plan configurations
    # + return - `Plan` record or else a `stripe:Error` in case of a failure
    public remote function update(string planId, Plan plan) returns @tainted Plan|Error {
        string path = PLAN_PATH + BACK_SLASH + planId;
        string queryString = createQuery(EMPTY, plan);
        http:Response response = check createPostRequest(self.plans, queryString, path);
        return mapToPlanRecord(response);
    }
 
    # Deletes a plan.
    # ```ballerina
    # stripe:Error? deletePlan = plans->delete("<plan-id>");
    # ```
    #
    # + planId - Plan ID
    # + return - `()` or else a `stripe:Error` in case of a failure
    public remote function delete(string planId) returns Error? {
        string path = PLAN_PATH + BACK_SLASH + planId;
        http:Response response = check createDeleteRequest(self.plans, path);
        return checkDeleteResponse(response);
    }
 
    # Lists all plans.
    # ```ballerina
    # stripe:Plan[]|stripe:Error plansList = plans->list();
    # ```
    #
    # + return - An array of `Plan` records or else a `stripe:Error`
    public remote function list() returns @tainted Plan[]|Error {
        http:Response response = check createGetRequest(self.plans, PLAN_PATH);
        return mapToPlans(response);
    }
};
