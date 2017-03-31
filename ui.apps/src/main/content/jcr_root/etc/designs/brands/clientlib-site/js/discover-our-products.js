"use strict";
var $ = require('jquery');
var shared_1 = require('./shared');
var DiscoverOurProduct = (function () {
    function DiscoverOurProduct() {
        this.utils = new shared_1.Utils();
        this.init();
    }
    DiscoverOurProduct.prototype.init = function () {
        $('.product-row-wrapper').each(function () {
            $(this).find('.product-col-wrapper.hidden-xs').first().removeClass('hidden-xs');
        });
        $('.product-container .view-all').each(function () {
            $(this).find('span').text($(this).closest('.product-container').find('.product-row-wrapper .product-col-wrapper').length);
            $(this).on('click', function () {
                if ($(this).closest('.product-container').find('.product-col-wrapper').hasClass('hidden-xs')) {
                    $(this).closest('.product-container').find('.product-col-wrapper').removeClass('hidden-xs');
                    $(this).closest('.product-container').find('.icon-expand').first().addClass('hide');
                    $(this).closest('.product-container').find('.icon-collapse').first().removeClass('hide');
                }
                else {
                    $(this).closest('.product-container').find('.product-col-wrapper').addClass('hidden-xs');
                    $(this).closest('.product-container').find('.product-col-wrapper').first().removeClass('hidden-xs');
                    $(this).closest('.product-container').find('.icon-expand').first().removeClass('hide');
                    $(this).closest('.product-container').find('.icon-collapse').first().addClass('hide');
                }
            });
        });
        this.utils.bindProductComparison();
    };
    return DiscoverOurProduct;
}());
exports.DiscoverOurProduct = DiscoverOurProduct;
new DiscoverOurProduct();
