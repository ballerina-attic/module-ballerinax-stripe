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

# Represents the Invoices in Stripe. This acts as a client to create, retrieve, update, delete, finalize, pay, 
# send for manual payment, void, mark uncollectible, and list the invoices in a Stripe Account
public type Invoices client object {
    private http:Client invoices;
    
    function __init(http:Client stripeClient) {
       self.invoices = stripeClient;
    }

    # Creates an invoice.
    # ```ballerina
    # stripe:Invoice invoiceParams = { customer: "<customer-id>" };
    # stripe:Invoice|stripe:Error createdInvoice = invoices->create(invoiceParams); 
    # ```
    # 
    # + invoice - Invoice configurations
    # + return - `Invoice` record or else a `stripe:Error` in case of a failure
    public remote function create(Invoice invoice) returns @tainted Invoice|Error {
        string queryString = createQuery(EMPTY, invoice);
        queryString = stringutils:replace(queryString, TAX_RATES, DEFAULT_TAX_RATES);
        http:Response response = check createPostRequest(self.invoices, queryString, INVOICE_PATH);
        return mapToInvoiceRecord(response);
    }

    # Retrieves an invoice.
    #```ballerina
    # stripe:Invoice|stripe:Error retrievedInvoice = invoices->retrieve("<invoice-id>");
    # ```
    # 
    # + invoiceId - Invoice ID
    # + return - `Invoice` record or else a `stripe:Error` in case of a failure
    public remote function retrieve(string invoiceId) returns @tainted Invoice|Error {
        string path = INVOICE_PATH + BACK_SLASH + invoiceId;
        http:Response response = check createGetRequest(self.invoices, path);
        return mapToInvoiceRecord(response);
    }

    # Updates an invoice.
    # ```ballerina
    # stripe:Invoice invoiceParams = { description: "update description" };
    # stripe:Invoice|stripe:Error updatedInvoice = invoices->update("<invoice-id>", invoiceParams);
    # ```
    #
    # + invoiceId - Invoice ID
    # + invoice - Invoice configurations
    # + return - `Invoice` record or else a `stripe:Error` in case of a failure
    public remote function update(string invoiceId, Invoice invoice) returns @tainted Invoice|Error {
        string path = INVOICE_PATH + BACK_SLASH + invoiceId;
        string queryString = createQuery(EMPTY, invoice);
        http:Response response = check createPostRequest(self.invoices, queryString, path);
        return mapToInvoiceRecord(response);
    }

    # Deletes a draft invoice.
    # ```ballerina
    # stripe:Error? deleteDraft = invoices->deleteDraft("<invoice-id>");
    # ```
    #
    # + invoiceId - Invoice ID
    # + return - `()` if the invoice is deleted succesfully or else a `stripe:Error` if the invoice has been already deleted
    public remote function deleteDraft(string invoiceId) returns Error? {
        string path = INVOICE_PATH + BACK_SLASH + invoiceId;
        http:Response response = check createDeleteRequest(self.invoices, path);
        return checkDeleteResponse(response);
    }

    # Finalizes an invoice.
    # ```ballerina
    # stripe:Invoice|stripe:Error finalizedInvoice = invoices->finalize("<invoice-id>");
    # ```
    #
    # + invoiceId - Invoice ID
    # + autoAdvance - `true` if Stripe performs automatic collection of the invoice or `false`
    # + return - `Invoice` record or a `stripe:Error` in case of a failure
    public remote function finalize(string invoiceId, boolean? autoAdvance = false) returns @tainted Invoice|Error {
        string path = INVOICE_PATH + BACK_SLASH + invoiceId + FINALIZE_PATH;
        string queryString = AUTO_ADVANCE + autoAdvance.toString();
        http:Response response = check createPostRequest(self.invoices, queryString, path);
        return mapToInvoiceRecord(response);
    }

    # Pays an invoice.
    # ```ballerina
    # stripe:Invoice|stripe:Error paidInvoice = invoices->pay("<invoice-id>");
    # ```
    #
    # + invoiceId - Invoice ID
    # + invoicePay - Parameters to be used when paying an invoice
    # + return - `Invoice` record or a `stripe:Error` in case of a failure
    public remote function pay(string invoiceId, InvoicePay? invoicePay = ()) returns @tainted Invoice|Error {
        string invoicePayQuery = EMPTY;
        string path = INVOICE_PATH + BACK_SLASH + invoiceId + PAY_PATH;
        if (invoicePay is InvoicePay) {
            invoicePayQuery = createQuery(EMPTY, invoicePay);
        }
        http:Response response = check createPostRequest(self.invoices, invoicePayQuery, path);
        return mapToInvoiceRecord(response);
    }

    # Sends an invoice for manual payment.
    # ```ballerina
    # stripe:Invoice|stripe:Error invoice = invoices->sendForMannualPayment("<invoice-id>");
    # ```
    #
    # + invoiceId - Invoice ID
    # + return - `Invoice` record or a `stripe:Error` in case of a failure
    public remote function sendForMannualPayment(string invoiceId) returns @tainted Invoice|Error {
        string path = INVOICE_PATH + BACK_SLASH + invoiceId + SEND_PATH;
        http:Response response = check createPostRequest(self.invoices, EMPTY, path);
        return mapToInvoiceRecord(response);
    }

    # Voids an invoice.
    # ```ballerina
    # stripe:Invoice|stripe:Error voidInvoice = invoices->void("<invoice-id>");
    # ```
    #
    # + invoiceId - Invoice ID
    # + return - `Invoice` record or a `stripe:Error` in case of a failure
    public remote function void(string invoiceId) returns @tainted Invoice|Error {
        string path = INVOICE_PATH + BACK_SLASH + invoiceId + VOID_PATH;
        http:Response response = check createPostRequest(self.invoices, EMPTY, path);
        return mapToInvoiceRecord(response);
    }

    # Marks an invoice as uncollectible.
    # ```ballerina
    # stripe:Invoice|stripe:Error uncollectibleInvoice = invoices->markInvoiceUncollectible("<invoice-id>");
    # ```
    #
    # + invoiceId - Invoice ID
    # + return - `Invoice` record or a `stripe:Error` in case of a failure
    public remote function markInvoiceUncollectible(string invoiceId) returns @tainted Invoice|Error {
        string path = INVOICE_PATH + BACK_SLASH + invoiceId + MARK_UNCOLLECTIBLE_PATH;
        http:Response response = check createPostRequest(self.invoices, EMPTY, path);
        return mapToInvoiceRecord(response);
    }

    # Lists all invoices.
    # ```ballerina
    # stripe:Invoice[]|stripe:Error invoicesList = invoices->list();
    # ```
    #
    # + return - An array of `Invoice` records, or else a `stripe:Error` in case of a failure
    public remote function list() returns @tainted Invoice[]|Error {
        http:Response response = check createGetRequest(self.invoices, INVOICE_PATH);
        return mapToInvoices(response);
    }

    # Creates an invoice item.
    # ```ballerina
    # stripe:InvoiceItem invoiceItem = { customer : "<customer-id>" };
    # stripe:InvoiceItem|Error createdInvoiceItem = invoices->createInvoiceItem(invoiceItem);
    # ```
    #
    # + invoiceItem - Parameters to be used when creating an invoice item
    # + return - The `InvoiceItem` record or a `stripe:Error` in case of a failure
    public remote function createInvoiceItem(InvoiceItem invoiceItem) returns @tainted InvoiceItem|Error {
        string invoiceItemQuery = createQuery(EMPTY, invoiceItem);
        invoiceItemQuery = stringutils:replace(invoiceItemQuery, PRICE_ID, PRICE);
        http:Response response = check createPostRequest(self.invoices, invoiceItemQuery, INVOICE_ITEM_PATH);
        return mapToInvoiceItemRecord(response);
    }
};
