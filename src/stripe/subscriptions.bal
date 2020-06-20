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

# Represents the Subscriptions in Stripe. This acts as a client to create, retrieve, update, 
# delete, and list the subscriptions in a Stripe Account
public type Subscriptions client object {
   private http:Client subscriptions;
   
   function init(http:Client stripeClient) {
      self.subscriptions = stripeClient;
   }

   # Creates a subscription.
   # ```ballerina
   # stripe:Subscription subscriptionParams = { customer: "<customer-id>", subscriptionItems: [{ plan: "<plan-id>"] };
   # stripe:Subscription|stripe:Error createdSubscription = subscriptions->create(subscriptionParams);
   # ```
   #
   # + subscription - Subscription configurations
   # + return - `Subscription` record or else a `stripe:Error` in case of a failure
   public remote function create(Subscription subscription) returns @tainted Subscription|Error {
      string queryString = createQuery(EMPTY, subscription);
      queryString = stringutils:replace(queryString, SUBSCRIPTION_ITEMS, ITEMS);
      http:Response response = check createPostRequest(self.subscriptions, queryString, SUBSCRIPTION_PATH);
      return mapToSubscriptionRecord(response);
   }

   # Retrieves a subscription.
   # ```ballerina
   # stripe:Subscription|stripe:Error retrievedSubscription = subscriptions->retrieve("<subscription-id>");
   # ```
   #
   # + subscriptionId - Subscription ID
   # + return - `Subscription` record or else a `stripe:Error` in case of a failure
   public remote function retrieve(string subscriptionId) returns @tainted Subscription|Error {
      string path = SUBSCRIPTION_PATH + BACK_SLASH + subscriptionId;
      http:Response response = check createGetRequest(self.subscriptions, path);
      return mapToSubscriptionRecord(response);
   }

   # Updates a Subscription.
   # ```ballerina
   # stripe:Subscription subscriptionParams = { cancelAtPeriodEnd: false, billingThresholds: 
   #             { amountGte: 100, resetBillingCycleAnchor: false }, collectionMethod: "send_invoice", daysUntilDue: 30 };
   # stripe:Subscription|stripe:Error updatedSubscription = subscriptions->update("<subscription-id>", subscriptionParams);
   # ```
   #
   # + subscriptionId - Subscription ID
   # + subscription - Subscription configurations
   # + return - `Subscription` record or else a `stripe:Error` in case of a failure
   public remote function update(string subscriptionId, Subscription subscription) returns @tainted Subscription|Error {
      string path = SUBSCRIPTION_PATH + BACK_SLASH + subscriptionId;
      string queryString = createQuery(EMPTY, subscription);
      queryString = stringutils:replace(queryString, SUBSCRIPTION_ITEMS, ITEMS);
      http:Response response = check createPostRequest(self.subscriptions, queryString, path);
      return mapToSubscriptionRecord(response);
   }

   # Cancels a subscription.
   # ```ballerina
   # stripe:Error|stripe:Subscription cancelSubscription = subscriptions->cancel("<subscription-id>");
   # ```
   #
   # + subscriptionId - Subscription ID
   # + return - `()` or else a `stripe:Error` in case of a failure
   public remote function cancel(string subscriptionId) returns @tainted Subscription|Error {
      string path = SUBSCRIPTION_PATH + BACK_SLASH + subscriptionId;
      http:Response response = check createDeleteRequest(self.subscriptions, path);
      return mapToSubscriptionRecord(response);
   }

   # Lists all subscriptions.
   # ```ballerina
   # stripe:Error|stripe:Subscription[] subscriptionsList = subscriptions->list();
   # ```
   #
   # + return - An array of `Subscription` records or else a `stripe:Error` in case of a failure
   public remote function list() returns @tainted Subscription[]|Error {
      http:Response response = check createGetRequest(self.subscriptions, SUBSCRIPTION_PATH);
      return mapToSubscriptions(response);
   }
};
