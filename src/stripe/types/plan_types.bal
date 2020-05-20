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

# Contains information about a billing plan.
# 
# + amount - A positive integer in cents (or 0 for a free plan) representing how much to charge on a recurring basis
# + currency - Three-letter ISO currency code in lowercase. This must be a supported currency
# + interval - Specifies the billing frequency. Either day, week, month, or year
# + product - The product whose pricing the created plan will represent. This can either be the ID of an existing 
#             product or a dictionary containing fields used to create a service product
# + active - Specifies whether the plan is currently available for new subscriptions
# + nickname - A brief description of the plan, which is hidden from customers
# + aggregate_usage - Specifies a usage aggregation strategy for plans of `usage_type=metered`. 
#                     Allowed values are `sum` for summing up all usage during a period, `last_during_period` for using the 
#                     last usage record reported within a period, `last_ever` for using the last usage record ever 
#                     (across period bounds), or max, which uses the usage record with the maximum reported usage during a period
# + amount_decimal - This is the same as `amount` but accepts a decimal value with at most 12 decimal places. 
#                    Only one from the `amount` and `amount_decimal` can be set
# + billing_scheme - Describes how to compute the price per period. Either `per_unit` or `tiered`
# + id - Plan ID. An identifier, which is generated randomly by Stripe
# + tiers - Represents the pricing tiers. This parameter requires the `billing_scheme` to be set to `tiered`
# + tiers_mode - Defines if the tiering price should be `graduated` or `volume based`
# + interval_count - The number of intervals between subscription billings. For example, `interval=month` and 
#                    `interval_count=3` bills every 3 months
# + transform_usage - Apply a transformation to the reported usage or set the quantity before computing the billed price. 
#                    This cannot be combined with `tiers`
# + trial_period_days - Default number of trial days when subscribing a customer to this plan using the `trial_from_plan=true`
# + usage_type - Configures how the quantity per period should be determined. This can be either `metered` or `licensed`
public type Plan record {
    int? amount?;
    string? currency?;
    string? interval?;
    PlanProduct|string? product?;
    boolean? active?;
    string? nickname?;
    string? aggregate_usage?;
    float|string? amount_decimal?;
    string? billing_scheme?;
    string? id?;
    PlanTierParams[]? tiers?;
    string? tiers_mode?;
    int? interval_count?;
    PlanTransformUsageParams? transform_usage?;
    int? trial_period_days?;
    string? usage_type?;
};

# Configurations associated in creating a service product.
# 
# + active - Specifies whether the product is currently available for purchase
# + id - The identifier for the product. If not provided, an identifier will be generated randomly 
# + name - Product name
# + statement_descriptor - A description to be displayed on customer’s credit card or bank statement
# + unit_label - A label, which represents units of this product in Stripe and on customers’ receipts and invoices
public type PlanProduct record {
    boolean? active?;              
    string? id?;
    string? name;
    string? statement_descriptor?;
    string? unit_label?;
};

# Configurations associated with pricing tiers.
# 
# + flat_amount - The flat billing amount for an entire tier regardless of the number of units in the tier
# + flat_amount_decimal - Same as the `flat_amount` but this accepts a decimal value representing an integer in the 
#                         minor units of the currency. Only one from the `flat_amount` and flat_`amount_decimal` can be set
# + unit_amount - The per unit billing amount for each individual unit for which this tier applies
# + unit_amount_decimal - Same as the `unit_amount` but this accepts a decimal value with at most 12 decimal places. 
#                         Only one from the `unit_amount` and `unit_amount_decimal` can be set
# + up_to - Specifies the upper bound of this tier. The lower bound of a tier is the upper bound of the 
#           previous tier by adding one. Use `inf` to define a fallback tier
public type PlanTierParams record {
    int? flat_amount?;
    float|string? flat_amount_decimal?;
    int|string? unit_amount?;
    float|string? unit_amount_decimal?;
    string? up_to?;
};

# Configurations associated with transformation.
# 
# + divide_by - Divide usage by this number
# + round - After division, either round the result `up` or `down`
public type PlanTransformUsageParams record {
    int? divide_by?;
    string? round?;
};
