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

# Represents Customers in Stripe Account. This acts as a client to create, retrieve, update, delete, and 
# list the customers in a Stripe Account.
public type Customers client object {
    private http:Client customers;
    
    function __init(http:Client stripeClient) {
       self.customers = stripeClient;
    }

    # Creates a customer.
    #
    # + customer - Customer configurations
    # + return - `Customer` record or else a `stripe:Error` in case of a failure
    public remote function create(Customer customer) returns @tainted Customer|Error {
        string queryString = createQuery(EMPTY, customer);
        http:Response response = check createPostRequest(self.customers, queryString, CUSTOMER_PATH);
        return mapToCustomerRecord(response);        
    }

    # Retrieves a customer.
    #
    # + customerId - Customer ID
    # + return - `Customer` record or else a `stripe:Error` in case of a failure
    public remote function retrieve(string customerId) returns @tainted Customer|Error {
        string path = CUSTOMER_PATH + BACK_SLASH + customerId;
        http:Response response = check createGetRequest(self.customers, path);
        return mapToCustomerRecord(response);
    }

    # Updates a customer.
    #
    # + customerId - Customer ID
    # + customer - Customer configurations
    # + return - `Customer` record or else a `stripe:Error` in case of a failure
    public remote function update(string customerId, Customer customer) returns @tainted Customer|Error {
        string path = CUSTOMER_PATH + BACK_SLASH + customerId;
        string queryString = createQuery(EMPTY, customer);
        http:Response response = check createPostRequest(self.customers, queryString, path);
        return mapToCustomerRecord(response);
    }

    # Deletes a customer.
    #
    # + customerId - Customer ID
    # + return - `()` or else a `stripe:Error` in case of a failure
    public remote function delete(string customerId) returns Error? {
        string path = CUSTOMER_PATH + BACK_SLASH + customerId;
        http:Response response = check createDeleteRequest(self.customers, path);
        return checkDeleteResponse(response);
    }

    # Lists all customers.
    #
    # + return - An array of `Customer` records or else a `stripe:Error` in case of a failure
    public remote function list() returns @tainted Customer[]|Error {
        http:Response response = check createGetRequest(self.customers, CUSTOMER_PATH);
        return mapToCustomers(response);
    }
};
