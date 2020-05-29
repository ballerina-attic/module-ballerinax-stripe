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

function mapToProductRecord(http:Response response) returns @tainted Product|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        check checkForErrorResponse(payload);
        convertJsonToCamelCase(payload);
        Product|error product = Product.constructFrom(payload);
        if (product is error) {
            return Error(message = "Response cannot be converted to Product record", cause = product);
        } else {
            return product;
        }
    }        
}

function mapToProducts(http:Response response) returns @tainted Product[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var products = payload.data;
        if (products is error) {
            return setJsonResError(products);
        }
        json productsJson = <json> products;
        check checkForErrorResponse(productsJson);
        json[] productJsonArr = <json[]> productsJson;
        convertJsonArrayToCamelCase(productJsonArr);
        Product[]|error productList = Product[].constructFrom(productJsonArr);
        if (productList is error) {
            return Error(message = "Response cannot be converted to Product record array", cause = productList);
        } else {
            return productList;
        }
    }        
}
