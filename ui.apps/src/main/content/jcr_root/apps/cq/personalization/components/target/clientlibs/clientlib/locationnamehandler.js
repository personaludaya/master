/*******************************************************************************
 * ADOBE CONFIDENTIAL
 * __________________
 *
 * Copyright 2015 Adobe Systems Incorporated
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Adobe Systems Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Adobe Systems Incorporated and its
 * suppliers and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Adobe Systems Incorporated.
 ******************************************************************************/

;(function(document,$){
    "use strict";

    var locationNameField = "#cq-personalization-target-dialog-locationname",
        oldLocationNameField = "#cq-personalization-target-dialog-oldlocationname";

    rememberLocationName(locationNameField, oldLocationNameField);

    // when dialog gets injected
    $(document).on("foundation-contentloaded", function(e) {
        rememberLocationName(locationNameField, oldLocationNameField);
    });

    //copy the value from the location field to the hidden field
    function rememberLocationName(locationNameField, oldLocationNameFiled) {
        $(oldLocationNameField).val($(locationNameField).val());
    }

    // register validator for the location field
    $(window).adaptTo("foundation-registry").register("foundation.validation.validator", {
        selector: "#cq-personalization-target-dialog-locationname",
        validate: function(el) {
            var locationField = $(el);
            var locationValue = locationField.val();
            var regEx = /^[a-zA-Z0-9 \-]+$/gi;
            if (!locationValue.match(regEx)) {
                return Granite.I18n.get("Location contains invalid characters!");
            } else if (locationValue.length > 250) {
                return Granite.I18n.get("Location length must not exceed 250 characters!");
            }
        }
    });

})(document, Granite.$);