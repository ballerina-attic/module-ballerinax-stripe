import ballerina/http;
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

# Contains Address information.
# 
# + city - City, district, suburb, town, or village
# + country - Two-letter country code 
# + line1 - Address line 1
# + line2 - Address line 2
# + postalCode - ZIP or postal code
# + state - State, county, province, or region
public type Address record {
    string? city?;
    string? country?;
    string? line1;
    string? line2?;
    string? postalCode?;
    string? state?;
};

# Contains Card information.
# 
# + object - The type of payment source. Should be `card`
# + number - The card number as a string without any separators
# + expMonth - Two-digit number representing the card's expiration month
# + expYear - Two or four-digit number representing the card's expiration year
# + cvc - Security code of the card
# + name - Cardholder's full name
# + addressLine1 - Address line 1 
# + addressLine2 - Address line 2
# + addressCity - City / District / Suburb / Town / Village 
# + addressState - State / County / Province / Region
# + addressZip - ZIP or postal code
# + addressCountry - Billing address country if provided
public type Card record {
    string 'object?;
    string? number;
    string expMonth;
    string expYear;
    string? cvc?;
    string? name?;
    string? addressLine1?;
    string? addressLine2?;
    string? addressCity?;
    string? addressState?;
    string? addressZip?;
    string? addressCountry?;
};

# Defines the possible values for collection method.
public type CollectionMethod CHARGE_AUTOMATICALLY|SEND_INVOICE;

# The configuration used to create a Stripe `Client`.
#
# + secureSocketConfig - The secure connection configuration
# + timeoutInMillis - The maximum time to wait (in milliseconds) for a response before closing the connection
# + retryConfig - The configurations associated with retrying
public type Configuration record {|
    http:ClientSecureSocket secureSocketConfig?;
    int timeoutInMillis?;
    http:RetryConfig retryConfig?;
|};