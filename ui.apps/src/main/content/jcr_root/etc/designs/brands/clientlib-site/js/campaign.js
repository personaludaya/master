"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var Campaign = (function () {
    function Campaign() {
        this.campaignClassName = '.js-campaign';
        this.initCarousel();
    }
    Campaign.prototype.initCarousel = function () {
        var _this = this;
        $(document).ready(function () {
            var interval = $('.js-campaign').attr('data-interval');
            var disableSwipe = $('.swiper-wrapper .campaign-info.swiper-slide').length > 1;
            if (disableSwipe) {
                new Swiper(_this.campaignClassName, {
                    loop: false,
                    autoplay: interval,
                    autoplayDisableOnInteraction: false,
                    onInit: function (swiper) {
                        swiper.disableTouchControl();
                    }
                }); //Swiper
            }
        }); //document ready
    };
    return Campaign;
}());
exports.Campaign = Campaign;
new Campaign();
