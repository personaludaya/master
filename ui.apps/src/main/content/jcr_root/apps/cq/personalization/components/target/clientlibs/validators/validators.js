/*
 * ADOBE CONFIDENTIAL
 *
 * Copyright 2015 Adobe Systems Incorporated
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Adobe Systems Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Adobe Systems Incorporated and its
 * suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Adobe Systems Incorporated.
 */
(function(document, Granite, $) {
    "use strict";

    var locationPattern = /^[^\/].*?$/;
    
    if ($.validator) {
        $.validator.register({
            selector: "[data-validation='target.location']",
            validate: function(el) {
              var valid = locationPattern.test(el.val());

              if (!valid) {
                return Granite.I18n.get("The field cannot be empty or start with a slash.");
              }
            }
        });
    }

})(document, Granite, Granite.$);