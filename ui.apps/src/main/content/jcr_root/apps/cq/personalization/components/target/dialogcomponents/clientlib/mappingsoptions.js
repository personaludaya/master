(function(ns, document, $) {
    "use strict";

    var identifier  = "cq-personalization-target-mappingsselect";

    var buildSelectField = function(event) {
        // get all mappingsselect controls
        var spanEl = event ?
                $("." +identifier,event.target):
                $("." + identifier);

        // get list of all options as a string of HTML <option> elements
        var options = collectOptions();
        // loop through all controls
        spanEl.each( function(index){
            var $this = $(this);
            // check if already processed, if so skip it
            if (!$this.data(identifier + ".internal.processed")){
                // get any stored value
                var value = $(this).data(identifier + "-value");
                // get the select element
                var selectEl = $(this).find("select");
                // add the options to the select element
                selectEl.append(options);
                // mark proper option as selected if defined
                if (value){
                    selectEl.find("option[value='"+value +"']").attr("selected",true);
                }
                // finally init it as an standard select control
                $this.select();
                // mark the element as processed
                $this.data(identifier + ".internal.processed", true)
            }
        });

        /**
         * collects all parameters from all currently active stores in the context hub, turns them in to
         * select <option> elements, and returns them as one string.
         * @return {String}
         */
        function collectOptions(){
            var analytics = ns.ContentFrame.contentWindow.CQ_Analytics,
                options = [];

            var collectClientContextProps = function() {
                // get all context hub aka context cliene aka clickstream cloud stores, and collect their props
                var options = [];
                var stores = analytics.StoreRegistry.getStores();
                for(var name in stores) {
                    var store = analytics.StoreRegistry.getStore(name);
                    if( store ) {
                        var names = store.getPropertyNames();
                        for(var j = 0; j < names.length; j++) {
                            var value = names[j];
                            if( !Granite.author.ContentFrame.contentWindow.CQ.shared.XSS.KEY_REGEXP.test(value) ) {
                                options.push({
                                    value: name + "." + value
                                });
                            }
                        }
                    }
                }
                return options;
            };

            var collectContextHubProps = function() {
                var options = [];
                var stores =  ContextHub.getAllStores();
                for (var storeName in stores) {
                    var store = ContextHub.getStore(storeName);
                    if (typeof store !== "undefined") {
                        var names = store.getKeys();
                        for (var idx in names) {
                            // the keys are all starting with / so we get rid of it.
                            var value = names[idx].replace("/","");
                            if( !Granite.author.ContentFrame.contentWindow.CQ.shared.XSS.KEY_REGEXP.test(value) ) {
                                options.push({
                                    value: storeName + "." + value
                                });
                            }
                        }
                    }
                }
                return options;
            };

            if (typeof analytics !== "undefined"
                && typeof analytics.StoreRegistry !== "undefined") {
                options = collectClientContextProps();
            } else {
                options = collectContextHubProps();
            }

            // sort them
            options.sort(function(a, b) {
                if ( a.value < b.value )
                    return -1;
                else if ( a.value > b.value )
                    return 1;
                return 0;
            });

            // create the options list
            var optionsHtml = [];
            options.forEach( function(entry){
                optionsHtml.push( "<option value='"+ entry.value +"'>" + entry.value + "</option>");
            });

            // return the options list turned into a jquery object;
            return optionsHtml.join("");
        }
    }

    buildSelectField();

    $(document).on("dialog-ready", function(event){
        buildSelectField(event);
    });

    $(document).on("foundation-contentloaded", function(event) {
        buildSelectField(event);
    });

})(Granite.author,document,Granite.$);