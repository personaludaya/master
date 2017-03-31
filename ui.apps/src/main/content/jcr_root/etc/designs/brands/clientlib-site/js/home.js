"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
require('jquery.visible');
var Home = (function () {
    function Home() {
        this.homeScreen = '.home-screen';
        this.cookiePolicy = '.cookie-policy';
        this.header = '.header';
        this.productInfoImageSelector = '.product-info-image';
        this.popularProductSelector = '.js-popular-products';
        this.shareBtnSelector = '.at-share-dock';
        this.homeScreenSelector = '.home--screen';
        this.init();
    }
    Home.prototype.init = function () {
        var _this = this;
        $(document).ready(function () {
            if (!$.cookie('cookiepolicy')) {
                $(_this.header).addClass('with-cookiepolicy');
                $(_this.cookiePolicy).addClass('fixed');
                $(_this.homeScreen).addClass('with-cookiepolicy');
            }
            var startScroll = false;
            var touchStart = false;
            var touchCurrent = false;
            var swiper = new Swiper(_this.homeScreen, {
                loop: false,
                // pagination: '.swiper-pagination',
                resistance: false,
                resistanceRatio: 0,
                shortSwipes: true,
                longSwipes: false,
                followFinger: false,
                direction: 'vertical',
                slidesPerView: 1,
                paginationClickable: true,
                spaceBetween: 0,
                mousewheelInvert: true,
                keyboardControl: true,
                mousewheelControl: true,
                mousewheelForceToAxis: true,
                mousewheelReleaseOnEdges: true,
                // mousewheelSensitivity: 0.5,
                progress: false,
                parallax: false,
                speed: 750,
                // speed: 0,
                noSwiping: true,
                // effect: 'coverflow',
                virtualTranslate: false,
                coverflow: {
                    rotate: 10,
                    stretch: 0,
                    depth: 10,
                    modifier: 1,
                    slideShadows: false
                },
                onInit: function (swiper) {
                    swiper.lockSwipeToPrev();
                    // if($(window).prop('outerWidth') <= window['brands'].mobile_screen) {
                    if ($('.home--screen2').length > 0 && $(_this.productInfoImageSelector).length > 0 && $(_this.popularProductSelector).length > 0) {
                        // $(this.popularProductSelector).find('.swiper-next, .swiper-prev').css({ 'top': (($(this.productInfoImageSelector).offset().top - $('.home--screen2').offset().top) + ($(this.productInfoImageSelector).height()/2 -  $(this.popularProductSelector).find('.swiper-next').height()/2)) });
                        // + $(this.popularProductSelector).find('h2')
                        $(_this.popularProductSelector).find('.swiper-next, .swiper-prev').css({ 'top': ($('.popular-product-info-content').position().top + ($('.popular-product-info-content').find(_this.productInfoImageSelector).height() + $(_this.popularProductSelector).find('.swiper-next, .swiper-prev').height()) / 2) });
                    }
                    $('.home--screen5').closest(".swiper-slide").addClass("swiper-no-swiping");
                    // }
                    $('.home-screen').find('.section-container').first().find('.background-container').find('.hero-canvas').remove();
                    $('.home-screen').find('.section-container').first().find('.background-container').prepend('<div class="hero-canvas"></div>');
                    window['brands'].anime.drawOnCanvas($('.home-screen').find('.section-container').first());
                },
                onTransitionStart: function (swiper) {
                    var selector = _this.homeScreenSelector + (swiper.activeIndex + 1);
                    if ($(selector).length > 0) {
                        // if($(window).prop('outerWidth') > window['brands'].mobile_screen) {
                        $(selector).find('.background-container').find('.hero-canvas').remove();
                        if (swiper.activeIndex == 1) {
                            $(selector).find('.background-container').prepend('<div class="hero-canvas" data-anime-type="home--popular-product"></div>');
                        }
                        else {
                            $(selector).find('.background-container').prepend('<div class="hero-canvas"></div>');
                        }
                        window['brands'].anime.drawOnCanvas(selector);
                    }
                    // $('.campaign-container').css('opacity', 0);
                    // if(swiper.activeIndex == 1) {
                    //   // $('.leftNavBar').find('h5').animate({ opacity: 1 }, 2000);
                    // }
                    // else if(swiper.activeIndex == 2) {
                    //   $('.campaign-container').stop().animate({
                    //      opacity: 1
                    //   }, 600);  
                    // }
                },
                onTransitionEnd: function (swiper) {
                    if (swiper.activeIndex > 0) {
                        swiper.unlockSwipeToPrev();
                    }
                    else {
                        swiper.lockSwipeToPrev();
                    }
                    /*if(swiper.activeIndex == 4) {
                      swiper.disableMousewheelControl();
                      swiper.disableTouchControl();
                      swiper.lockSwipeToNext();
                      $('.home--screen5').scrollTo(1);
                    } else {
                      swiper.enableMousewheelControl();
                      swiper.enableTouchControl();
                      swiper.unlockSwipeToNext();
                    }*/
                    $('.nodes').find('.node').each(function (index, node) {
                        // <=
                        if (index == swiper.activeIndex) {
                            $(node).addClass('active');
                            $('.red-container').css('height', (40 * index) + 'px');
                        }
                        else {
                            $(node).removeClass('active');
                        }
                    });
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                },
                onSlideNextStart: function (swiper) {
                    if (swiper.activeIndex == 4) {
                        $('.home--screen5').scrollTo(5);
                    }
                }
            });
            $('div.node').on('click', function (e) {
                var index = $(e.currentTarget).attr('data-swiper-index');
                if (index > 0) {
                    swiper.slideTo(index - 1);
                }
            });
            if ($('.campaign-human').length > 0 && $('.info').length > 0) {
                $('.info').css({ left: ($('.campaign-human').offset().left + $('.campaign-human').width()) });
            }
            $('.home--screen5').on('scroll', function (e) {
                if ($('.home--screen5').closest(".swiper-slide-active").length > 0) {
                    if ($('.home--screen5').scrollTop() < 5) {
                        $(_this.header).removeClass('with-background');
                        //swiper.enableMousewheelControl();
                        swiper.slideTo(3);
                    }
                    else if ($('.home--screen5').scrollTop() > 20) {
                        $(_this.header).addClass('with-background');
                    }
                    else {
                        $(_this.header).removeClass('with-background');
                        // $('.at-this-dock').show();
                        if (!$('.js-go-top-parent-container').visible()) {
                            if ($(window).width() <= window['brands'].mobile_screen) {
                                $(_this.shareBtnSelector).hide();
                            }
                        }
                        else {
                            if ($(window).width() <= window['brands'].mobile_screen) {
                                $(_this.shareBtnSelector).show();
                            }
                        }
                    }
                }
            });
        });
    };
    return Home;
}());
new Home();
