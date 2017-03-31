"use strict";
var $ = require('jquery');
require('intlTelInput');
var shared_1 = require('./shared');
require('bootstrap.floating-label');
var ContestParticipantFormContainer = (function () {
    function ContestParticipantFormContainer() {
        this.marketingactivitiesSelector = '#marketingactivities';
        this.marketingactivitiesDefaultValue = 1;
        this.marketingactivitiesBtnYes = '#btnyes';
        this.marketingactivitiesBtnNo = '#btnno';
        this.init();
    }
    ContestParticipantFormContainer.prototype.init = function () {
        var _this = this;
        new shared_1.AccordionComponent('tnc');
        $(document).ready(function () {
            if ($('input[name="mobile"]').length > 0) {
                $('input[name="mobile"]').intlTelInput({
                    initialCountry: 'sg',
                });
                $('input[name="mobile"]').on('keyup', function (e) {
                    if ($('input[name="mobile"]').intlTelInput('isValidNumber')) {
                        $('input[name="mobile"]').parent().next().addClass('hide');
                    }
                    else {
                        $('input[name="mobile"]').parent().next().removeClass('hide');
                    }
                });
            }
            /* marketing activities */
            // default is yes
            $(_this.marketingactivitiesBtnYes).on('click', function (e) {
                e.preventDefault();
                $(_this.marketingactivitiesBtnNo).removeClass('active');
                $(_this.marketingactivitiesBtnYes).addClass('active');
                $(_this.marketingactivitiesSelector).val(1);
            });
            $(_this.marketingactivitiesBtnNo).on('click', function (e) {
                e.preventDefault();
                $(_this.marketingactivitiesBtnYes).removeClass('active');
                $(_this.marketingactivitiesBtnNo).addClass('active');
                $(_this.marketingactivitiesSelector).val(0);
            });
            $(_this.marketingactivitiesSelector).val(_this.marketingactivitiesDefaultValue);
            /* marketing activities */
        });
    };
    return ContestParticipantFormContainer;
}());
new ContestParticipantFormContainer();
