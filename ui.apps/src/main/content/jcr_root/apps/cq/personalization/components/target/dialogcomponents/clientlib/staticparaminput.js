(function(document, $) {
    "use strict";

    var selector  = ".cq-personalization-target-staticparaminput";

    $(document).on("foundation-contentloaded", function(e) {

        // add listener : if someone edits on of the input fields
        $(selector).on("change", function(e) {
            // get the parent
            var parentEl = $(e.target).parent();
            var array = [];
            // get value of name field
            array.push(parentEl.find(selector + "-nameinput").val());
            // get value of the value field
            array.push(parentEl.find(selector + "-valueinput").val());
            // make sure hidden is not disabled (default case when added from multifield template)
            var hidden = parentEl.find(selector + "-hiddeninput");
            // make sure hidden is not disabled (default case when added from multifield template)
            hidden.attr("disabled",false);
            // if somebody clears both input values but does not remove them from multifield , disable it
            if (array.join("") === "") {
                hidden.attr("disabled",true);
            };

            // store updated value as JSON array in hidden field
            hidden.attr("value",JSON.stringify(array));
        });

    });

})(document,Granite.$);