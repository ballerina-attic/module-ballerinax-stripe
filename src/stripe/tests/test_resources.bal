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

Customer customerParams = {
    description: "First customer",
    email: "b7astripe@gmail.com",
    shipping: {
        address: {
            city: "Colombo",
            country: "Sri Lanka",
            line1: "345/5",
            postalCode: "10230",
            state: "Western",
            line2: "Palm Grove"
        },
        name: "b7a"
    },
    address: {
        city: "city1",
        line1: "234/5",
        line2: "Palm Grove",
        country: "Sri Lanka",
        postalCode: "1004",
        state: "Western"
    },
    name: "ballerina",
    nextInvoiceSequence: 10,
    taxExempt: "none"
};

Customer customerUpdateParams = {
    description: "Updated description"
};

Card card = {
    'object: "card",
    number: "4242424242424242",
    expMonth: "12",
    expYear: "2021",
    cvc: "123",
    name: "Bhashinee",
    addressLine1: "345/1",
    addressLine2: "Palm Grove",
    addressCity: "Colombo",
    addressState: "Western",
    addressZip: "10234",
    addressCountry: "Sri Lanka"
};

Product product = {
	active: true,
	attributes: ["size", "colour"],
	caption: "thisisthecaption",
	description: "Describing the product",
	images: ["https://media.gettyimages.com/photos/red-cup-picture-id171368204?s=612x612", "https://i.ytimg.com/vi/3lX0tg7CEJw/maxresdefault.jpg"],
	name: "Blue Cup",
	packageDimensions: {
        height : 3.2,
        weight: 9.8,
        length: 8.7,
        width: 2.3
    },
	shippable: true,
	'type: "good",
	url: "https://medium.com/@bhashineen/ballerina-soap-connector-3974b6efaf2b"
};

Product updateProduct = {
	description: "Updated description"
};

Plan plan = {
    currency: "usd",
    interval: "month",
    product: {
        name: "Red purse",
        active: true,
        statementDescriptor: "statementDescriptor",
        unitLabel: "unitlabel"
    },
    active: true,
    nickname: "RedPursePlan",
    aggregateUsage: "last_ever",
    billingScheme: "tiered",
    id: "PlanId2",
    tiers: [{
        flatAmountDecimal: 3.0,
        unitAmount: 5,
        upTo: "inf"
    }],
    tiersMode: "volume",
    intervalCount: 10,
    trialPeriodDays: 40,
    usageType: "metered"
};

Plan updatePlan = {
    nickname: "RedPursePlan1"
};

Subscription subs = {
    customer: "cus_HHWIJPAUfcXYNH",
    cancelAtPeriodEnd: false,
    billingThresholds: {
        amountGte: 100,
        resetBillingCycleAnchor: false
    },
    subscriptionItems: [{
        plan: "TutePlan"
    }],
    collectionMethod: "send_invoice",
    daysUntilDue: 30,
    offSession: false,
    pendingInvoiceItemInterval: {
        interval: "year",
        intervalCount: 1
    },
    prorationBehavior: "always_invoice",
    taxPercent: 4.0,
    trialFromPlan: false,
    trialPeriodDays: 30
};

Subscription updateSubs = {
    cancelAtPeriodEnd: false,
    billingThresholds: {
        amountGte: 100,
        resetBillingCycleAnchor: false
    },
    collectionMethod: "send_invoice",
    daysUntilDue: 30,
    offSession: false,
    pendingInvoiceItemInterval: {
        interval: "year",
        intervalCount: 1
    },
    prorationBehavior: "always_invoice",
    taxPercent: 4.0,
    trialFromPlan: false
};

Charge charge = {
    amount: 2000,
    currency: "usd",
    customer: "cus_HHWIJPAUfcXYNH",
    description: "Charge for customer",
    receiptEmail: "bhashi@gmail.com",
    shipping: {
        address: {
            city: "colombo",
            country: "Sri Lanka",
            line1: "456/2",
            line2: "Palm Grove",
            postalCode: "1004",
            state: "western"
        },
        carrier: "fedex",
        name: "customer",
        phone: "09234323",
        trackingNumber: "3456"
    },
    sourceId: "card_1GjymEJ7y0eOXqiMOr7j1Psz",
    statementDescriptor: "descriptor",
    statementDescriptorSuffix: "cd",
    transferGroup: "group1"
};

Capture capture = {
    receiptEmail: "bhashi@gmail.com",
    statementDescriptor: "This is statement",
    statementDescriptorSuffix: "SUF",
    transferGroup: "Group123"
};

Invoice invo = {
    customer: "cus_HHWIJPAUfcXYNH"
};

Invoice updateInvo = {
    description: "update description"
};

InvoiceItem invoiceItem = {
    customer : "cus_HHWIJPAUfcXYNH", 
    currency: "usd",
    description: "description",
    discountable: true,
    priceData: {
        currency: "usd",
        product: "prod_HHWNWWsSZ91sDy",
        unitAmount: 2
    },
    period: {
        end: 1587443917,
        'start: 1587443917
    },
    quantity: 10
};
