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

import ballerina/test;
import ballerina/system;

string token = system:getEnv("stripeToken");

Account stripeClient = new(token);
Customers customers = stripeClient.customers();
Products products = stripeClient.products();
Plans plans = stripeClient.plans();
Subscriptions subscriptions = stripeClient.subscriptions();
Charges charges = stripeClient.charges();
Invoices invoices = stripeClient.invoices();
string customerId = "";
string productId = "";
string planId = "";

@test:Config {}
function testCustomerFunctions() {
    Customer|Error createdCustomer = customers->create(customerParams);
    if (createdCustomer is Error) {
        test:assertFail(msg = createdCustomer.message());
    } else {
        anydata result = createdCustomer["id"];
        if (result is string) {
            customerId = <@untainted> result;
        } 
    }

    Customer|Error retrievedCustomer = customers->retrieve(customerId);
    if (retrievedCustomer is Error) {
        test:assertFail(msg = retrievedCustomer.message());
    } else {
        string? email = retrievedCustomer["email"];
        if (email is string) {
            test:assertEquals(email, "b7astripe@gmail.com");
        } else {
            test:assertFail(msg = "Expected email not found");
        }
    }

    Customer|Error updatedCustomer = customers->update(customerId, customerUpdateParams);
    if (updatedCustomer is Error) {
        test:assertFail(msg = updatedCustomer.message());
    } else {
        string? description = updatedCustomer["description"];
        if (description is string) {
            test:assertEquals(description, "Updated description");
        } else {
            test:assertFail(msg = "Expected description not found");
        }
    }

    Customer[]|Error listCustomers = customers->list();
    if (listCustomers is Error) {
        test:assertFail(msg = listCustomers.message());
    }

    Error? deletecustomer = customers->delete(customerId);
    if (deletecustomer is Error) {
        test:assertFail(msg = deletecustomer.message());
    }
}

@test:Config {}
function testProductFunctions() {
    Product|Error createdProduct = products->create(product);
    if (createdProduct is Error) {
        test:assertFail(msg = createdProduct.message());
    } else {
        anydata result = createdProduct["id"];
        if (result is string) {
            productId = <@untainted> result;
        }
    }

    Product|Error retrievedProduct = products->retrieve(productId);
    if (retrievedProduct is Error) {
        test:assertFail(msg = retrievedProduct.message());
    } else {
        string? caption = retrievedProduct["caption"];
        if (caption is string) {
            test:assertEquals(caption, "thisisthecaption");
        } else {
            test:assertFail(msg = "Expected caption not found");
        }
    }

    Product|Error updatedProduct = products->update(productId, updateProduct);
    if (updatedProduct is Error) {
        test:assertFail(msg = updatedProduct.message());
    } else {
        string? description = updatedProduct["description"];
        if (description is string) {
           test:assertEquals(description, "Updated description");
        } else {
            test:assertFail(msg = "Expected description not found");
        }
    }

    Product[]|Error listProducts = products->list();
    if (listProducts is Error) {
        test:assertFail(msg = listProducts.message());
    }

    Error? deleteProduct = products->delete(productId);
    if (deleteProduct is Error) {
        test:assertFail(msg = deleteProduct.message());
    }
}

