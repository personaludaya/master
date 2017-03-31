"use strict";
var $ = require('jquery');
require('jquery.visible');
require('skrollr');
var shared_1 = require('./shared');
var DATASPEED_NORMAL = 'normal';
var DATASPEED_MEDIUM = 'medium';
var DATASPEED_FAST = 'fast';
var Footer = (function () {
    function Footer() {
        this.utils = new shared_1.Utils();
        this.addthisTryAttempt = 10;
        this.addthisTryTimeout = 500;
        this.addthisTryCount = 0;
        this.homeScreen1Selector = '.home--screen1';
        this.dataAccordionIdSelector = 'data-accordion-id';
        this.shareBtnSelector = '.at-share-dock';
        this.dataSpeedSelector = 'data-speed';
        this.init();
    }
    Footer.prototype.init = function () {
        var _this = this;
        $(document).ready(function () {
            retinajs();
            if (skrollr) {
                var dataSpeedBg_1 = $('.background-container[' + _this.dataSpeedSelector + ']').attr(_this.dataSpeedSelector);
                $('.background-container').each(function (index, item) {
                    if ($(item).attr('data-top-bottom')) {
                        if (dataSpeedBg_1 == DATASPEED_NORMAL) {
                            $(item).attr('data-top-bottom', 'background-position: center -250px');
                        }
                        else if (dataSpeedBg_1 == DATASPEED_MEDIUM) {
                            $(item).attr('data-top-bottom', 'background-position: center -500px');
                        }
                        else if (dataSpeedBg_1 == DATASPEED_FAST) {
                            $(item).attr('data-top-bottom', 'background-position: center -750px');
                        }
                        else {
                            $(item).attr('data-top-bottom', 'background-position: center -250px');
                        }
                    }
                });
                var s = skrollr.init();
                if (s.isMobile()) {
                    s.destroy();
                }
            }
            // $('.canvas-background').parallax("center", 0.1);
            // $('.background-container').parallax({ speed: 0.3 });
            // $('*[data-parallax-activate]').parallax({ speed: 0.5 });
            // $('.home--screen1, .home--screen2, .home--screen3, .home--screen4, .home--screen5').find('.background-cover-image').parallax("center", 0.1);
            // var ctrl = new ScrollMagic.Controller({globalSceneOptions: {triggerHook: "onEnter", duration: "200%"}});
            // new ScrollMagic.Scene({
            //   triggerElement: ".section-container:first"
            // })
            // .setTween(".section-container:first > .background-container", { y: "80%" })
            // .addTo(ctrl); // assign the scene to the controller
            if ($('#loaderPath').length > 0) {
                window['brands'].icons.loader = $('#loaderPath').val();
                window['brands'].icons.close = $('#iconClosePath').val();
                window['brands'].icons.arrowUp = $('#iconArrowUpPath').val();
                window['brands'].icons.arrowDown = $('#iconArrowDownPath').val();
            }
            $("*[" + _this.dataAccordionIdSelector + "]").each(function (index, item) {
                new shared_1.AccordionComponent($(item).attr('id'));
            });
            if ($(_this.homeScreen1Selector).length > 0) {
                $('.js-go-top-parent-container .go-top-wrapper').hide();
            }
            $(window).scroll(function (e) {
                // go to top container starts here
                if (!$('.js-go-top-parent-container').visible()) {
                    if ($(window).width() <= window['brands'].mobile_screen) {
                        $(_this.shareBtnSelector).removeClass('at4-visible').addClass('at4-hide').css({ opacity: 0 });
                    }
                    if ($(window).scrollTop() === 0) {
                        $('.go-top-wrapper').removeClass('fixed');
                    }
                    else {
                        $('.go-top-wrapper').addClass('fixed');
                    }
                }
                else {
                    $('.go-top-wrapper').removeClass('fixed');
                    if ($(window).width() <= window['brands'].mobile_screen) {
                        $(_this.shareBtnSelector).removeClass('at4-hide').addClass('at4-show').css({ opacity: 1 });
                    }
                }
                // go to top container ends here
                // comparison sticky bar starts here
                if (!$('.product-comparison-bar-container').visible()) {
                    if ($(window).scrollTop() === 0) {
                        $('.product-comparison-bar-container').removeClass('fixed');
                    }
                    else {
                        $('.product-comparison-bar-container').addClass('fixed');
                    }
                }
                else {
                    $('.product-comparison-bar-container').removeClass('fixed');
                }
                // comparison sticky bar ends here
            });
            // $('.brands-canvas').find('.section-container:first').css('min-height', $(window).height() - 440);
            setTimeout(function () {
                _this.utils.productOverviewButtonAlignmentEqualizer();
                _this.utils.articleListingAlignmentEqualizer();
                _this.utils.bindProductComparison();
            }, 100);
            $(window).resize(function () {
                _this.utils.productOverviewButtonAlignmentEqualizer();
                _this.utils.articleListingAlignmentEqualizer();
            });
            _this.initAddThisEventHandler();
        });
        $('.go-top a').on('click', function () {
            $("body").animate({ scrollTop: 0 }, "slow");
        });
    };
    Footer.prototype.initAddThisEventHandler = function () {
        var _this = this;
        setTimeout(function () {
            _this.addthisTryCount++;
            if (!addthis && _this.addthisTryCount <= _this.addthisTryAttempt) {
                _this.initAddThisEventHandler();
            }
        }, this.addthisTryTimeout);
        if (!addthis)
            return void 0;
        addthis.layers({
            scrollDepth: 100000
        });
        var eventHandler = function (evt) {
            switch (evt.type) {
                case "addthis.ready":
                    break;
                case "addthis.menu.open":
                    break;
                case "addthis.menu.close":
                    break;
                case "addthis.menu.share":
                    if (window['brands'].tracker && evt.data.service) {
                        window['brands'].tracker.trackSocialShare(evt.data.service, evt.data.url);
                    }
                    break;
                case "addthis.layers.scroll":
                    // console.log('scrolling');
                    break;
                default:
            }
        };
        if ($(window).width() <= window['brands'].mobile_screen) {
            $('.extra-footer').addClass('with-addthis');
        }
        addthis.addEventListener('addthis.ready', eventHandler);
        addthis.addEventListener('addthis.menu.open', eventHandler);
        addthis.addEventListener('addthis.menu.close', eventHandler);
        addthis.addEventListener('addthis.menu.share', eventHandler);
        // if($(window).width() <= window['brands'].mobile_screen) {
        //   addthis.removeEventListener('addthis.layers.scroll');
        //   addthis.detachEvent('addthis.layers.scroll');
        // }
    };
    return Footer;
}());
new Footer();
