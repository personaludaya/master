"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var BeMagazineContainer = (function () {
    function BeMagazineContainer() {
        this.slideClassName = '.js-be-magazine-articles';
        this.lastReachedProgress = 0;
        this.isLastSlide = false;
        this.initCarousel();
    }
    BeMagazineContainer.prototype.initCarousel = function () {
        var _this = this;
        $(document).ready(function () {
            new Swiper(_this.slideClassName, {
                loop: false,
                pagination: '.swiper-pagination',
                slidesPerView: 3,
                paginationClickable: true,
                spaceBetween: 30,
                centeredSlides: false,
                breakpoints: {
                    767: {
                        spaceBetween: 10,
                        slidesPerView: 1.1
                    }
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                    if (_this.lastReachedProgress >= 1) {
                        _this.isLastSlide = true;
                    }
                    else {
                        _this.isLastSlide = false;
                    }
                    if ($(swiper.slides[swiper.activeIndex + 1]).length > 0)
                        $(swiper.slides[swiper.activeIndex + 1]).css({ opacity: 0.5 });
                    if ($(swiper.slides[swiper.activeIndex - 1]).length > 0)
                        $(swiper.slides[swiper.activeIndex - 1]).css({ opacity: 0.5 });
                },
                onReachBeginning: function (swiper) {
                    $(swiper.slides[swiper.activeIndex]).css({ opacity: 0.5 });
                },
                onReachEnd: function (swiper) {
                    $(swiper.slides[swiper.activeIndex]).css({ opacity: 0.5 });
                },
                onProgress: function (swiper, progress) {
                    if (progress > _this.lastReachedProgress) {
                        var finalProgress = progress * (swiper.slides.length - (swiper.activeIndex + 1));
                        if (finalProgress < 0.5)
                            finalProgress = 0.5;
                        if (swiper.slides.length >= swiper.activeIndex) {
                            $(swiper.slides[swiper.activeIndex + 1]).css({ opacity: finalProgress });
                        }
                        if (progress >= 1) {
                            _this.isLastSlide = true;
                        }
                        else {
                            _this.isLastSlide = false;
                        }
                    }
                    else {
                        var activeIndex = swiper.activeIndex;
                        if (_this.isLastSlide) {
                            activeIndex = activeIndex + 1;
                        }
                        var finalProgress = (1 - progress) * (activeIndex);
                        if (finalProgress < 0.5)
                            finalProgress = 0.5;
                        $(swiper.slides[activeIndex - 1]).css({ opacity: finalProgress });
                    }
                    _this.lastReachedProgress = progress;
                }
            });
        });
    };
    return BeMagazineContainer;
}());
exports.BeMagazineContainer = BeMagazineContainer;
new BeMagazineContainer();
