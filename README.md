# module-ballerinax-stripe

This module allows you to access the Stripe API through Ballerina. Stripe is a service that allows users (specifically developers) to accept payments online. With the Stripe application, users can keep track of payments, search past payments, create recurring charges, and keep track of customers.

The following sections provide you details on how to use the Stripe connector.

- [Compatibility](#compatibility)
- [Feature Overview](#feature-overview)
- [Getting Started](#getting-started)
- [Samples](#samples)

## Compatibility

|                             |           Version           |
|:---------------------------:|:---------------------------:|
| Ballerina Language          |   Swan Lake Preview1        |

## Feature Overview

There are 7 collections provided by Ballerina for the moment to interact with different API groups of the Stripe API. 
1. **stripe:Account** - Represents your Stripe account. It holds the credentials to connect with the Stripe account. It also acts as the base object, which can be used to retrieve other collection objects.
2. **stripe:Customers** - Represents the Customers in Stripe. This acts as a client to create, retrieve, update, delete, and list the customers in a Stripe Account.
3. **stripe:Charges** - Represents the Charges in Stripe. This acts as a client to create, retrieve, update, capture, and list the charges in a Stripe Account.
4. **stripe:Invoices** - Represents the Invoices in Stripe. This acts as a client to create, retrieve, update, delete, finalize, pay, send for manual payment, void, mark uncollectible, and list the invoices in a Stripe Account.
5. **stripe.Plans** - Represents the Billing Plans in Stripe. This acts as a client to create, retrieve, update, delete, and list the plans in a Stripe Account.
6. **stripe.Products** - Represents the Products in Stripe. This acts as a client to create, retrieve, update, delete, and list the products in a Stripe Account.
7. **stripe.Subscriptions** - Represents the Subscriptions in Stripe. This acts as a client to create, retrieve, update, delete, and list the subscriptions in a Stripe Account.

## Getting Started

### Prerequisites
Download and install [Ballerina](https://ballerinalang.org/downloads/).

### Pull the Module
Execute the below command to pull the Stripe module from Ballerina Central:
```ballerina
$ ballerina pull ballerinax/stripe
```

## Samples

### Stripe Sample
The Stripe Client Connector can be used to interact with the Stripe API.

```ballerina
import ballerinax/stripe;
import ballerina/io;

public function main() {

    stripe:Account stripeAccount = new ("<secret-key>");

    // Create a customer.
    stripe:Customer customerParams = {
        address: {
            city: "city1",
            line1: "234/5"
        },
        description: "Test customer",
        email: "abc@gmail.com",
        shipping: {
            address: {
                city: "city1",
                line1: "4523/5"
            },
            name: "John",
            phone: "0924343434"
        },
        name: "John"
    };
    
    stripe:Customers customers = stripeAccount.customers();
    stripe:Customer|stripe:Error customer = customers->create(customerParams);
    if (customer is stripe:Customer) { 
        anydata customerId =  customer["id"];
        if (customerId is string) { 
            io:println("Customer created. Name = " + customerId);
        }
    } else {
        io:println("Error" + customer.message());
    }

    // Capture the payment of an existing, uncaptured, charge 
    stripe:Charges charges = stripeAccount.charges();
    stripe:Charge|stripe:Error capturedCharge = charges->capture("<charge-id>"); 
    if (capturedCharge is stripe:Charge) {
        anydata chargeId = capturedCharge["id"];
        if (chargeId is string) {
            io:println("Captured charge. Id = " + chargeId);
        }
    } else {
        io:println("Error" + capturedCharge.message());
    }

    // Create an invoice.
    stripe:Invoice invoiceParams = {
        customer: "<customer-id>",
        description: "Invoice for ABC customer"
    };

    stripe:Invoices invoices = stripeAccount.invoices();
    stripe:Invoice|stripe:Error invoice = invoices->create(invoiceParams);
    if (invoice is stripe:Invoice) {
        anydata invoiceId = invoice["id"];
        if (invoiceId is string) {
            io:println("Invoice created. Id = " + invoiceId);
        }
    } else {
        io:println("Error" + invoice.message());
    }

    // Create a product.
    stripe:Product productParams = {
        active: true,
        attributes: ["size", "colour"],
        caption: "Blue Cup",
        description: "This is a blue cup",
        images: ["https://media.gettyimages.com/photos/red-cup-picture-id171368204?s=612x612", "https://i.ytimg.com/vi/3lX0tg7CEJw/maxresdefault.jpg"],
        name: "Blue Cup",
        packageDimensions: {
            height : 3.2,
            weight: 9.8,
            length: 8.7,
            width: 2.3
        },
        shippable: true,
        'type: "good"
    };

    stripe:Products products = stripeAccount.products();
    stripe:Product|error product = products->create(productParams);
    if (product is stripe:Product) {
        anydata productId = product["id"];
        if (productId is string) {
            io:println("Product created. Id = " + productId);
        }
    } else {
        io:println("Error" + product.message());
    }

    // Retrieve details of a billing plan.
    stripe:Plans plans = stripeAccount.plans();
    stripe:Plan|error plan = plans->retrieve("<plan_id>");
    if (plan is stripe:Plan) {
        anydata planId = plan["id"];
        if (planId is string) { 
            io:println("Plan information. Id " + planId);
        }
    } else {
        io:println("Error" + plan.message());
    }

    // Cancel a subscription.
    stripe:Subscriptions subscriptions = stripeAccount.subscriptions();
    stripe:Subscription|error canceledSubscription = subscriptions->cancel("<subscription id>");
    if (canceledSubscription is stripe:Subscription) {
        anydata subscriptionId = canceledSubscription["id"];
        if (subscriptionId is string) {
            io:println("Canceled subscription. Id " + subscriptionId);
        }
    } else {
        io:println("Error" + canceledSubscription.message());
    }
}
```
