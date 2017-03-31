"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var ProductManufacturingProcess = (function () {
    function ProductManufacturingProcess() {
        this.productManufacturingProcessSlideClassName = '.js-product-manufacturing-process-slide';
        this.initCarousel();
    }
    ProductManufacturingProcess.prototype.initCarousel = function () {
        var _this = this;
        $(document).ready(function () {
            new Swiper(_this.productManufacturingProcessSlideClassName, {
                loop: false,
                paginationType: 'custom',
                pagination: '.swiper-pagination',
                nextButton: '.product-manufacturing-process-next',
                prevButton: '.product-manufacturing-process-prev',
                slidesPerView: 1,
                paginationClickable: true,
                spaceBetween: 0,
                paginationCustomRender: function (swiper, current, total) {
                    var html = '<div>' + current + ' of ' + total + '</div>';
                    for (var i = 1; i <= total; i++) {
                        if (i == current)
                            html += '<span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span>';
                        else
                            html += '<span class="swiper-pagination-bullet"></span>';
                    }
                    // return '<span class="swiper-pagination-bullet">' + current + '</span>';
                    // return '<span class="' + currentClassName + '"></span>' +
                    //    ' of ' +
                    //    '<span class="' + totalClassName + '"></span>';
                    return html;
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
        });
    };
    return ProductManufacturingProcess;
}());
exports.ProductManufacturingProcess = ProductManufacturingProcess;
new ProductManufacturingProcess();
