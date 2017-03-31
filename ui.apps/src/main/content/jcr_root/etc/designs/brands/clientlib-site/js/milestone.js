"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var Milestone = (function () {
    function Milestone() {
        this.swiperSlideClassName = '.js-milestone-toolbar-container.swiper-container';
        this.primaryColor = '#FFFFFF';
        this.secondaryColor = '#00432F';
        this.init();
    }
    Milestone.prototype.init = function () {
        var _this = this;
        var __this = this;
        $(document).ready(function () {
            new Swiper(_this.swiperSlideClassName, {
                loop: false,
                slidesPerView: 4,
                paginationClickable: true,
                centeredSlides: false,
                spaceBetween: 0,
                nextButton: '.swiper-milestone-next',
                prevButton: '.swiper-milestone-prev',
                breakpoints: {
                    1200: {
                        slidesPerView: 4
                    },
                    767: {
                        slidesPerView: 1,
                        centeredSlides: false
                    }
                },
                onInit: function (swiper) {
                    __this.initMilestoneAnchors(swiper);
                },
                onSlideChangeEnd: function (swiper) {
                    $(_this.swiperSlideClassName).find('.swiper-slide').removeClass('active');
                    window['brands'].anime.changeActiveMilestonePointIndicator(-1);
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
        });
    };
    Milestone.prototype.initMilestoneAnchors = function (swiper) {
        var _this = this;
        var _loop_1 = function(i) {
            var slide = swiper.slides[i];
            $(slide).find('.btn-link').on('click', function (e) {
                $(_this.swiperSlideClassName).find('.swiper-slide').removeClass('active');
                var targetAnchorHref = $(e.currentTarget).attr('data-ahref');
                var top = $(targetAnchorHref).offset().top;
                $(e.currentTarget).parent().addClass('active');
                if (window['brands'].anime.changeActiveMilestonePointIndicator) {
                    if ($(window).width() <= window['brands'].mobile_screen)
                        i = 0;
                    window['brands'].anime.changeActiveMilestonePointIndicator(i);
                }
                $("body").animate({ scrollTop: top }, "slow");
            });
            $(window).on('scroll', function (e) {
                if ($(window).scrollTop() > 150) {
                    $(_this.swiperSlideClassName).find('a').css('color', _this.secondaryColor);
                }
                else {
                    $(_this.swiperSlideClassName).find('a').css('color', _this.primaryColor);
                }
            });
            out_i_1 = i;
        };
        var out_i_1;
        for (var i = 0; i < swiper.slides.length; i++) {
            _loop_1(i);
            i = out_i_1;
        }
    };
    return Milestone;
}());
exports.Milestone = Milestone;
new Milestone();
