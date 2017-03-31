"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var shared_1 = require('./shared');
var amplify = require('amplify');
var _ = require('underscore');
var CompareProductsContainer = (function () {
    function CompareProductsContainer() {
        this.loader = new shared_1.Loader();
        this.loaderWrapper = '.loader';
        this.wrapperClassName = '.js-compare-products';
        this.isFirstTwoSwiperItem = false;
        this.utils = new shared_1.Utils();
        this.loader.show(this.loaderWrapper);
        this.initCarousel();
    }
    CompareProductsContainer.prototype.initCarousel = function () {
        var _this = this;
        $(document).ready(function () {
            var defaultWidth = 100;
            var colCount = $(_this.wrapperClassName).find('.compare-products-slide').find('.compare-products-info').find('.content').length;
            new Swiper(_this.wrapperClassName, {
                loop: false,
                nextButton: '.swiper-next',
                prevButton: '.swiper-prev',
                slidesPerView: 4,
                // slidesPerGroup: 2,
                paginationClickable: true,
                spaceBetween: 0,
                breakpoints: {
                    767: {
                        slidesPerView: 2
                    }
                },
                onInit: function (swiper) {
                    var height = Math.max.apply(null, $('.compare-products-info').map(function (index, colItem) { return $(colItem).height(); }).get());
                    $('.compare-products-info').css('min-height', height);
                    $(swiper.wrapper).css('opacity', 1);
                    $(swiper.wrapper).find('.swiper-slide').css('opacity', 1);
                    // let colCount: number = $(this.wrapperClassName).find('.compare-products-slide').find('.compare-products-info').find('.content').length;
                    //$('.info-header-row').find('h4').css({ width: ((defaultWidth/4) * colCount) + '%' });
                    if ($(window).width() <= window['brands'].mobile_screen) {
                        //$('.info-header-row').find('h4').css({ width: ((defaultWidth/2) * ((colCount < 2)? colCount : 2)) + '%' });
                        if (colCount > 1)
                            $(swiper.wrapper).parent().parent().find('.swiper-next, .swiper-prev').css('opacity', 1);
                    }
                    _this.utils.compareProductAlignmentEqualizer();
                    _this.loader.hide(_this.loaderWrapper);
                },
                onSlideNextStart: function (swiper) {
                    if (!$(swiper.slides[swiper.activeIndex]).hasClass('compare-products-slide'))
                        return void 0;
                    var mulitplier = swiper.activeIndex;
                    if (colCount < 4 && mulitplier + 1 == colCount) {
                        mulitplier -= .5;
                    }
                },
                onSlidePrevStart: function (swiper) {
                    // $('.info-header-row').removeClass('swiper-second-group');
                    if (!$(swiper.slides[swiper.activeIndex]).hasClass('compare-products-slide'))
                        return void 0;
                    var mulitplier = swiper.activeIndex;
                    if (colCount < 4 && mulitplier + 1 == colCount) {
                        mulitplier -= .5;
                    }
                    //$('.info-header-row').find('h4').css({ width: ((defaultWidth) + (defaultWidth * mulitplier)) + '%' });  this is the original code removed caa 21032017
                    // $('.info-header-row').find('h4').css({ width: ((defaultWidth/2) * ((colCount < 2)? colCount : 2)) + '%' });
                    // $('.info-header-row').find('h4').css({ width: (defaultWidth * (swiper.activeIndex+2)) + '%' });
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
            $('a.btn-remove').each(function (index, item) {
                $(item).on('click', function (e) {
                    var href = location.toString().replace(location.search, "");
                    var productId = $(item).attr('data-product-unique-id');
                    // remove product id from session storage
                    var selectedCompareProducts = amplify.store(_this.utils.selectedProductComparisonKey);
                    var query = window.location.search.substring(1);
                    var vars = query.split("&");
                    for (var i in vars) {
                        var qs = vars[i].toString().split('=');
                        var name_1 = qs[0];
                        var q = qs[1].split(',');
                        if (name_1 == 'q') {
                            if (q.indexOf(productId) > -1) {
                                q.splice(q.indexOf(productId), 1);
                                var selectedCompareProductsFiltered = _.filter(selectedCompareProducts, function (item) {
                                    return item.id != productId;
                                });
                                amplify.store(_this.utils.selectedProductComparisonKey, selectedCompareProductsFiltered);
                            }
                            if (href.indexOf('?') > -1)
                                href += '&' + name_1 + '=' + (encodeURIComponent(q.join(',')));
                            else
                                href += '?' + name_1 + '=' + (encodeURIComponent(q.join(',')));
                        }
                        else {
                            if (href.indexOf('?') > -1)
                                href += '&' + name_1 + '=' + (encodeURIComponent(q.join('')));
                            else
                                href += '?' + name_1 + '=' + (encodeURIComponent(q.join()));
                        }
                    }
                    location.href = href;
                });
            });
        });
    };
    return CompareProductsContainer;
}());
exports.CompareProductsContainer = CompareProductsContainer;
new CompareProductsContainer();
