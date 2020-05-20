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

# Contains information about a customer.
# 
# + address - The customer’s address
# + balance - An integer amount in cents, which represents the customer’s current balance.
#             This affects the customer’s future invoices
# + coupon - The coupon code. The customer will have a discount applied on all recurring charges
# + description - An arbitrary string that can be attached to a customer object. 
#                 It is displayed  in the dashboard alongside the customer's name
# + email - Customer’s email address
# + invoice_prefix - The prefix for the customer, which is used to generate unique invoice numbers. 
#                    Must be containing 3–12 uppercase letters or numbers
# + invoice_settings - Default invoice settings for a customer
# + shipping - The customer’s shipping information
# + name - The customer’s full name or business name
# + next_invoice_sequence - The sequence to be used on the customer’s next invoice
# + tax_exempt - The customer’s tax exemption. One of the values: `NONE`, `EXEMPT`, or `REVERSE`
# + tax_id_data - The customer’s tax IDs
public type Customer record {
    Address? address?;
    int balance?;
    string? coupon?;
    string description?;
    string? email?;
    string? invoice_prefix?;
    CustomerInvoiceCustomFieldParams? invoice_settings?;
    CustomerShippingDetails? shipping?;
    string? name?;
    int? next_invoice_sequence?;
    TaxExempt tax_exempt?;
    CustomerTaxIdDataParams? tax_id_data?;
};

# Contains information about default invoice settings for a customer.
# 
# + name - Custom field name
# + value - Custom field value
# + default_payment_method - ID of a payment method that’s attached to the customer.
#                           This will be used as the customer’s default payment method for subscriptions and invoices
# + footer - Default footer to be displayed on invoices for this customer
public type CustomerInvoiceCustomFieldParams record {
    string? name?;
    string? value?;
    string? default_payment_method?;
    string? footer?;
};

# The customer’s shipping information. These will appear on the invoices emailed to this customer.
# 
# + address - Customer shipping address
# + name - Customer name
# + phone - Customer phone
public type CustomerShippingDetails record {
    Address? address?; 
    string? name;
    string? phone?;       
};

# The customer’s tax IDs.
# 
# + tax_id_type - Type of the tax ID. One of the values: `EU_VAT`, `BR_CNPJ`, `BR_CPF`, `NZ_GST`, `AU_ABN`, `IN_GST`, `NO_VAT`, 
#                 `ZA_VAT`, `CH_VAT`, `MX_RFC`, `SG_UEN`, `RU_INN`, `CA_BN`, `HK_BR`, `ES_CIF`, `tw_vat`, `TW_VAT`, 
#                 `JP_CN`, `LI_UID`, `MY_ITN`, `US_EIN`, `KR_BRN`, `CA_QST`, `MY_SST`, or `SG_GST`
# + value - Value of the tax ID
public type CustomerTaxIdDataParams record {
    TaxIdType? tax_id_type?;
    string? value?;
};

# Defines the possible values for the Type of the tax ID.
public type TaxIdType EU_VAT|BR_CNPJ|BR_CPF|NZ_GST|AU_ABN|IN_GST|NO_VAT|ZA_VAT|CH_VAT|MX_RFC|SG_UEN|RU_INN|CA_BN|HK_BR
                        |ES_CIF|TW_VAT|TH_VAT|JP_CN|LI_UID|MY_ITN|US_EIN|KR_BRN|CA_QST|MY_SST|SG_GST;

# Defines the possible values for customer’s tax exemption.
public type TaxExempt NONE|EXEMPT|REVERSE;
