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
import ballerina/stringutils;

# Represents Charges in Stripe Account. This acts as a client to create, retrieve, update, capture, and list 
# the charges in a Stripe Account
public type Charges client object {

    private http:Client charges;
    private string path = "/v1/charges";

    public function __init(http:Client stripeClient) {
       self.charges = stripeClient;
    }

    # Creates a charge.
    #
    # + charge - Charge configurations
    # + return - `Charge` record or else a `stripe:Error` in case of a failure
    public remote function create(Charge charge) returns @tainted Charge|Error {
        string queryString = createQuery(EMPTY, charge);
        queryString = stringutils:replace(queryString, SOURCE_ID, SOURCE);
        http:Response response = check createPostRequest(self.charges, queryString, self.path);
        return mapToChargeRecord(response); 
    }

    # Retrieves a charge.
    #
    # + chargeId - Charge ID
    # + return - `Charge` record or else a `stripe:Error` in case of a failure
    public remote function retrieve(string chargeId) returns @tainted Charge|Error {
        string path = self.path + "/" + chargeId;
        http:Response response = check createGetRequest(self.charges, path);
        return mapToChargeRecord(response);
    }

    # Updates a charge.
    #
    # + chargeId - Charge ID
    # + charge - Charge configurations
    # + return - `Charge` record or else a `stripe:Error` in case of a failure
    public remote function update(string chargeId, Charge charge) returns @tainted Charge|Error {
        string path = self.path + "/" + chargeId;
        string queryString = createQuery(EMPTY, charge);
        http:Response response = check createPostRequest(self.charges, queryString, path);
        return mapToChargeRecord(response);
    }

    # Captures a charge.
    #
    # + chargeId - Charge ID
    # + capture - Capture charge configurations
    # + return - `Charge` record or else a `stripe:Error` if it is already refunded, expired, captured, or an invalid capture amount is specified.
    public remote function capture(string chargeId, Capture? capture = ()) returns @tainted Charge|Error {
        string path = self.path + "/" + chargeId + "/capture";
        string queryString = EMPTY;
        if (capture is Capture) {
            queryString = createQuery(EMPTY, capture);
        }
        http:Response response = check createPostRequest(self.charges, queryString, path);
        return mapToChargeRecord(response);
    }

    # Lists all charges.
    #
    # + return - An array of `Charge` records or else a `stripe:Error` for non-existent customer IDs
    public remote function list() returns @tainted Charge[]|Error {
        http:Response response = check createGetRequest(self.charges, self.path);
        return mapToCharges(response);
    }
};