@test:Config {}
function testPlanFunctions() {
    Plan|Error createdPlan = plans->create(plan);
    if (createdPlan is Error) {
        test:assertFail(msg = createdPlan.message());
    } else {
        anydata result = createdPlan["id"];
        if (result is string) {
            planId = <@untainted> result;
        }
        anydata productResult = createdPlan["product"];
        if (productResult is string) {
            productId = <@untainted> productResult;
        }
    }

    Plan|Error retrievedPlan = plans->retrieve(planId);
    if (retrievedPlan is Error) {
        test:assertFail(msg = retrievedPlan.message());
    } else {
        string? billingScheme = retrievedPlan["billingScheme"];
        if (billingScheme is string) {
            test:assertEquals(billingScheme, "tiered");
        } else {
            test:assertFail(msg = "Billing scheme is ()");
        }
    }

    Plan|Error updatedPlan = plans->update(planId, updatePlan);
    if (updatedPlan is Error) {
        test:assertFail(msg = updatedPlan.message());
    } else {
        string? nickName = updatedPlan["nickname"];
        if (nickName is string) {
           test:assertEquals(nickName, "RedPursePlan1");
        } else {
            test:assertFail(msg = "nickName is ()");
        }
    }

    Plan[]|Error listPlans = plans->list();
    if (listPlans is Error) {
        test:assertFail(msg = listPlans.message());
    }

    Error? deletePlan = plans->delete(planId);
    if (deletePlan is Error) {
        test:assertFail(msg = deletePlan.message());
    }

    Error? deleteProduct = products->delete(productId);
    if (deleteProduct is Error) {
        test:assertFail(msg = deleteProduct.message());
    }
}

@test:Config {}
function testSubscriptionFunctions() {
    Subscription|Error retrievedSubscription = subscriptions->retrieve("sub_HHWxOzSGhAnDfZ");
    if (retrievedSubscription is Error) {
        test:assertFail(msg = retrievedSubscription.message());
    } else {
        string? method = retrievedSubscription["collectionMethod"];
        if (method is string) {
            test:assertEquals(method, "send_invoice");
        } else {
            test:assertFail(msg = "method is ()");
        }
    }

    Subscription[]|Error listSubscriptions = subscriptions->list();
    if (listSubscriptions is Error) {
        test:assertFail(msg = listSubscriptions.message());
    }

    Subscription|Error updatedSubscription = subscriptions->update("sub_HHWxOzSGhAnDfZ", updateSubs);
    if (updatedSubscription is Error) {
        test:assertFail(msg = updatedSubscription.message());
    } else {
        string? method = updatedSubscription["collectionMethod"];
        if (method is string) {
            test:assertEquals(method, "send_invoice");
        } else {
            test:assertFail(msg = "method is ()");
        }
    } 
}

@test:Config {}
function testChargeFunctions() {
    Charge|Error retrievedCharge= charges->retrieve("ch_1Gjz58J7y0eOXqiMuskxrhFa");
    if (retrievedCharge is Error) {
        test:assertFail(msg = retrievedCharge.message());
    } else {
        anydata email = retrievedCharge["receiptEmail"];
        if (email is string) {
            test:assertEquals(email, "bhashi@gmail.com");
        } else {
            test:assertFail(msg = "email is ()");
        }
    }

    Charge[]|Error listCharges = charges->list();
    if (listCharges is Error) {
        test:assertFail(msg = listCharges.message());
    }
}
    
@test:Config {}
function testInvoiceFunctions() {
    Invoice|Error retrievedInvoice= invoices->retrieve("in_1GkAJKJ7y0eOXqiMsWkHIA4m");
    if (retrievedInvoice is Error) {
        test:assertFail(msg = retrievedInvoice.message());
    } else {
        string? customerId = retrievedInvoice["customer"];
        if (customerId is string) {
            test:assertEquals(customerId, "cus_HHWIJPAUfcXYNH");
        } else {
            test:assertFail(msg = "Expected customerId not found");
        }
    }

    Invoice|Error updatedInvoice= invoices->update("in_1GkAJKJ7y0eOXqiMsWkHIA4m", updateInvo);
    if (updatedInvoice is Error) {
        test:assertFail(msg = updatedInvoice.message());
    } else {
        string? description = updatedInvoice["description"];
        if (description is string) {
            test:assertEquals(description, "update description");
        } else {
            test:assertFail(msg = "Expected description not found");
        }
    }

    Invoice[]|Error listInvoices = invoices->list();
    if (listInvoices is Error) {
        test:assertFail(msg = listInvoices.message());
    }
}
