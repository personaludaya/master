"use strict";
var $ = require('jquery');
var shared_1 = require('./shared');
var Swiper = require('swiper');
var BeMagazineLanding = (function () {
    function BeMagazineLanding() {
        this.bemagazinecategorySlider = '.js-be-magazine-category';
        this.articleSlider = '.js-article-slider';
        this.bemagazineContent = '.be-magazine-category-content';
        this.bemagazineContentWrapper = '.be-magazine-category-content-wrapper';
        this.loadOnce = true;
        this.loader = new shared_1.Loader();
        this.bemagazineDefaultSlideIndex = 1;
        this.init();
    }
    BeMagazineLanding.prototype.init = function () {
        var _this = this;
        var __this = this;
        $(document).ready(function () {
            $(_this.bemagazinecategorySlider).each(function (index, item) {
                var swiper = new Swiper($(item), {
                    loop: false,
                    slidesPerView: 2,
                    paginationClickable: true,
                    centeredSlides: true,
                    spaceBetween: 0,
                    breakpoints: {
                        1199: {
                            slidesPerView: 1
                        }
                    },
                    nextButton: $(item).parent().find('.swiper-bemagazine-category-next'),
                    prevButton: $(item).parent().find('.swiper-bemagazine-category-prev'),
                    onInit: function (swiper) {
                        var currentIndex = __this.bemagazineDefaultSlideIndex;
                        var prevIndex = currentIndex - 1;
                        var nextIndex = currentIndex + 1;
                        __this.loadPage(swiper, currentIndex);
                        __this.loadPage(swiper, prevIndex);
                        __this.loadPage(swiper, nextIndex);
                    },
                    onSlideChangeEnd: function (swiper) {
                        var currentIndex = swiper.activeIndex;
                        var prevIndex = currentIndex - 1;
                        var nextIndex = currentIndex + 1;
                        __this.loadPage(swiper, currentIndex);
                        __this.loadPage(swiper, prevIndex);
                        __this.loadPage(swiper, nextIndex);
                        if (window['brands'].tracker) {
                            window['brands'].tracker.trackCarousel(swiper);
                        }
                    }
                });
                swiper.slideTo(_this.bemagazineDefaultSlideIndex, 0, false);
            });
        });
    };
    BeMagazineLanding.prototype.loadPage = function (swiper, index) {
        var _this = this;
        if (index > -1 && index < swiper.slides.length && swiper.slides[index]) {
            if (!this.loadOnce || (this.loadOnce && $(swiper.slides[index]).find(this.bemagazineContent).html() == '')) {
                // load ajax content here
                var endpoint = $(swiper.slides[index]).attr('data-url');
                this
                    .render(endpoint || "/be-magazine-landing-category.html", $(swiper.slides[index]).find(this.bemagazineContent))
                    .then(function (html) {
                    $(swiper.slides[index]).find(_this.bemagazineContent).html(html);
                    _this.postRender(swiper.slides[index]);
                });
            }
        }
    };
    BeMagazineLanding.prototype.postRender = function (specificSlide) {
        $(specificSlide).find(this.articleSlider).each(function (index, item) {
            new Swiper($(item), {
                loop: false,
                slidesPerView: 1,
                paginationClickable: true,
                centeredSlides: false,
                spaceBetween: 0,
                nested: true,
                nextButton: $(item).parent().find('.swiper-next'),
                prevButton: $(item).parent().find('.swiper-prev')
            });
        });
    };
    BeMagazineLanding.prototype.render = function (endpoint, container) {
        var _this = this;
        this.loader.show(container);
        var defer = $.Deferred();
        $.get(endpoint)
            .success(function (html) {
            _this.loader.hide(container);
            defer.resolve($(html).find(_this.bemagazineContentWrapper).html());
        })
            .error(function (error) {
            _this.loader.hide(container);
            defer.reject(error);
        });
        return defer.promise();
    };
    return BeMagazineLanding;
}());
exports.BeMagazineLanding = BeMagazineLanding;
new BeMagazineLanding();
