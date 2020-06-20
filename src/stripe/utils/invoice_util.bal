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

type invoiceArr Invoice[];

function mapToInvoiceRecord(http:Response response) returns @tainted Invoice|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        check checkForErrorResponse(payload);
        convertJsonToCamelCase(payload);
        Invoice|error invoice = payload.cloneWithType(Invoice);
        if (invoice is error) {
            return Error("Response cannot be converted to Invoice record", invoice);
        } else {
            return invoice;
        }
    }        
}

function mapToInvoices(http:Response response) returns @tainted Invoice[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var invoices = payload.data;
        if (invoices is error) {
            return setJsonResError(invoices);
        }
        json invoicesJson = <json> invoices;
        check checkForErrorResponse(invoicesJson);
        json[] invoiceJsonArr = <json[]> invoicesJson;
        convertJsonArrayToCamelCase(invoiceJsonArr);

        Invoice[]|error invoicesList = invoiceJsonArr.cloneWithType(invoiceArr);
        if (invoicesList is error) {
            return Error("Response cannot be converted to Invoice record array", invoicesList);
        } else {
            return invoicesList;
        }
    }        
}

function mapToInvoiceItemRecord(http:Response response) returns @tainted InvoiceItem|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        check checkForErrorResponse(payload);
        convertJsonToCamelCase(payload);
        InvoiceItem|error invoiceItem = payload.cloneWithType(InvoiceItem);
        if (invoiceItem is error) {
            return Error("Response cannot be converted to InvoiceItem record", invoiceItem);
        } else {
            return invoiceItem;
        }
    }        
}
