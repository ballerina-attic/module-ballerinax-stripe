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
            postal_code: "10230",
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
        postal_code: "1004",
        state: "Western"
    },
    name: "ballerina",
    next_invoice_sequence: 10,
    tax_exempt: "none"
};

Customer customerUpdateParams = {
    description: "Updated description"
};

Card card = {
    'object: "card",
    number: "4242424242424242",
    exp_month: "12",
    exp_year: "2021",
    cvc: "123",
    name: "Bhashinee",
    address_line1: "345/1",
    address_line2: "Palm Grove",
    address_city: "Colombo",
    address_state: "Western",
    address_zip: "10234",
    address_country: "Sri Lanka"
};

Product product = {
	active: true,
	attributes: ["size", "colour"],
	caption: "thisisthecaption",
	description: "Describing the product",
	images: ["https://media.gettyimages.com/photos/red-cup-picture-id171368204?s=612x612", "https://i.ytimg.com/vi/3lX0tg7CEJw/maxresdefault.jpg"],
	name: "Blue Cup",
	package_dimensions: {
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
        statement_descriptor: "statementDescriptor",
        unit_label: "unitlabel"
    },
    active: true,
    nickname: "RedPursePlan",
    aggregate_usage: "last_ever",
    billing_scheme: "tiered",
    id: "PlanId2",
    tiers: [{
        flat_amount_decimal: 3.0,
        unit_amount: 5,
        up_to: "inf"
    }],
    tiers_mode: "volume",
    interval_count: 10,
    trial_period_days: 40,
    usage_type: "metered"
};

Plan updatePlan = {
    nickname: "RedPursePlan1"
};

Subscription subs = {
    customer: "cus_HHWIJPAUfcXYNH",
    cancel_at_period_end: false,
    billing_thresholds: {
        amount_gte: 100,
        reset_billing_cycle_anchor: false
    },
    subscription_items: [{
        plan: "TutePlan"
    }],
    collection_method: "send_invoice",
    days_until_due: 30,
    off_session: false,
    pending_invoice_item_interval: {
        interval: "year",
        interval_count: 1
    },
    proration_behavior: "always_invoice",
    tax_percent: 4.0,
    trial_from_plan: false,
    trial_period_days: 30
};

Subscription updateSubs = {
    cancel_at_period_end: false,
    billing_thresholds: {
        amount_gte: 100,
        reset_billing_cycle_anchor: false
    },
    collection_method: "send_invoice",
    days_until_due: 30,
    off_session: false,
    pending_invoice_item_interval: {
        interval: "year",
        interval_count: 1
    },
    proration_behavior: "always_invoice",
    tax_percent: 4.0,
    trial_from_plan: false
};

Charge charge = {
    amount: 2000,
    currency: "usd",
    customer: "cus_HHWIJPAUfcXYNH",
    description: "Charge for customer",
    receipt_email: "bhashi@gmail.com",
    shipping: {
        address: {
            city: "colombo",
            country: "Sri Lanka",
            line1: "456/2",
            line2: "Palm Grove",
            postal_code: "1004",
            state: "western"
        },
        carrier: "fedex",
        name: "customer",
        phone: "09234323",
        tracking_number: "3456"
    },
    sourceId: "card_1GjymEJ7y0eOXqiMOr7j1Psz",
    statement_descriptor: "descriptor",
    statement_descriptor_suffix: "cd",
    transfer_group: "group1"
};

Capture capture = {
    receipt_email: "bhashi@gmail.com",
    statement_descriptor: "This is statement",
    statement_descriptor_suffix: "SUF",
    transfer_group: "Group123"
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
    price_data: {
        currency: "usd",
        product: "prod_HHWNWWsSZ91sDy",
        unit_amount: 2
    },
    period: {
        end: 1587443917,
        'start: 1587443917
    },
    quantity: 10
};
