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

function mapToChargeRecord(http:Response response) returns @tainted Charge|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        check checkForErrorResponse(payload);
        convertJsonToCamelCase(payload);
        Charge|error charge = Charge.constructFrom(payload);
        if (charge is error) {
            return Error(message = "Response cannot be converted to Charge record", cause = charge);
        } else {
            return charge;
        }
    }        
}

function mapToCharges(http:Response response) returns @tainted Charge[]|Error {
    json|error payload = response.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    } else {
        var charges = payload.data;
        if (charges is error) {
            return setJsonResError(charges);
        }
        json chargesJson = <json> charges;
        check checkForErrorResponse(chargesJson);
        json[] chargesJsonArr = <json[]> chargesJson;
        convertJsonArrayToCamelCase(chargesJsonArr);
        Charge[]|error chargeList = Charge[].constructFrom(chargesJsonArr);
        if (chargeList is error) {
            return Error(message = "Response cannot be converted to Charge record array", cause = chargeList);
        } else {
            return chargeList;
        }
    }        
}
