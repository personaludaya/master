(function(document, $) {
    "use strict";

    var checkId = "#cq_personalization_dialog_target_accurateTargeting";
    var multiMappingsId = "#cq_personalization_dialog_target_multifield_mappings";
    var multiStaticParamsId = "#cq_personalization_dialog_target_multifield_staticparams";

    enableDisableParamFields($(checkId));

    // when dialog gets injected
    $(document).on("foundation-contentloaded", function(e) {
        // enable/disable context params /static params based on checkbox state
        enableDisableParamFields($(checkId))  ;
    });

    // if someone changes the checkbox state
    $(document).on("change",checkId, function(e) {
        enableDisableParamFields($(checkId));
    });

    function enableDisableParamFields(target){
        // get the two multifields
        var mappings = $(multiMappingsId);

        // if checked
        if($(target).is(":checked")){
            // disable all buttons of multifields
            mappings.find(".coral-Multifield-add").attr("disabled",false);
            // disable the select buttons
            mappings.find("span[class~='select'] > button" ).attr("disabled",false);

        } else {
            // disable all buttons of multifields
            mappings.find(".coral-Multifield-add").attr("disabled",true);
            // disable the select buttons
            mappings.find("span[class~='select'] > button" ).attr("disabled",true);
        }
    }

})(document,Granite.$);