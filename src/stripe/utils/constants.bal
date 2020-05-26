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

const string BASE_URL = "https://api.stripe.com";
const string CHARGE_PATH = "/v1/charges";
const string CAPTURE_PATH = "/capture";
const string CUSTOMER_PATH = "/v1/customers";
const string INVOICE_PATH = "/v1/invoices";
const string FINALIZE_PATH = "/finalize";
const string PAY_PATH = "/pay";
const string SEND_PATH = "/send";
const string VOID_PATH = "/void";
const string MARK_UNCOLLECTIBLE_PATH = "/mark_uncollectible";
const string INVOICE_ITEM_PATH = "/v1/invoiceitems";
const string PLAN_PATH = "/v1/plans";
const string PRODUCT_PATH = "/v1/products";
const string SUBSCRIPTION_PATH = "/v1/subscriptions";
const string AND = "&";
const string BACK_SLASH = "/";
const string TAX_RATES = "tax_rates";
const string DEFAULT_TAX_RATES = "default_tax_rates";
const string UTF8 = "UTF8";
const string CONTENT_TYPE = "Content-Type";
const string FORM_URL_ENCODED = "application/x-www-form-urlencoded";
const string EMPTY = "";
const string SOURCE_ID = "source_id";
const string SOURCE = "source";
const string PRICE_ID = "priceId";
const string PRICE = "price";
const string AUTO_ADVANCE = "auto_advance=";
const string SUBSCRIPTION_ITEMS = "subscription_items";
const string ITEMS = "items";
public const EU_VAT= "eu_vat";
public const BR_CNPJ = "br_cnpj";
public const BR_CPF = "br_cpf";
public const NZ_GST = "nz_gst";
public const AU_ABN = "au_abn";
public const IN_GST = "in_gst";
public const NO_VAT = "no_vat";
public const ZA_VAT = "za_vat";
public const CH_VAT = "ch_vat";
public const MX_RFC = "mx_rfc";
public const SG_UEN = "sg_uen";
public const RU_INN = "ru_inn";
public const CA_BN = "ca_bn";
public const HK_BR = "hk_br";
public const ES_CIF = "es_cif";
public const TW_VAT = "tw_vat";
public const TH_VAT = "th_vat";
public const JP_CN = "jp_cn";
public const LI_UID = "li_uid";
public const MY_ITN = "my_itn";
public const US_EIN = "us_ein";
public const KR_BRN = "kr_brn";
public const CA_QST = "ca_qst";
public const MY_SST = "my_sst";
public const SG_GST = "sg_gst";
public const NONE= "none";
public const EXEMPT= "exempt";
public const REVERSE= "reverse";
public const CHARGE_AUTOMATICALLY = "charge_automatically";
public const SEND_INVOICE= "send_invoice";
public const MONTH = "month";
public const WEEK = "week";
public const DAY = "day";
public const YEAR = "YEAR";
public const SUM = "sum";
public const LAST_DURING_PERIOD = "last_during_period";
public const LAST_EVER = "last_ever";
public const MAX = "max";
public const TIERED = "tiered";
public const PER_UNIT = "per_unit";
public const METERED = "metered";
public const LICENSED = "licensed";
public const UP = "up";
public const DOWN = "down";
public const GOOD = "good";
public const SERVICE = "service";
public const ALLOW_INCOMPLETE = "allow_incomplete";
public const ERROR_IF_INCOMPLETE = "error_if_incomplete";
public const PENDING_IF_INCOMPLETE = "pending_if_incomplete";
