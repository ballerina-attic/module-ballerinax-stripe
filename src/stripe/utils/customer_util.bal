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

type customerArr Customer[];

function mapToCustomerRecord(http:Response response) returns @tainted Customer|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        check checkForErrorResponse(payload);
        convertJsonToCamelCase(payload);
        Customer|error customer = payload.cloneWithType(Customer);
        if (customer is error) {
            return Error("Response cannot be converted to Customer record", customer);
        } else {
            return customer;
        }
    }        
}

function mapToCustomers(http:Response response) returns @tainted Customer[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var customers = payload.data;
        if (customers is error) {
            return setJsonResError(customers);
        }
        json customersJson = <json> customers;
        check checkForErrorResponse(customersJson);
        json[] customerJsonArr = <json[]> customersJson;
        convertJsonArrayToCamelCase(customerJsonArr);
        Customer[]|error customerList = customerJsonArr.cloneWithType(customerArr);
        if (customerList is error) {
            return Error("Response cannot be converted to Customers record array", customerList);
        } else {
            return customerList;
        }
    }        
}
