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
# + postal_code - ZIP or postal code
# + state - State, county, province, or region
public type Address record {
    string? city?;
    string? country?;
    string? line1;
    string? line2?;
    string? postal_code?;
    string? state?;
};

# Contains Card information.
# 
# + object - The type of payment source. Should be `card`
# + number - The card number as a string without any separators
# + exp_month - Two-digit number representing the card's expiration month
# + exp_year - Two or four-digit number representing the card's expiration year
# + cvc - Security code of the card
# + name - Cardholder's full name
# + address_line1 - Address line 1 
# + address_line2 - Address line 2
# + address_city - City / District / Suburb / Town / Village 
# + address_state - State / County / Province / Region
# + address_zip - ZIP or postal code
# + address_country - Billing address country if provided
public type Card record {
    string 'object?;
    string? number;
    string exp_month;
    string exp_year;
    string? cvc?;
    string? name?;
    string? address_line1?;
    string? address_line2?;
    string? address_city?;
    string? address_state?;
    string? address_zip?;
    string? address_country?;
};
