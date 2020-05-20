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

# Contains information about a product.
# 
# + active - Specifies whether the product is currently available for purchase
# + attributes - A list of up to 5 alphanumeric attributes
# + caption - A short one-line description of the product to be displayable to the customer. 
#            Should be set only if `type=good`
# + deactivate_on - An array of Connect application names or identifiers, which should not be able 
#                  to order the SKUs for this product. Should be set only if `type=GOOD`
# + description - The product’s description
# + id - An identifier will be generated randomly by Stripe. Optionally, you can  override this ID
#        but the ID must be unique across all products in your Stripe account
# + images - A list of up to 8 URLs of images for this product to be displayable to the customer
# + name - The product’s name
# + package_dimensions - The dimensions of this product for shipping purposes. Should be set only if `type=GOOD`
# + shippable - Specifies whether this product is shippable. Should be set only if `type=GOOD`
# + type - Product type: `SERVICE` or `GOOD`
# + url - A URL of a publicly-accessible webpage for this product
public type Product record {
    boolean? active?;
    string[]? attributes?;
    string? caption?;
    string[]? deactivate_on?;
    string? description?;
    string? id?;
    string[]? images?;
    string name?;
    PackageDimensions? package_dimensions?;
    boolean? shippable?;
    ProductType? 'type?;
    string? url?;
};

# Configurations associated with the package.
# 
# + height - Height in inches
# + length - Length in inches
# + weight - Weight in ounces
# + width - Width in inches
public type PackageDimensions record {
    float height;
    float length;
    float weight;
    float width;
};

# Defines the possible values for product type.
public type ProductType GOOD|SERVICE;
