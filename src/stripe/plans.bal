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

public type Plans client object {
    private http:Client plans;
    private string path = "/v1/plans";
    
    public function __init(http:Client stripeClient) {
       self.plans = stripeClient;
    }

   # Creates a plan.
   #
   # + plan - Billing plan configurations
   # + return - `Plan` record or else a `stripe:Error` in case of a failure
   public remote function create(Plan plan) returns @tainted Plan|Error {
        string queryString = createQuery(EMPTY, plan);
        http:Response response = check createPostRequest(self.plans, queryString, self.path);
        return mapToPlanRecord(response);
   }
 
   # Retrieves a plan.
   #
   # + planId - Plan ID
   # + return - `Plan` record or else a `stripe:Error` in case of a failure
   public remote function retrieve(string planId) returns @tainted Plan|Error {
        string path = self.path + "/" + planId;
        http:Response response = check createGetRequest(self.plans, path);
        return mapToPlanRecord(response);
   }
 
   # Updates a plan.
   #
   # + planId - Plan ID
   # + plan - Plan configurations
   # + return - `Plan` record or else a `stripe:Error` in case of a failure
   public remote function update(string planId, Plan plan) returns @tainted Plan|Error {
        string path = self.path + "/" + planId;
        string queryString = createQuery(EMPTY, plan);
        http:Response response = check createPostRequest(self.plans, queryString, path);
        return mapToPlanRecord(response);
   }
 
   # Deletes a plan.
   #
   # + planId - Plan ID
   # + return - `()` or else a `stripe:Error` in case of a failure
   public remote function delete(string planId) returns @tainted Error? {
        string path = self.path + "/" + planId;
        http:Response response = check createDeleteRequest(self.plans, path);
        return checkDeleteResponse(response);
   }
 
   # Lists all plans.
   #
   # + return - An array of `Plan` records or else a `stripe:Error`
   public remote function list() returns @tainted Plan[]|Error {
        http:Response response = check createGetRequest(self.plans, self.path);
        return mapToPlans(response);
   }
};
