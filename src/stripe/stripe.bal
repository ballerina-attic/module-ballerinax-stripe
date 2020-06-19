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
import ballerina/oauth2;

# Represents Stripe account. It holds the credentials to connect with the Stripe account.
public type Account object {

    private http:Client stripe;
    private Charges charges;
    private Customers customers;
    private Invoices invoices;
    private Products products;
    private Plans plans;
    private Subscriptions subscriptions;

    # Gets invoked to initialize the `stripe:Account`. 
    # ```ballerina
    # stripe:Account account = new("<stripeToken>");
    # ```
    public function init(string token, Configuration? stripeConfig = ()) {
        oauth2:DirectTokenConfig oauth2Config = {
            accessToken: token
        };
        oauth2:OutboundOAuth2Provider oauth2Provider = new(oauth2Config);
        http:BearerAuthHandler oauth2Handler = new(oauth2Provider);
        int? timeOut = stripeConfig?.timeoutInMillis;
        http:ClientConfiguration clientConfig = {
            auth: {
                authHandler: oauth2Handler
            },
            secureSocket: stripeConfig?.secureSocketConfig,
            timeoutInMillis: timeOut is int ? timeOut : 6000,
            retryConfig: stripeConfig?.retryConfig
        };
        self.stripe = new(BASE_URL, config = clientConfig);
        self.charges = new(self.stripe);
        self.customers = new(self.stripe);
        self.invoices = new(self.stripe);
        self.products = new(self.stripe);
        self.subscriptions = new(self.stripe);
        self.plans = new(self.stripe);
    } 

    # Gets the customers client.
    # ```ballerina
    # stripe:Customers customers = account.customers();
    # ```
    #
    # + return - The customers client
    public function customers() returns Customers {
        return self.customers;
    }

    # Gets the products client.
    # ```ballerina
    # stripe:Products products = account.products();
    # ```
    #
    # + return - The products client
    public function products() returns Products {
        return self.products;
    }

    # Gets the charges client.
    # ```ballerina
    # stripe:Charges charges = account.charges();
    # ```
    #
    # + return - The charges client
    public function charges() returns Charges {
        return self.charges;
    }

    # Gets the subscriptions client.
    # ```ballerina
    # stripe:Subscriptions subscriptions = account.subscriptions();
    # ```
    #
    # + return - The subscriptions client
    public function subscriptions() returns Subscriptions {
        return self.subscriptions;
    }

    # Gets the plans client.
    # ```ballerina
    # stripe:Plans plans = account.plans();
    # ```
    #
    # + return - The plans client
    public function plans() returns Plans {
        return self.plans;
    }

    # Gets the invoices client.
    # ```ballerina
    # stripe:Invoices invoices = account.invoices();
    # ```
    #
    # + return - The invoices client
    public function invoices() returns Invoices {
        return self.invoices;
    }
}; 
