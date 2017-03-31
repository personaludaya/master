"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var PopularProducts = (function () {
    function PopularProducts() {
        this.popularProductClassName = '.js-popular-products';
        this.liveStagesBar = '.live-stages-bar';
        this.initCarousel();
    }
    PopularProducts.prototype.initCarousel = function () {
        var _this = this;
        $(document).ready(function () {
            new Swiper(_this.popularProductClassName, {
                loop: false,
                pagination: '.swiper-pagination',
                nextButton: '.swiper-next',
                prevButton: '.swiper-prev',
                nested: true,
                slidesPerView: 1,
                paginationClickable: true,
                spaceBetween: 0,
                onInit: function (swiper) {
                    if ($(window).width() <= window['brands'].mobile_screen) {
                        $(_this.liveStagesBar).each(function (index, item) {
                            new Swiper($(item), {
                                nextButton: $(item).find('.swiper-next-livestages'),
                                prevButton: $(item).find('.swiper-prev-livestages'),
                                slidesPerView: 1,
                                spaceBetween: 0,
                                nested: true,
                                onInit: function (swiper1) {
                                },
                                onTransitionEnd: function (swiper1) {
                                    if (window['brands'].tracker) {
                                        window['brands'].tracker.trackCarousel(swiper1);
                                    }
                                }
                            });
                        });
                    }
                },
                onTransitionEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
        });
    };
    return PopularProducts;
}());
exports.PopularProducts = PopularProducts;
new PopularProducts();
