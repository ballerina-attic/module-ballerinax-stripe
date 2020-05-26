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

# Contains information about the Charges.
# 
# + amount - Amount intended to be collected by this payment
# + currency - Three-letter ISO currency code in lowercase. Must be a supported currency
# + customer - The ID of an existing customer who will be charged
# + description - Description to be displayed along side the charge object
# + receiptEmail - The email address to which this charge’s receipt will be sent
# + shipping - Shipping information for the charge
# + sourceId - A payment source to be charged. This can be the ID of a card (i.e., credit or debit card), 
#              a bank account, a source, a token, or a connected account
# + statementDescriptor - Complete description of a charge on your customers’ statements
# + statementDescriptorSuffix - A string containing information about the charge that customers see on their statements
# + capture - Set to `true` for capturing the charge immediately or otherwise `false`, which indicates that the 
#             charge will be captured later
# + onBehalfOf - The Stripe account ID for which these funds are intended
# + transferData - An optional dictionary including the account to transfer automatically as part of a destination charge
# + transferGroup - A string, which identifies this transaction as part of a group
public type Charge record {
    int amount?;
    string currency?;
    string? customer?;
    string? description?;
    string? receiptEmail?;
    Shipping? shipping?;
    string? sourceId?;
    string? statementDescriptor?;
    string? statementDescriptorSuffix?;
    boolean capture?;
    string? onBehalfOf?;
    ChargeTransferDataParams? transferData?;
    string? transferGroup?;
};

# Contains information about charge transfers to destination accounts.
# 
# + amount - The amount transferred to the destination account if specified. 
#            By default, the entire charge amount is transferred to the destination account
# + destination - ID of an existing, connected Stripe account
public type ChargeTransferDataParams record {
    int? amount?;
    string? destination;
};

# Contains shipping details of a charge.
# 
# + address - Shipping address
# + carrier - The delivery service that shipped a physical product such as Fedex, UPS, USPS, etc.
# + name - Recipient name
# + phone - Recipient phone number
# + trackingNumber - The tracking number for a physical product obtained from the delivery service
public type Shipping record {
    Address address;
    string? carrier?;
    string name;
    string? phone?;
    string? trackingNumber?;
};

# Contains information about capturing the payment of an existing, uncaptured charge.
# 
# + amount - The amount to capture, which must be less than or equal to the original amount
# + receiptEmail - The email address to send this charge’s receipt 
# + statementDescriptor - The complete description of a charge on your customers’ statements
# + statementDescriptorSuffix - A string containing information about the charge, which customers see on their statements
# + applicationFeeAmount - An application fee amount to add on to this charge, which must be less than or equal to the original amount
# + transferData - An optional dictionary including the account to automatically transfer as part of a destination charge
# + transferGroup - A string, which identifies this transaction as part of a group
public type Capture record {
    int? amount?;
    string? receiptEmail?;
    string? statementDescriptor?;
    string? statementDescriptorSuffix?;
    int? applicationFeeAmount?;
    ChargeTransferDataParams? transferData?;
    string? transferGroup?;
};
