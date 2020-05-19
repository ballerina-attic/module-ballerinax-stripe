# Stripe Module

The Ballerina Stripe connector allows you to work with Stripe customers, invoices, billing plans, charges, products and subscriptions through the Stripe API.
The Stripe API uses API keys to authenticate. You can view and manage your API keys in the [Stripe Dashboard](https://stripe.com/login?redirect=/account/apikeys). 

1. **stripe:Account** - Represents your Stripe account. It holds the credentials to connect with the Stripe account. It also acts as the base object which can be used to retrieve other collection objects.
2. **stripe:Customers** - Represents customers in Stripe. This acts as a client to create, retrieve, update, delete and list customers in Stripe Account.
3. **stripe:Charges** - Represents Charges in Stripe. This acts as a client to create, retrieve, update, capture and list charges in Stripe Account.
4. **stripe:Invoices** - Represents Invoices in Stripe. This acts as a client to create, retrieve, update, delete, finalize, pay, send for mannual payment, void, mark uncollectible and list invoices in Stripe Account
5. **stripe.Plans** - Represents Billing Plans in Stripe. This acts as a client to create, retrieve, update, delete and list plans in Stripe Account.
6. **stripe.Products** - Represents Products in Stripe. This acts as a client to create, retrieve, update, delete and list products in Stripe Account.
7. **stripe.Subscriptions** - Represents Subscriptions in Stripe. This acts as a client to create, retrieve, update, delete and list subscriptions in Stripe Account.

## Compatibility
|                     |    Version     |
|:-------------------:|:--------------:|
| Ballerina Language  | 1.2.x         |

## Sample

**Creating a Stripe account and obtaining API keys**

1. Create a new Stripe account on [dashboard.stripe.com](https://dashboard.stripe.com/register).
2. Once you create the account you can get the API keys. 
3. View the Secret key and copy it to use as the token for Stripe client connector.

**Create the base stripe object**

First, import the `ballerinax/stripe` module into the Ballerina project.
```ballerina
import ballerinax/stripe;
```
Instantiate the `stripe:Account` by giving the stripe API key. 

You cancreate the top-most Stripe Account object as follows. 
```ballerina
stripe:Account stripeAccount = new (<secret-key>);
```

**Stripe operations related to `Customers`**

The `create` remote function can be used to create a customer. 

```ballerina
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
stripe:Customer|stripe:Error response = customers->create(customerParams);
if (response is stripe:Customer) { 
    anydata customerId =  response["id"];
    if (customerId is string) { 
        io:println("Customer created. Name = " + customerId);
    }
} else {
    io:println("Error" + response.detail()?.message.toString());
}
```

**Stripe operations related to `Charges`**

The `capture` remote function can be used to capture the payment of an existing, uncaptured, charge. 

```ballerina
stripe:Charges charges = stripeAccount.charges();
stripe:Charge|stripe:Error capturedCharge = charges->capture("<charge-id>"); 
if (capturedCharge is stripe:Charge) {
    anydata chargeId = capturedCharge["id"];
    if (chargeId is string) {
        io:println("Captured charge. Id = " + chargeId);
    }
} else {
    io:println("Error" + capturedCharge.detail()?.message.toString());
}
```

**Stripe operations related to `Invoices`**

The `create` remote function can be used to create a draft invoice for a given customer.. 

```ballerina
stripe:Invoice invoiceParams = {
    customer: "<customer-id>",
    collection_method: "send_invoice",
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
    io:println("Error" + invoice.detail()?.message.toString());
}
```

**Stripe operations related to `Products`**

The `create` remote function can be used to create a new product object.

```ballerina
stripe:Product productParams = {
    active: true,
    attributes: ["size", "colour"],
    caption: "Blue Cup",
    description: "This is a blue cup",
    images: ["https://media.gettyimages.com/photos/red-cup-picture-id171368204?s=612x612", "https://i.ytimg.com/vi/3lX0tg7CEJw/maxresdefault.jpg"],
    name: "Blue Cup",
    package_dimensions: {
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
    io:println("Error" + product.detail()?.message.toString());
}
```

**Stripe operations related to `Plans`**

The `retrieve` remote function can be used to retrieve the plan with the given ID.

```ballerina
stripe:Plans plans = stripeAccount.plans();
stripe:Plan|error plan = plans->retrieve("<plan_id>");
if (plan is stripe:Plan) {
    anydata planId = plan["id"];
    if (planId is string) { 
        io:println("Plan information. Id " + planId);
    }
} else {
    io:println("Error" + plan.detail()?.message.toString());
}
```

**Stripe operations related to `Subscriptions`**

The `cancel` remote function can be used to cancel a subscription of a customer.

```ballerina
stripe:Subscriptions subscriptions = stripeAccount.subscriptions();
stripe:Subscription|error canceledSubscription = subscriptions->cancel("<subscription id>");
if (canceledSubscription is stripe:Subscription) {
    anydata subscriptionId = canceledSubscription["id"];
    if (subscriptionId is string) {
        io:println("Canceled subscription. Id " + subscriptionId);
    }
} else {
    io:println("Error" + canceledSubscription.detail()?.message.toString());
}
```
