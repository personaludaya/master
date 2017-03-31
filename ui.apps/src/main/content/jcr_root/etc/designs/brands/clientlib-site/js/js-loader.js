"use strict";
var $ = require('jquery');
var JsLoader = (function () {
    function JsLoader() {
        this.jsLoaderSelector = "data-js-loader";
        this.init();
    }
    JsLoader.prototype.init = function () {
        var _this = this;
        $(document).ready(function () {
            $("*[" + _this.jsLoaderSelector + "]").each(function (index, item) {
                var jsLoader = $(item).attr(_this.jsLoaderSelector);
                if (jsLoader && typeof jsLoader == 'string') {
                    jsLoader = JSON.parse(jsLoader);
                }
                if (jsLoader && jsLoader.length > 0) {
                    for (var _i = 0, jsLoader_1 = jsLoader; _i < jsLoader_1.length; _i++) {
                        var loader = jsLoader_1[_i];
                        System.import(loader);
                    }
                }
            });
        });
    };
    return JsLoader;
}());
new JsLoader();
