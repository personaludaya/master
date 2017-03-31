"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var ProductInstruction = (function () {
    function ProductInstruction() {
        this.productInstructionSlideClassName = '.js-product-instruction-slide';
        this.initCarousel();
    }
    ProductInstruction.prototype.initCarousel = function () {
        var _this = this;
        $(document).ready(function () {
            new Swiper(_this.productInstructionSlideClassName, {
                loop: false,
                pagination: '.product-instruction-slider-pagination',
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
    return ProductInstruction;
}());
exports.ProductInstruction = ProductInstruction;
new ProductInstruction();
