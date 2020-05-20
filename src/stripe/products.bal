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

# Represents the Products in Stripe. This acts as a client to create, retrieve, update, 
# delete, and list the products in a Stripe Account.
public type Products client object {

    private http:Client products;
    private string path = "/v1/products";

    public function __init(http:Client stripeClient) {
      self.products = stripeClient;  
    }

    # Creates a product.
    #
    # + product - Product configurations
    # + return - `Product` record or else a `stripe:Error` in case of a failure
    public remote function create(Product product) returns @tainted Product|Error {
        string queryString = createQuery(EMPTY, product);
        http:Response response = check createPostRequest(self.products, queryString, self.path);
        return mapToProductRecord(response);
    }
 
   # Retrieves a product.
   #
   # + productId - Product ID
   # + return - `Product` record or else a `stripe:Error` in case of a failure
   public remote function retrieve(string productId) returns @tainted Product|Error {
     string path = self.path + "/" + productId;
     http:Response response = check createGetRequest(self.products, path);
     return mapToProductRecord(response);
   } 
   
   # Updates a Product.
   #
   # + productId - Product ID
   # + product - Product configurations
   # + return - `Product` record or else a `stripe:Error` in case of a failure
   public remote function update(string productId, Product product) returns @tainted Product|Error {
     string path = self.path + "/" + productId;
     string queryString = createQuery(EMPTY, product);
     http:Response response = check createPostRequest(self.products, queryString, path);
     return mapToProductRecord(response);
   }
 
   # Deletes a product.
   #
   # + productId - Product ID
   # + return - `()` or else a `stripe:Error` in case of a failure
   public remote function delete(string productId) returns @tainted Error? {
     string path = self.path + "/" + productId;
     http:Response response = check createDeleteRequest(self.products, path);
     return checkDeleteResponse(response);
   }
 
   # Lists all products.
   #
   # + return - An array of `Product` records or else a `stripe:Error`
   public remote function list() returns @tainted Product[]|Error {
     http:Response response = check createGetRequest(self.products, self.path);
     return mapToProducts(response);
   }
};
