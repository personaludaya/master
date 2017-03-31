"use strict";
var $ = require('jquery');
require('jquery.visible');
var amplify = require('amplify');
// data layer is part of layout html
var Analytics = (function () {
    function Analytics() {
        var _this = this;
        this.dataAnalyticsAttr = 'data-analytics';
        $(document).ready(function () {
            _this.initDTM();
            var defaultDataLayer = {
                page: {
                    attributes: {
                        siteType: (($(window).width() <= window['brands'].mobile_screen) ? 'mobile' : 'desktop')
                    }
                }
            };
            _this.extendDataLayer(defaultDataLayer);
            _this.initDataExtenders();
            _this.initDataAnalytics(false);
            _this.initExternalAndDownloadLinks();
            _this.initMailTo();
            _this.initTel();
            _this.trackOnceForAnalyticsHash();
        });
    }
    Analytics.prototype.track = function (dataLayer) {
        $.extend(true, brandsDataLayer, dataLayer);
        _satellite.track(dataLayer.event.eventInfo.eventType);
    };
    Analytics.prototype.checkIfAnalyticsExists = function () {
        return typeof (_satellite) !== "undefined";
    };
    ;
    Analytics.prototype.dtmTrack = function (dataLayer, source) {
        var _this = this;
        if (!dataLayer || !this.checkIfAnalyticsExists())
            return void 0;
        if (dataLayer.event && dataLayer.event.eventInfo) {
            if (!source) {
                // direct tracking here
                this.track(dataLayer);
            }
            else {
                // data-analytics
                $(source).on('click', function (e) {
                    if (!$(e.currentTarget).attr(_this.dataAnalyticsAttr))
                        return void 0;
                    var dataLayer = JSON.parse($(e.currentTarget).attr(_this.dataAnalyticsAttr));
                    var href = $(e.currentTarget).attr('href');
                    if (e.currentTarget.localName == 'a' && href && typeof href != 'undefined' && $(e.currentTarget).attr('target') != '_blank' && (href.indexOf('tel') != 0 && href.indexOf('mailto') != 0)) {
                        e.preventDefault();
                        //redirect
                        _this.buildAnalyticsWithLocalStorage(href, dataLayer);
                        return void 0;
                    }
                    _this.track(dataLayer);
                });
            }
        }
    };
    Analytics.prototype.initDTM = function () {
        var _this = this;
        $.fn.dtmTrack = function (dataLayer, source) {
            _this.dtmTrack(dataLayer, source);
        };
        // this.initDataAnalytics(false);
    };
    Analytics.prototype.extendDataLayer = function (dataLayer) {
        $.extend(true, brandsDataLayer, dataLayer);
    };
    Analytics.prototype.initDataAnalytics = function (html) {
        var _this = this;
        var dataAnalyticsObj = $('*[data-analytics]');
        if (html) {
            dataAnalyticsObj = $(html).find('*[data-analytics]');
        }
        $(dataAnalyticsObj).each(function (index, item) {
            try {
                var dataLayer = JSON.parse($(item).attr(_this.dataAnalyticsAttr));
                $(item).dtmTrack(dataLayer, item);
            }
            catch (e) {
            }
        });
    };
    Analytics.prototype.initDataExtenders = function () {
        var _this = this;
        $('*[data-analytics-extend]').each(function (index, item) {
            try {
                var dataLayer = JSON.parse($(item).attr('data-analytics-extend'));
                _this.extendDataLayer(dataLayer);
            }
            catch (e) {
            }
        });
    };
    Analytics.prototype.initExternalAndDownloadLinks = function () {
        var _this = this;
        $('a[target="_blank"]:not([data-analytics])').each(function (index, item) {
            if ($(item).parent().length > 0 && $(_this).parent().hasClass('swiper-slide'))
                return void 0;
            $(item).on('click', function (e) {
                e.preventDefault();
                var eventName = $(e.currentTarget).text();
                var title = 'downloadLinks';
                var href = $(e.currentTarget).attr('href');
                var index = href.indexOf('?');
                if (index == -1)
                    index = href.length;
                else
                    index -= 1;
                var titleObj = href.substring(0, index).split(/[\\/]/).pop();
                titleObj = titleObj.split('.');
                if (titleObj.length != 2) {
                    // external link as there is no extension
                    title = 'External Link';
                }
                var ext = titleObj.pop().replace(/s+/, '');
                if (ext == 'html' || ext == 'htm') {
                    title = 'External Link';
                }
                if ($(e.currentTarget).attr('href').indexOf('tripadvisor.com') !== -1) {
                    eventName = "Trip Advisor";
                }
                if (eventName)
                    eventName = eventName.replace(/(\r\n|\n|\r)/g, "").replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
                var dataLayer = {
                    event: {
                        eventInfo: {
                            eventType: title,
                            eventName: eventName,
                            eventURL: $(e.currentTarget).attr('href')
                        }
                    }
                };
                $(e.currentTarget).dtmTrack(dataLayer);
                window.open($(e.currentTarget).attr('href'), '_blank');
            });
        });
    };
    Analytics.prototype.initMailTo = function () {
        $('a[href^="mailto:"]:not([data-analytics])').on('click', function (e) {
            var dataLayer = {
                event: {
                    eventInfo: {
                        eventType: 'sendAnEmail',
                        eventName: $(e.currentTarget).text()
                    }
                }
            };
            $(e.currentTarget).dtmTrack(dataLayer);
        });
    };
    ;
    Analytics.prototype.initTel = function () {
        $('a[href^="tel:"]:not([data-analytics])').on('click', function (e) {
            var dataLayer = {
                event: {
                    eventInfo: {
                        eventType: 'contactUs',
                        eventAction: 'call',
                        eventName: ('footer:' + $(e.currentTarget).attr('href').replace('tel:', ''))
                    }
                }
            };
            $(e.currentTarget).dtmTrack(dataLayer);
        });
    };
    ;
    Analytics.prototype.customTrack = function (dataLayer) {
        if (typeof dataLayer == 'string') {
            dataLayer = JSON.parse(dataLayer);
        }
        $(this).dtmTrack(dataLayer);
    };
    ;
    Analytics.prototype.buildAnalyticsWithLocalStorage = function (url, json) {
        if (!url)
            return void 0;
        if (json) {
            if (typeof json == 'string')
                json = JSON.parse(json);
            amplify.store(this.dataAnalyticsAttr, json);
        }
        location.href = url;
    };
    ;
    Analytics.prototype.trackOnceForAnalyticsHash = function () {
        var dataLayer = amplify.store(this.dataAnalyticsAttr);
        if (dataLayer) {
            if (typeof dataLayer == 'string') {
                dataLayer = JSON.parse(dataLayer);
            }
            $(window).dtmTrack(dataLayer);
            amplify.store(this.dataAnalyticsAttr, null);
        }
    };
    Analytics.prototype.trackLifestagesFilter = function (eventName) {
        var dataLayer = {
            "event": {
                "eventInfo": {
                    "eventType": "product_lifestagefilter",
                    "eventName": eventName
                }
            },
            "product": {
                "attributes": {
                    "stage": eventName
                }
            }
        };
        this.dtmTrack(dataLayer, false);
    };
    Analytics.prototype.trackVideoPlay = function (eventName) {
        var dataLayer = { "event": { "eventInfo": { "eventType": "video", "eventName": eventName, "eventAction": "play" } } };
        this.dtmTrack(dataLayer, false);
    };
    Analytics.prototype.trackSocialShare = function (socialMediaName, shareUrl) {
        var dataLayer = { "event": { "eventInfo": { "eventType": "social_share", "eventName": socialMediaName, "eventURL": shareUrl } } };
        this.dtmTrack(dataLayer, false);
    };
    Analytics.prototype.trackFAQCategory = function (categoryName, question) {
        if (question === void 0) { question = 'NIL'; }
        var dataLayer = { "event": { "eventInfo": { "eventType": "faq_click", "eventName": categoryName + '|' + question } } };
        this.dtmTrack(dataLayer, false);
    };
    Analytics.prototype.trackChatbotResult = function (searchTerm, totalResults, chatbotPhrases) {
        var dataLayer = {
            "event": {
                "eventInfo": {
                    "eventType": "chatbot_search"
                }
            },
            "search": {
                "searchInfo": {
                    "term": searchTerm,
                    "results": "" + totalResults + ""
                },
                "category": {
                    "primaryCategory": "Chat Bot",
                    "subCategory": (chatbotPhrases ? chatbotPhrases.join(',') : '')
                }
            }
        };
        this.dtmTrack(dataLayer, false);
    };
    Analytics.prototype.trackCarousel = function (swiper) {
        if (!swiper)
            return void 0;
        var carouselName = $(swiper.wrapper).attr('data-name');
        var slideTitle = $(swiper.slides[swiper.activeIndex]).attr('data-title');
        var slideNumber = swiper.activeIndex + 1;
        var direction = !swiper.isHorizontal() ? 'vertical slide' : 'horizontal slide';
        var dataLayer = {
            "event": {
                "eventInfo": {
                    "eventType": (!swiper.isHorizontal() ? 'carousel_vertical' : 'carousel_horizontal'),
                    "eventName": (carouselName + '|' + slideNumber + '|' + slideTitle),
                }
            }
        };
        this.dtmTrack(dataLayer, false);
    };
    return Analytics;
}());
// SystemJS.import('jquery').then(() => {
var analytics = new Analytics();
window['brands'].tracker = analytics;
// }); 
