"use strict";
var $ = require('jquery');
var shared_1 = require('./shared');
var productTemplate = require('product-container-partial');
var Swiper = require('swiper');
var BeMagazineListing = (function () {
    function BeMagazineListing() {
        this.wrapperClassName = '.js-product-container-wrapper';
        this.swiperSlideClassName = '.js-toolbar-container';
        this.maxAllowedSelection = 3;
        this.ourProductEndPoint = '/dummy-data/data.json';
        this.loader = new shared_1.Loader();
        this.clearAll = '#clearall';
        this.categorySlider = '.js-category-container';
        this.contenttypeSlider = '.js-contenttype-container';
        this.articleSlider = '.js-article-slider';
        this.rowLoadLimitSelector = 'data-row-load-limit';
        this.colLoadLimitSelector = 'data-col-load-limit';
        this.rowLoadLimit = 1;
        this.colLoadLimit = 4;
        this.init();
    }
    BeMagazineListing.prototype.init = function () {
        var _this = this;
        var __this = this;
        this.render().then(function (html) {
            $(_this.wrapperClassName).html(html);
            _this.postRender();
        });
        $(document).ready(function () {
            _this.rowLoadLimit = $('.be-magazine-listing--listing-content').attr(_this.rowLoadLimitSelector) || _this.rowLoadLimit;
            _this.colLoadLimit = $('.be-magazine-listing--listing-content').attr(_this.colLoadLimitSelector) || _this.colLoadLimit;
            $('.js-toolbar-container li').each(function (index, item) {
                $(this).on('click', function (e) {
                    if ($(item).hasClass('active') === false) {
                        if ($('.js-toolbar-container li.active').length >= __this.maxAllowedSelection)
                            return void 0;
                        $(item).addClass('active');
                    }
                    else {
                        $(item).removeClass('active');
                    }
                    __this.render().then(function (html) {
                        $(__this.wrapperClassName).html(html);
                        __this.postRender();
                    });
                });
            });
            $(_this.clearAll).on('click', function () {
                location.reload();
            });
            new Swiper(_this.categorySlider, {
                loop: false,
                slidesPerView: 6,
                paginationClickable: true,
                centeredSlides: false,
                spaceBetween: 10,
                nextButton: '.swiper-category-next',
                prevButton: '.swiper-category-prev',
                breakpoints: {
                    867: {
                        slidesPerView: 3
                    },
                    767: {
                        slidesPerView: 2
                    }
                },
                onInit: function (swiper) {
                    $(_this.categorySlider).css('opacity', 1);
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
            new Swiper(_this.contenttypeSlider, {
                loop: false,
                slidesPerView: 4,
                paginationClickable: true,
                centeredSlides: false,
                spaceBetween: 10,
                nextButton: '.swiper-category-next1',
                prevButton: '.swiper-category-prev1',
                breakpoints: {
                    1300: {
                        slidesPerView: 3
                    },
                    967: {
                        slidesPerView: 2
                    },
                    767: {
                        slidesPerView: 1
                    }
                },
                onInit: function (swiper) {
                    $(_this.contenttypeSlider).css('opacity', 1);
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
            $(_this.articleSlider).each(function (index, item) {
                new Swiper($(item), {
                    loop: false,
                    slidesPerView: 1,
                    paginationClickable: true,
                    centeredSlides: false,
                    spaceBetween: 0,
                    nextButton: $(item).parent().find('.swiper-next'),
                    prevButton: $(item).parent().find('.swiper-prev'),
                    onSlideChangeEnd: function (swiper) {
                        if (window['brands'].tracker) {
                            window['brands'].tracker.trackCarousel(swiper);
                        }
                    }
                });
            });
            _this.postRender();
        });
    };
    BeMagazineListing.prototype.postRender = function () {
        var _this = this;
        $('.be-magazine-listing--listing-content').find('.col-xs-12').each(function (index, item) {
            if (index >= (_this.rowLoadLimit * _this.colLoadLimit)) {
                $(item).hide();
            }
        });
        $('.be-magazine-listing--listing-content .view-all').off().on('click', function (e) {
            $('.be-magazine-listing--listing-content').find('.col-xs-12:hidden').each(function (index, item) {
                if (index < (_this.rowLoadLimit * _this.colLoadLimit)) {
                    $(item).fadeIn();
                }
                if ($('.be-magazine-listing--listing-content').find('.col-xs-12:hidden').length < 1) {
                    $(e.currentTarget).hide();
                }
            });
        });
        if ($('.be-magazine-listing--listing-content').find('.col-xs-12:hidden').length < 1) {
            $('.be-magazine-listing--listing-content .view-all').hide();
        }
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
    };
    BeMagazineListing.prototype.render = function () {
        var _this = this;
        this.loader.show(this.wrapperClassName);
        var html = '';
        var defer = $.Deferred();
        $.get(this.ourProductEndPoint)
            .success(function (data) {
            // just for local testing
            if ($('.js-toolbar-container li.active').length > 0)
                data.ourProducts.splice($('.js-toolbar-container li.active').length, data.ourProducts.length);
            // just for local testing
            for (var _i = 0, _a = data.ourProducts; _i < _a.length; _i++) {
                var ourProduct = _a[_i];
                html += productTemplate.template({
                    title: ourProduct.title,
                    tileList: ourProduct.tiles
                });
            }
            _this.loader.hide(_this.wrapperClassName);
            defer.resolve(html);
        })
            .error(function (error) {
            _this.loader.hide(_this.wrapperClassName);
            defer.reject(error);
        });
        return defer.promise();
    };
    return BeMagazineListing;
}());
exports.BeMagazineListing = BeMagazineListing;
new BeMagazineListing();
