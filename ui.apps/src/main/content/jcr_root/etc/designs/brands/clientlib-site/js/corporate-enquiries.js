"use strict";
var $ = require('jquery');
require('intlTelInput');
require('bootstrap.floating-label');
var Swiper = require('swiper');
var CorporateEnquiries = (function () {
    function CorporateEnquiries() {
        this.swiperClassName = '.js-road-show-slider';
        this.init();
    }
    CorporateEnquiries.prototype.init = function () {
        var _this = this;
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
            new Swiper(_this.swiperClassName, {
                loop: false,
                pagination: _this.swiperClassName + ' .swiper-pagination',
                nextButton: _this.swiperClassName + ' .swiper-secondary-next',
                prevButton: _this.swiperClassName + ' .swiper-secondary-prev',
                slidesPerView: 1,
                paginationClickable: true,
                spaceBetween: 0,
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
        });
    };
    return CorporateEnquiries;
}());
new CorporateEnquiries();
