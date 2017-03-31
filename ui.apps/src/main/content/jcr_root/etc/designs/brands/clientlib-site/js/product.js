"use strict";
var $ = require('jquery');
require('bootstrap');
var Swiper = require('swiper');
var Product = (function () {
    function Product() {
        var _this = this;
        this.productInfoSlide = '.js-product-info-slide';
        this.productInstructionSelector = '.product-instruction';
        this.productSignpostSelector = '.product-detail--product-sale';
        this.dataAccordionIdSelector = 'data-accordion-id';
        this.productCampaignClasses = [
            ".product-detail--ec-campaign1",
            ".product-detail--ec-campaign2",
            ".product-detail--activemove-campaign1",
            ".product-detail--genu-campaign1",
            ".product-detail--lutein-campaign1",
            ".product-detail--lutein-campaign2",
            ".product-detail--genu-campaign2"
        ];
        this.productDetailInfoSelector = '.product-detail--info';
        this.productNutritionDetailSelector = '.product-nutrition-detail';
        $(document).ready(function () {
            _this.init();
        });
    }
    Product.prototype.init = function () {
        var _this = this;
        this.initProductBenefits();
        this.initProductInfoSlider();
        // $('#productfaqaccordion').find('.accordion-wrapper').each((index: number, item: any): void => {
        //   if(index > 3) {
        //     $(item).hide();
        //   }
        // });
        // $('#seemorefaq').on('click', (e: any): void => {
        //   $('#productfaqaccordion').find('.accordion-wrapper:hidden').each((index: number, item: any): void => {
        //     if(index < 3) {
        //       $(item).fadeIn();
        //     }
        //   });
        //   if($('#productfaqaccordion').find('.accordion-wrapper:hidden').length < 1) {
        //     $('#seemorefaq').hide();
        //   }
        // });
        $(document).ready(function () {
            if ($(_this.productCampaignClasses.join(', ')).length < 1) {
                // add padding-bottom
                $(_this.productDetailInfoSelector).css({ 'padding-bottom': '80px' });
            }
            //let parentClassName: string = $(this.productInstructionSelector).parent();
            if ($('div').hasClass('product-detail--product-instruction-lutein'))
                $(_this.productInstructionSelector).find('.product-image-wrapper').css('left', -($(_this.productInstructionSelector).find('.product-image-wrapper img').width() / 3));
            else
                $(_this.productInstructionSelector).find('.product-image-wrapper').css('left', -($(_this.productInstructionSelector).find('.product-image-wrapper img').width() / 2));
            //$(this.productInstructionSelector).find('.product-image-wrapper').css('left', -($(this.productInstructionSelector).find('.product-image-wrapper img').width()/3));
            $(_this.productInstructionSelector).find('.product-image-wrapper').css('top', ($(_this.productInstructionSelector).find('img.full-width').height() - $(_this.productInstructionSelector).find('.product-image-wrapper img').height()) / 2);
            // $(this.productSignpostSelector).find('.content-wrapper').css('margin-top', ($(this.productSignpostSelector).find('img.img-first').height() - $(this.productSignpostSelector).find('.content-wrapper').height())/2);
            if ($(window).width() > window['brands'].mobile_screen) {
                var height = Math.max.apply(null, $(_this.productNutritionDetailSelector).find('.col-xs-12').map(function (index, colItem) { return $(colItem).height(); }).get());
                $(_this.productNutritionDetailSelector).find('.col-xs-12').height(height);
            }
        });
    };
    Product.prototype.initProductBenefits = function () {
        // new AccordionComponent('productbenefits');
        // new AccordionComponent('faq');
        // new AccordionComponent('videoaccordion');
        // new AccordionComponent('userreviewaccordion');
        // new AccordionComponent('aboutproductaccordion');
        // new AccordionComponent('instructionaccordion');
        // new AccordionComponent('productnutritionaccordion');
        // new AccordionComponent('productfaqaccordion');
        // new AccordionComponent('productmanufacturingprocessaccordion');
    };
    Product.prototype.initProductInfoSlider = function () {
        new Swiper(this.productInfoSlide, {
            loop: false,
            pagination: '.swiper-pagination',
            nextButton: '.swiper-next',
            prevButton: '.swiper-prev',
            slidesPerView: 1,
            paginationClickable: true,
            spaceBetween: 0,
            onSlideChangeEnd: function (swiper) {
                if (window['brands'].tracker) {
                    window['brands'].tracker.trackCarousel(swiper);
                }
            }
        });
    };
    return Product;
}());
exports.Product = Product;
var product = new Product();
