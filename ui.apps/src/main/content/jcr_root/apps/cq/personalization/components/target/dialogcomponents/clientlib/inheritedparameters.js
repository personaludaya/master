/*
 * ADOBE CONFIDENTIAL
 *
 * Copyright 2013 Adobe Systems Incorporated
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
;
(function(ns, channel, $) {
    "use strict";

    var identifier = "cq_personalization_dialog_target_inherited_parameters";

    /**
     * Updates the "Inherited parameters" field on the edit dialog.
     */
    var updateInheritedParams = function() {
        var mboxes = ns.ContentFrame.contentWindow.CQ_Analytics.mboxes;
        if (!mboxes && !$.isArray(mboxes)) {
            return;
        }

        var $itemsField = $("#" + identifier),
            $parentForm = $($itemsField.parents("form")[0]);

        if ($itemsField.length == 0) {
            return;
        }

        var $locationField = $parentForm.find("[name='./location']"),
            formAction = $parentForm.attr("action"),
            contentPath = formAction.substring(formAction.indexOf("/") + 1, formAction.length),
            mboxId = $locationField.val() ?
                $locationField.val() :
                contentPath.replace(/\//g, "-").replace(/_jcr_content-/g, "");

        // get the mbox object from analytics
        var currentMbox;
        mboxId += "--author"
        for (var i = 0; i < mboxes.length; i++) {
            if (mboxes[i].id === mboxId) {
                currentMbox = mboxes[i];
                break;
            }
        }

        // gather the mapping params together
        var inheritedParams = [];
        for (var i = 0; i < currentMbox.mappings.length; i++) {
            inheritedParams.push(currentMbox.mappings[i].param);
        }

        $itemsField.val(inheritedParams.join(", "));
    }

    // run this once
    updateInheritedParams();

    channel.one("dialog-ready", function(event) {
        // for subsequent displays hook into the dialog-ready event
        updateInheritedParams();
    });


})(Granite.author, jQuery(document), jQuery);