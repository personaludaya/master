"use strict";
var $ = require('jquery');
require('typed.js');
require('api.ai');
var shared_1 = require('./shared');
var _ = require('underscore');
require('jquery.visible');
var chatbotTemplate = require('chatbot-product-info-partial');
//https://gist.github.com/artemgoncharuk/b31b6a656c954a2866e8
// const endpoint = "wss://api-ws.api.ai:4435/api/ws/query";
var SERVER_PROTO = 'wss', SERVER_DOMAIN = 'api-ws.api.ai', TTS_DOMAIN = 'api.api.ai', SERVER_PORT = '4435', ACCESS_TOKEN = '9df32f4839ff408089222f118d8f266b', SERVER_VERSION = '20150910';
var Chatbot = (function () {
    function Chatbot() {
        this.loader = new shared_1.Loader();
        this.sessionId = this.generateSession(32);
        // private endpoint: string = '/dummy-data/data.json';
        this.endpoint = '/services/chatbot/search.json';
        this.config = {
            server: SERVER_PROTO + '://' + SERVER_DOMAIN + ':' + SERVER_PORT + '/api/ws/query',
            // server: 'https://api.api.ai/v1/query',
            serverVersion: SERVER_VERSION,
            token: ACCESS_TOKEN,
            sessionId: this.sessionId
        };
        this.chatbotGlobal = '.chatbot-global';
        this.chatbotComponent = '.chatbot-component';
        this.chatbotWrapper = '.chatbot-wrapper';
        this.loaderWrapper = '.loader';
        this.chatbotmsgId = '#chatbotmsg';
        this.globalchatbotmsgId = '#globalchatbotmsg';
        this.chatbotsendId = '#btnsend';
        this.globalChatbotsendId = '#btnsendglobal';
        this.chatbotResults = '.results';
        this.chatbotWelcome = '.chatbot-welcome';
        this.chatbotHelp = '.chatbot-help';
        this.chatbotMessagebox = '.chatbot-messagebox';
        this.fromUserTemplate = _.template('<div class="from-user"><div class="message"><%- message %></div></div>');
        this.fromChatbotTemplate = _.template('<div class="from-chatbot"><div class="message <%= cssclass %>"><%= message %></div></div>');
        this.fromChatbotLoaderTemplate = _.template('<div class="from-chatbot"><%= message %></div>');
        // private chatbotNotMatch: any = _.template('Sorry! we could not match your request. Here are some popular contents <a href="<%= ourproductURL %>" target="_self">Our products</a>, <a href="<%= bemagazineURL %>" target="_self">BE Magazine</a>, <a href="<%= faqURL %>" target="_self">FAQ</a> and <a href="<%= customerserviceURL %>" target="_self">Customer Service</a>');
        // Oops! We can’t find what you’re looking for. Would you like to know about Our Products, Lifestyle Articles or our products FAQ?
        this.chatbotNotMatch = _.template('Oops! We can’t find what you’re looking for. Would you like to know about <a href="<%= ourproductURL %>" target="_self">Our Products</a>, <a href="<%= bemagazineURL %>" target="_self">Lifestyle Articles</a>, <a href="<%= faqURL %>" target="_self">our products FAQ</a>?');
        this.chatbotHelloTemplate = _.template('Hello to you again! Would you like to know more about <a href="<%= ourproductURL %>" target="_self">Our Products</a>, <a href="<%= bemagazineURL %>" target="_self">Lifestyle Articles</a>, <a href="<%= faqURL %>" target="_self">our products FAQ</a>?');
        this.chatbotNoInteractionTemplate = _.template('If that’s not what you’re looking for, would you like to know more about <a href="<%= ourproductURL %>" target="_self">Our Products</a>, <a href="<%= bemagazineURL %>" target="_self">Lifestyle Articles</a>, <a href="<%= faqURL %>" target="_self">our products FAQ</a>?');
        this.chatbotNoInteractionHelloTemplate = _.template('Oops! Looks like you need some help. Would you like to get in touch with our customer service?');
        this.chatbotNoInteractionHelloYesTemplate = _.template('Here’s how you can get in touch with us! <a href="<%= customerserviceURL %>" target="_self">Customer Service</a>');
        this.chatbotRedirectTemplate = _.template('Redirecting to <%= url%>');
        this.chatbotOpenTabTemplate = _.template('Opening <%= url%>');
        this.chatbotLoaderTemplate = _.template('<h4 class="message conversation-loader">.<span>..</span></h4>');
        // private chatbotFAQTemplate: any = _.template('<div class="from-chatbot"><div class="message"><%= message %><ul><li></li></ul></div></div>');
        this.countryCode = 'sg'; //default
        this.localeCode = 'en'; //default
        this.customerSvcPath = '';
        this.storeLocationPath = '';
        this.ourProductsPath = '';
        this.faqPath = '';
        this.beMagPath = '';
        this.ecstorePromotionsPath = '';
        this.redirectTimeout = 750;
        this.isInlineResult = false;
        this.lastQueryScrollTop = 0;
        this.chatbotTextList = [
            "..",
        ];
        this.chatbotTransitionDuration = 1000;
        this.utils = new shared_1.Utils();
        // private shareBtnSelector: string = '.at-share-dock';
        this.maxInlineResultToDisplay = 3;
        this.chatbotNoInteractionTimeout = 5000;
        this.chatbotNoInteractionTimer = false;
        this.recentUserQuery = false;
        this.init();
    }
    Chatbot.prototype.generateSession = function (length) {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        for (var i = 0; i < length; i++) {
            text += possible.charAt(Math.floor(Math.random() * possible.length));
        }
        return text;
    };
    Chatbot.prototype.typedAnimate = function () {
        $(this.chatbotWrapper + ':visible').find('h4.message.conversation-loader span').typed({
            strings: this.chatbotTextList,
            loop: true,
            typeSpeed: 500,
            showCursor: false
        });
    };
    Chatbot.prototype.initChatbotNoInteractionTimer = function (type) {
        var _this = this;
        if (type === void 0) { type = false; }
        if (this.chatbotNoInteractionTimer)
            clearTimeout(this.chatbotNoInteractionTimer);
        this.chatbotNoInteractionTimer = setTimeout(function () {
            var message = '';
            if (type == 'hello') {
                message = _this.chatbotNoInteractionHelloTemplate({
                    ourproductURL: (_this.ourProductsPath),
                    bemagazineURL: (_this.beMagPath),
                    faqURL: (_this.faqPath),
                    customerserviceURL: (_this.customerSvcPath)
                });
            }
            else {
                message = _this.chatbotNoInteractionTemplate({
                    ourproductURL: (_this.ourProductsPath),
                    bemagazineURL: (_this.beMagPath),
                    faqURL: (_this.faqPath),
                    customerserviceURL: (_this.customerSvcPath)
                });
            }
            var appendedHTML = $(_this.chatbotResults + ':visible').append(_this.fromChatbotTemplate({ message: message, cssclass: 'no-bg' }));
        }, this.chatbotNoInteractionTimeout);
        window['brands'].chatbot.chatbotNoInteractionTimer = this.chatbotNoInteractionTimer;
    };
    Chatbot.prototype.init = function () {
        var _this = this;
        this.apiAICustom = new shared_1.ApiAICustom();
        this.apiAICustom.onError = function (code, data) {
            _this.onError(code, data);
        };
        this.apiAICustom.onResults = function (data) {
            _this.onResults(data);
        };
        var chatbotUserInteraction = function () {
            $(_this.chatbotWrapper).show();
            // $(this.chatbotWrapper + ':visible').find('.from-chatbot .message').css({ opacity: 0 });
            if ($(window).width() <= window['brands'].mobile_screen) {
                if ($(_this.chatbotWrapper + ':visible').find('.from-user').length < 1) {
                    $(_this.chatbotWrapper + ':visible').find('h1.message').animate({ top: 0, opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                        // $(this.chatbotWrapper + ':visible').find('h1.message').animate({ top: -100, opacity: 0 }, this.chatbotTransitionDuration, 'swing', () => {
                        //   $(this.chatbotWrapper + ':visible').find('h1.message').hide();
                        $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').animate({ top: 120, opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                            $(_this.chatbotWrapper + ':visible').find('h4.message:eq(1)').animate({ top: 190, opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                                _this.typedAnimate();
                                $(_this.chatbotWrapper + ':visible').find('h4.message:eq(2)').animate({ opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                                });
                            });
                        });
                        // });
                    });
                }
            }
            else {
                $(_this.chatbotWrapper + ':visible').find('h1.message').animate({ top: 0, opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                    $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').animate({ top: 120, opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                        $(_this.chatbotWrapper + ':visible').find('h4.message:eq(1)').animate({ top: 190, opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                            _this.typedAnimate();
                            $(_this.chatbotWrapper + ':visible').find('h4.message:eq(2)').animate({ opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                            });
                        });
                    });
                });
            }
        };
        var btnChatbotTrigger = function () {
            var id = '.btnchatbot';
            if ($(window).width() <= window['brands'].mobile_screen) {
                $('.chatbot-component').hide();
            }
            if ($('#chatbot-global').css('display') == 'none') {
                $(id).addClass('active');
                $('#chatbot-global').removeClass('hide').addClass('show');
                $('.navbar-collapse').removeClass('in');
                _this.utils.chatbotUserInteraction();
                // $('#chatbot-global').focus();
                if ($(window).width() <= window['brands'].mobile_screen) {
                    $('#header').height($(window).height());
                }
                $('#chatbot-global').animate({ scrollTop: $('#chatbot-global').prop('scrollHeight') }, 500);
                // $('.chatbot-wrapper:visible').animate({ scrollTop: 0 }, 500);
                // track analytics
                var dataLayer = {
                    "event": {
                        "eventInfo": {
                            "eventType": "chatbot_initiate",
                            "eventName": "header|search"
                        }
                    },
                    "search": {
                        "category": {
                            "primaryCategory": "Chat Bot"
                        },
                        "attributes": {
                            "source": (location.href)
                        }
                    }
                };
                if (window['brands'].tracker) {
                    window['brands'].tracker.customTrack(dataLayer);
                }
            }
            else {
                // $('#chatbot-global').slideUp();
                $('#chatbot-global').removeClass('show').addClass('hide');
                $(id).removeClass('active');
            }
        };
        $(document).ready(function () {
            // chatbotUserInteraction();
            _this.utils.chatbotUserInteraction();
            if ($('#siteCountry').val()) {
                _this.countryCode = $('#siteCountry').val();
            }
            if ($('#siteLangCode').val()) {
                _this.localeCode = $('#siteLangCode').val();
            }
            // $(this.chatbotWelcome).find('h1').fadeTo(500, 1, () => {
            //   $(this.chatbotWelcome).find('h4').fadeTo(1000, 1);
            // });
            if ($('#customerSvcPath').val()) {
                _this.customerSvcPath = $('#customerSvcPath').val();
                +'#chatbot';
            }
            if ($('#storeLocationPath').val()) {
                _this.storeLocationPath = $('#storeLocationPath').val() + '#chatbot';
            }
            if ($('#ourProductsPath').val()) {
                _this.ourProductsPath = $('#ourProductsPath').val() + '#chatbot';
            }
            if ($('#faqPath').val()) {
                _this.faqPath = $('#faqPath').val() + '#chatbot';
            }
            if ($('#beMagPath').val()) {
                _this.beMagPath = $('#beMagPath').val() + '#chatbot';
            }
            if ($('#ecstorePromotionsPath').val()) {
                _this.ecstorePromotionsPath = $('#ecstorePromotionsPath').val() + '#chatbot';
            }
            $(_this.chatbotHelp + ',' + _this.chatbotMessagebox).fadeTo(500, 1);
            $(_this.globalchatbotmsgId).on('keypress', function (e) {
                if (e.which === 13) {
                    _this.onSendClicked(e, $(e.currentTarget).val());
                }
            });
            $(_this.chatbotmsgId).on('focus', function (e) {
                if ($(window).width() <= window['brands'].mobile_screen) {
                    // $('#btnchatbot').trigger('click');
                    btnChatbotTrigger();
                    if ($(_this.globalchatbotmsgId).length > 0) {
                        $(_this.globalchatbotmsgId).focus();
                    }
                }
            });
            $(_this.chatbotmsgId).on('keypress', function (e) {
                if (e.which === 13) {
                    if ($(window).width() <= window['brands'].mobile_screen) {
                        // $('#btnchatbot').trigger('click');
                        btnChatbotTrigger();
                        _this.onSendClicked(e, $('#chatbotmsg').val());
                    }
                    else {
                        _this.onSendClicked(e, $('#chatbotmsg').val());
                    }
                }
            });
            $(_this.globalChatbotsendId).on('click', function (e) {
                _this.onSendClicked(e, $(_this.globalchatbotmsgId).val());
            });
            // $(this.globalchatbotmsgId).parent().find('.brands-icon').on('click', (e: any) => {
            //   this.onSendClicked(e, $(this.globalchatbotmsgId).val());
            // });
            $(_this.chatbotsendId).on('click', function (e) {
                if ($(window).width() <= window['brands'].mobile_screen) {
                    // $('#btnchatbot').trigger('click');
                    btnChatbotTrigger();
                    _this.onSendClicked(e, $('#chatbotmsg').val());
                }
                else {
                    _this.onSendClicked(e, $('#chatbotmsg').val());
                }
            });
            // $(this.chatbotWrapper).scroll((e: any) => {
            // $(this.chatbotWrapper).find('.from-user, .from-chatbot').each((index: number, item: any) => {
            //   if(!$(item).visible()) {
            //     $(item).animate({ opacity: 0 }, 500);
            //   } else {
            //     $(item).animate({ opacity: 1 }, 500);
            //   }
            // });
            // });
        });
        // this.loader.show(this.loaderWrapper);
    };
    Chatbot.prototype.onSendClicked = function ($event, msg) {
        var _this = this;
        // console.log($event);
        if (!msg)
            return void 0;
        if (this.chatbotNoInteractionTimer)
            clearTimeout(this.chatbotNoInteractionTimer);
        var chatbotMain = this.chatbotComponent + ', ' + this.chatbotGlobal;
        if ($(window).width() <= window['brands'].mobile_screen) {
            chatbotMain = this.chatbotGlobal;
            $(this.chatbotComponent).find(this.chatbotWrapper).find('.results').html(this.fromChatbotLoaderTemplate({ message: '<h4 class="message no-bg still-looking">Still looking? Perhaps try another word</h4>' }));
        }
        if ($(chatbotMain).find(this.chatbotWrapper + ':visible').find('h1.message').length > 0) {
            // $(chatbotMain).find('h1, h4, h5').css({ position: 'relative' });
            $(chatbotMain).find(this.chatbotHelp + ':visible').remove();
            $(chatbotMain).find(this.chatbotWrapper + ':visible').find('.results').html('');
            $(chatbotMain).find(this.chatbotWrapper + ':visible').css({ 'overflow-y': 'auto' });
        }
        // $('.chatbot-component').css({ 'margin-top': 50 });
        // if($(chatbotMain).find(this.chatbotWelcome).is(':visible') && $(chatbotMain).find(this.chatbotHelp).is(':visible')) {
        //   $(chatbotMain).find(this.chatbotWelcome).slideUp('fast');
        //   $(chatbotMain).find(this.chatbotHelp).slideUp('fast');
        // }
        if (!$(chatbotMain).find(this.chatbotWrapper).is(':visible')) {
            $(chatbotMain).find(this.chatbotWrapper).show();
        }
        var appendQueryObj = $(chatbotMain).find(this.chatbotResults).append(this.fromUserTemplate({ message: msg }));
        $(chatbotMain).find(this.chatbotResults).append(this.fromChatbotLoaderTemplate({ message: (this.chatbotLoaderTemplate()) }));
        this.typedAnimate();
        // setTimeout(() => {
        $(this.chatbotWrapper + ':visible').animate({ scrollTop: ($(this.chatbotWrapper + ':visible').prop('scrollHeight')) }, 1, 'swing', function () {
            if ($(window).width() <= window['brands'].mobile_screen) {
                _this.lastQueryScrollTop = $('.from-user').last().prop('offsetTop') - 350;
            }
            else {
                _this.lastQueryScrollTop = $('.from-user').last().prop('offsetTop') + $('.from-user').last().height();
            }
            // alert('sending');
            if (msg.toLowerCase() == 'hello' || (_this.recentUserQuery && _this.recentUserQuery.toLowerCase() == 'hello' && msg.toLowerCase() == 'yes')) {
                // no need to send to chatbot, hard code
                var message = _this.chatbotHelloTemplate({
                    ourproductURL: (_this.ourProductsPath),
                    bemagazineURL: (_this.beMagPath),
                    faqURL: (_this.faqPath),
                    customerserviceURL: (_this.customerSvcPath)
                });
                if (msg.toLowerCase() == 'yes') {
                    message = _this.chatbotNoInteractionHelloYesTemplate({
                        ourproductURL: (_this.ourProductsPath),
                        bemagazineURL: (_this.beMagPath),
                        faqURL: (_this.faqPath),
                        customerserviceURL: (_this.customerSvcPath)
                    });
                }
                $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                var appendedHTML = $(_this.chatbotResults + ':visible').append(_this.fromChatbotTemplate({ message: message, cssclass: 'no-bg' }));
                $(_this.chatbotmsgId).val('');
                $(_this.globalchatbotmsgId).val('');
                // setTimeout(() => {
                $(_this.chatbotWrapper + ':visible').animate({ scrollTop: _this.lastQueryScrollTop }, 500);
                // }, 500);
                if (appendedHTML && window['brands'].tracker) {
                    window['brands'].tracker.initDataAnalytics(appendedHTML);
                }
                if (msg.toLowerCase() == 'hello') {
                    _this.initChatbotNoInteractionTimer('hello');
                }
                _this.recentUserQuery = msg;
                return void 0;
            }
            _this.apiAICustom.sendQuery(msg);
            _this.recentUserQuery = msg;
        });
        // }, 500);
    };
    Chatbot.prototype.sendQuery = function (msg) {
        this.apiAI.sendJson({
            "v": "20150512",
            "query": msg,
            "timezone": "GMT+8",
            "lang": "en",
            "sessionId": this.sessionId
        });
    };
    Chatbot.prototype.onInit = function () {
        this.apiAI.open();
    };
    Chatbot.prototype.onStart = function () {
    };
    Chatbot.prototype.onStop = function () {
    };
    Chatbot.prototype.onOpen = function () {
        // this.sendQuery("hello");
    };
    Chatbot.prototype.onClose = function () {
        this.apiAI.close();
    };
    Chatbot.prototype.onError = function (code, data) {
        // no need audio
        // if(code === 5) {
        //   // this.apiAI.open();
        // } else {
        //   this.apiAI.close();
        // }
    };
    Chatbot.prototype.onEvent = function (code, data) {
    };
    Chatbot.prototype.onResults = function (data) {
        var _this = this;
        this.isInlineResult = false;
        /*
        action - keywords
        params.category/product/faq - keywords
        speech-response - message (optional)
        params.type    - case type (category, product, faq)
        */
        var message = this.chatbotNotMatch({
            ourproductURL: (this.ourProductsPath),
            bemagazineURL: (this.beMagPath),
            faqURL: (this.faqPath),
            customerserviceURL: (this.customerSvcPath)
        });
        var done = function (html, keeploader) {
            var appendedHTML = false;
            if (html) {
                appendedHTML = $(_this.chatbotResults + ':visible').append(html);
            }
            else {
                appendedHTML = $(_this.chatbotResults + ':visible').append(_this.fromChatbotTemplate({ message: message, cssclass: 'no-bg' }));
            }
            $(_this.chatbotmsgId).val('');
            $(_this.globalchatbotmsgId).val('');
            if (!keeploader) {
                // this.loader.hide(this.loaderWrapper);
                $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
            }
            // setTimeout(() => {
            $(_this.chatbotWrapper + ':visible').animate({ scrollTop: _this.lastQueryScrollTop }, 500);
            // }, 500);
            if (appendedHTML && window['brands'].tracker) {
                window['brands'].tracker.initDataAnalytics(appendedHTML);
            }
            _this.initChatbotNoInteractionTimer();
        };
        var msg = data.result.resolvedQuery;
        if (!data.result.parameters) {
            if (window['brands'].tracker) {
                window['brands'].tracker.trackChatbotResult(msg, 0, false);
            }
            done();
            return void 0;
        }
        var chatbotphrase = [];
        if (data.result.parameters.chatbotphrase) {
            chatbotphrase.push(encodeURIComponent(data.result.parameters.chatbotphrase));
        }
        if (data.result.parameters.chatbotphrase1) {
            chatbotphrase.push(encodeURIComponent(data.result.parameters.chatbotphrase1));
        }
        if (data.result.parameters.chatbotphrase2) {
            chatbotphrase.push(encodeURIComponent(data.result.parameters.chatbotphrase2));
        }
        if (data.result.parameters.chatbotphrase3) {
            chatbotphrase.push(encodeURIComponent(data.result.parameters.chatbotphrase3));
        }
        var chatbotType = data.result.parameters.type;
        // pass chatbotphrase and get response from AEM
        if (chatbotphrase.length > 1) {
            // only compare has more than one 
            chatbotphrase.push('compare');
        }
        else if (chatbotType == 'faq') {
            chatbotphrase.push('faq');
        }
        else if (chatbotType == 'product-price') {
            chatbotphrase.push('price');
        }
        // let colClasses:string = 'col-lg-3 col-md-3 col-sm-4 col-xs-12';
        var colClasses = 'col-lg-3 col-md-4 col-sm-4 col-xs-6';
        if ($('#chatbot-global').css('display') != 'none') {
            // this is global chatbot and use for both desktop and mobile
            // colClasses = 'col-lg-12 col-md-12 col-sm-12 col-xs-12';
            colClasses = 'col-lg-6 col-md-6 col-sm-6 col-xs-6';
        }
        if (chatbotType == 'promotions') {
            // this.ecstorePromotionsPath = 'http://www.google.com';
            if (this.ecstorePromotionsPath != '') {
                message = this.chatbotOpenTabTemplate({ url: this.ecstorePromotionsPath });
                // this.loader.hide(this.loaderWrapper);
                $(this.chatbotWrapper + ':visible').find(this.chatbotResults).find('.conversation-loader').parent().remove();
                window.open(this.ecstorePromotionsPath);
                if (window['brands'].tracker) {
                    window['brands'].tracker.trackChatbotResult(msg, 1, chatbotphrase);
                }
                return done();
            }
        }
        else if (chatbotType == 'store-locations') {
            // this.storeLocationPath = 'http://www.google.com';
            if (this.storeLocationPath != '') {
                message = this.chatbotRedirectTemplate({ url: this.storeLocationPath });
                if (window['brands'].tracker) {
                    window['brands'].tracker.trackChatbotResult(msg, 1, chatbotphrase);
                }
                done();
                _.delay(function () {
                    if (window['brands'].tracker) {
                        var dataLayer = {
                            "event": {
                                "eventInfo": {
                                    "eventType": "chatbot_click",
                                    "eventName": "auto|store-locations"
                                }
                            },
                            "search": {
                                "searchInfo": {
                                    "term": msg
                                },
                                "category": {
                                    "primaryCategory": "Chat Bot",
                                    "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                                }
                            }
                        };
                        // this.loader.hide(this.loaderWrapper);
                        $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                        window['brands'].tracker.buildAnalyticsWithLocalStorage(_this.storeLocationPath, dataLayer);
                    }
                }, this.redirectTimeout);
            }
            else {
                // this.loader.hide(this.loaderWrapper);
                $(this.chatbotWrapper + ':visible').find(this.chatbotResults).find('.conversation-loader').parent().remove();
            }
            return void 0;
        }
        else if (chatbotType == 'supports') {
            // this.ecstorePromotionsPath = 'http://www.google.com';
            if (this.customerSvcPath != '') {
                message = this.chatbotRedirectTemplate({ url: this.customerSvcPath });
                if (window['brands'].tracker) {
                    window['brands'].tracker.trackChatbotResult(msg, 1, chatbotphrase);
                }
                done();
                _.delay(function () {
                    if (window['brands'].tracker) {
                        var dataLayer = {
                            "event": {
                                "eventInfo": {
                                    "eventType": "chatbot_click",
                                    "eventName": "auto|supports"
                                }
                            },
                            "search": {
                                "searchInfo": {
                                    "term": msg
                                },
                                "category": {
                                    "primaryCategory": "Chat Bot",
                                    "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                                }
                            }
                        };
                        // this.loader.hide(this.loaderWrapper);
                        $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                        window['brands'].tracker.buildAnalyticsWithLocalStorage(_this.customerSvcPath, dataLayer);
                    }
                }, this.redirectTimeout);
            }
            else {
                // this.loader.hide(this.loaderWrapper);
                $(this.chatbotWrapper + ':visible').find(this.chatbotResults).find('.conversation-loader').parent().remove();
            }
            return void 0;
        }
        else if (chatbotType == 'our-products') {
            // this.ecstorePromotionsPath = 'http://www.google.com';
            if (this.ourProductsPath != '') {
                message = this.chatbotRedirectTemplate({ url: this.ourProductsPath });
                if (window['brands'].tracker) {
                    window['brands'].tracker.trackChatbotResult(msg, 1, chatbotphrase);
                }
                done();
                _.delay(function () {
                    if (window['brands'].tracker) {
                        var dataLayer = {
                            "event": {
                                "eventInfo": {
                                    "eventType": "chatbot_click",
                                    "eventName": "auto|our-products"
                                }
                            },
                            "search": {
                                "searchInfo": {
                                    "term": msg
                                },
                                "category": {
                                    "primaryCategory": "Chat Bot",
                                    "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                                }
                            }
                        };
                        // this.loader.hide(this.loaderWrapper);
                        $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                        window['brands'].tracker.buildAnalyticsWithLocalStorage(_this.ourProductsPath, dataLayer);
                    }
                }, this.redirectTimeout);
            }
            else {
                // this.loader.hide(this.loaderWrapper);
                $(this.chatbotWrapper + ':visible').find(this.chatbotResults).find('.conversation-loader').parent().remove();
            }
            return void 0;
        }
        this.fetchData(chatbotphrase)
            .then(function (data) {
            var response = data;
            // for testing
            // response = {totalResult:4,results:[{type:"product",typeLabel:"Product",pagetitle:"Essence of Chicken with Cordyceps",pagedescr:"Brand’s Chicken Essence with Cordyceps is made up of Essence of Chicken, high quality Cordyceps & herbs such as Rehmannia, Milkvetch, and Solomon’s Seal.",pageimg:"https://cerebos-prod.adobemsbasic.com/content/dam/brands/sg/product-details/essence-of-chicken/eoc-cordyceps/brands-eoc-cc-starter-product-img.png",pageurl:"/content/brands/sg/en/products/essence-of-chicken-with-cordyceps.html#chatbot",keywords:["essence-of-chicken"]},{type:"product",pagetitle:"Essence of Chicken with Tangkwei",pagedescr:"Brand’s Chicken Essence with Tangkwei is formulated with the excellent “blood herb”, and is ideal for women who experience menstrual discomforts & irregularities.",pageimg:"https://cerebos-prod.adobemsbasic.com/content/dam/brands/sg/product-details/essence-of-chicken/eoc-tangkwei/brands-eoc-tangkwei-starter-product-img.png",pageurl:"/content/brands/sg/en/products/essence-of-chicken-with-tangkwei.html#chatbot",keywords:["essence-of-chicken"]},{type:"product",pagetitle:"Essence of Chicken with American Ginseng",pagedescr:"Brand’s Essence of Chicken with American Ginseng, which is an extract of fine quality chicken, also includes liquorice to neutralize the effect of American Ginseng.",pageimg:"https://cerebos-prod.adobemsbasic.com/content/dam/brands/sg/product-details/essence-of-chicken/eoc-american-ginseng/brands-eoc-ag-starter-product-img.png",pageurl:"/content/brands/sg/en/products/essence-of-chicken-with-american-ginseng.html#chatbot",keywords:["essence-of-chicken"]},{productid:"1",type:"product",pagetitle:"Essence of Chicken ",pagedescr:"Brand’s Original Essence of Chicken, which is made of an all-natural extract of fine quality chicken, is fat & cholesterol-free with no artificial chemicals.",pageimg:"https://cerebos-prod.adobemsbasic.com/content/dam/brands/sg/product-details/essence-of-chicken/eoc-original/brands-eoc-starter-product-img.png",pageurl:"/content/brands/sg/en/products/essence-of-chicken-original.html#chatbot",keywords:["essence-of-chicken"]}],viewMoreUrl:"/content/brands/sg/en/chatbot-search-results.html?q%5B%5D=essence-of-chicken"};
            if (chatbotType == 'compare') {
                // because it is a redirect
                response.totalResult = 1;
            }
            if (window['brands'].tracker) {
                window['brands'].tracker.trackChatbotResult(msg, response.totalResult, chatbotphrase);
            }
            if (response && response.totalResult > 0 && response.results.length > 0) {
                _this.isInlineResult = true;
                var html = _this.fromChatbotTemplate({ message: 'Here\'s what I found', cssclass: 'no-bg' }) + '<div class="row inline-chatbot-result">';
                var results_1 = _.chain(response.results).groupBy('type')
                    .map()
                    .first(_this.maxInlineResultToDisplay)
                    .value();
                results_1 = _.chain(results_1)
                    .map(function (m, index) {
                    return _.first(m, (_this.maxInlineResultToDisplay - results_1.length) + 1);
                })
                    .flatten()
                    .value();
                var _loop_1 = function(i) {
                    var result = response.results[i];
                    var dataLayer_1 = {
                        "event": {
                            "eventInfo": {
                                "eventType": "chatbot_click"
                            }
                        },
                        "search": {
                            "searchInfo": {
                                "term": msg
                            },
                            "category": {
                                "primaryCategory": "Chat Bot",
                                "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                            }
                        }
                    };
                    switch (result.type) {
                        case "product":
                            dataLayer_1.event.eventInfo.eventName = "link|product";
                            result.dataAnalytics = JSON.stringify(dataLayer_1);
                            if (response.totalResult == 1) {
                                if (chatbotType == 'product-price') {
                                    message = _this.chatbotOpenTabTemplate({ url: result.pageurl });
                                    dataLayer_1.event.eventInfo.eventName = "auto|product-price";
                                    _.delay(function () {
                                        if (window['brands'].tracker) {
                                            window['brands'].tracker.customTrack(dataLayer_1);
                                        }
                                        // this.loader.hide(this.loaderWrapper);
                                        $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                                        window.open(result.pageurl);
                                    }, _this.redirectTimeout);
                                }
                                else {
                                    message = _this.chatbotRedirectTemplate({ url: result.pageurl });
                                    _.delay(function () {
                                        if (window['brands'].tracker) {
                                            window['brands'].tracker.customTrack(dataLayer_1);
                                        }
                                        // this.loader.hide(this.loaderWrapper);
                                        $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                                        // location.href = result.pageurl;
                                        if (window['brands'].tracker) {
                                            var dataLayer_2 = {
                                                "event": {
                                                    "eventInfo": {
                                                        "eventType": "chatbot_click",
                                                        "eventName": "auto|product"
                                                    }
                                                },
                                                "search": {
                                                    "searchInfo": {
                                                        "term": msg
                                                    },
                                                    "category": {
                                                        "primaryCategory": "Chat Bot",
                                                        "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                                                    }
                                                }
                                            };
                                            window['brands'].tracker.buildAnalyticsWithLocalStorage(result.pageurl, dataLayer_2);
                                        }
                                    }, _this.redirectTimeout);
                                }
                                return { value: done() };
                            }
                            else {
                                // render inline
                                // html += this.fromChatbotTemplate({ message: 'Here is the best match to your query', cssclass: 'no-bg' });
                                html += '<div class="' + colClasses + '">';
                                html += chatbotTemplate.template({
                                    product: result
                                });
                                html += '</div>';
                            }
                            break;
                        case "faq":
                            dataLayer_1.event.eventInfo.eventName = "link|faq";
                            // html += faqTempalate.template({
                            //   header: result.content,
                            //   faqList: (result.bulletList || [])
                            // });
                            // faqList: (result.bulletList || [])
                            if (result.bulletList && result.bulletList.length > 0) {
                                result.content += '<ul>';
                                for (var i_1 = 0; i_1 < result.bulletList.length; i_1++) {
                                    result.content += '<li>' + result.bulletList[i_1] + '</li>';
                                }
                                result.content += '</ul>';
                            }
                            message = result.content;
                            return { value: done() };
                        case "promotions":
                            dataLayer_1.event.eventInfo.eventName = "link|promotions";
                            _.delay(function () {
                                // this.loader.hide(this.loaderWrapper);
                                $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                                location.href = _this.ecstorePromotionsPath;
                            }, _this.redirectTimeout);
                            return { value: done() };
                        // break;
                        case "compare":
                            dataLayer_1.event.eventInfo.eventName = "link|compare";
                            message = _this.chatbotRedirectTemplate({ url: response.viewMoreUrl });
                            _.delay(function () {
                                // this.loader.hide(this.loaderWrapper);
                                $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                                // location.href = response.viewMoreUrl;
                                if (window['brands'].tracker) {
                                    var dataLayer_3 = {
                                        "event": {
                                            "eventInfo": {
                                                "eventType": "chatbot_click",
                                                "eventName": "auto|compare"
                                            }
                                        },
                                        "search": {
                                            "searchInfo": {
                                                "term": msg
                                            },
                                            "category": {
                                                "primaryCategory": "Chat Bot",
                                                "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                                            }
                                        }
                                    };
                                    window['brands'].tracker.buildAnalyticsWithLocalStorage(response.viewMoreUrl, dataLayer_3);
                                }
                            }, _this.redirectTimeout);
                            return { value: done() };
                        // break;
                        default:
                            dataLayer_1.event.eventInfo.eventName = "link|" + result.type;
                            result.dataAnalytics = JSON.stringify(dataLayer_1);
                            if (response.totalResult == 1) {
                                message = _this.chatbotRedirectTemplate({ url: response.viewMoreUrl });
                                _.delay(function () {
                                    if (window['brands'].tracker) {
                                        window['brands'].tracker.customTrack(dataLayer_1);
                                    }
                                    // this.loader.hide(this.loaderWrapper);
                                    $(_this.chatbotWrapper + ':visible').find(_this.chatbotResults).find('.conversation-loader').parent().remove();
                                    // location.href = result.pageurl;
                                    if (window['brands'].tracker) {
                                        var dataLayer_4 = {
                                            "event": {
                                                "eventInfo": {
                                                    "eventType": "chatbot_click",
                                                    "eventName": "auto|" + result.type
                                                }
                                            },
                                            "search": {
                                                "searchInfo": {
                                                    "term": msg
                                                },
                                                "category": {
                                                    "primaryCategory": "Chat Bot",
                                                    "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                                                }
                                            }
                                        };
                                        window['brands'].tracker.buildAnalyticsWithLocalStorage(result.pageurl, dataLayer_4);
                                    }
                                }, _this.redirectTimeout);
                                return { value: done() };
                            }
                            else {
                                // render inline
                                html += '<div class="' + colClasses + '">';
                                html += chatbotTemplate.template({
                                    product: result
                                });
                                html += '</div>';
                            }
                            break;
                    }
                };
                for (var i = 0; i < results_1.length; i++) {
                    var state_1 = _loop_1(i);
                    if (typeof state_1 === "object") return state_1.value;
                }
                html += '</div>';
                var dataLayer = {
                    "event": {
                        "eventInfo": {
                            "eventType": "chatbot_click",
                            "eventName": "link|view-more"
                        }
                    },
                    "search": {
                        "searchInfo": {
                            "term": msg
                        },
                        "category": {
                            "primaryCategory": "Chat Bot",
                            "subCategory": (chatbotphrase ? chatbotphrase.join(',') : '')
                        }
                    }
                };
                html += _this.fromChatbotTemplate({ message: "<a href='" + response.viewMoreUrl + "' data-analytics='" + JSON.stringify(dataLayer) + "'>See what else I found</a>", cssclass: '' });
                done(html);
            }
            else {
                done();
            }
        });
        // switch(data.result.parameters.category) {
        //   case "category": 
        //     message = data.result.fulfillment.speech? (data.result.fulfillment.speech + ' ' + data.result.resolvedQuery) : '';
        //     let colClasses:string = 'col-lg-4 col-md-4 col-sm-4 col-xs-12';
        //     if($('#chatbot-global').css('display') != 'none') {
        //       // this is global chatbot and use for both desktop and mobile
        //       colClasses = 'col-lg-12 col-md-12 col-sm-12 col-xs-12';
        //     }
        //     // show products
        //     this.fetchData()
        //       .then((data: any) => {
        //         let response: any = data['chatbot-aem'];
        //         if(response){
        //           let html: string = '<div class="row">';
        //           for(let product of dummyData.chatbot[data.result.parameters.category]) {
        //             html += '<div class="'+ colClasses +'">';
        //             html += chatbotTemplate.template({
        //               product: product
        //             });
        //             html += '</div>';
        //           }
        //           html += '</div>';
        //           html += this.fromChatbotTemplate({ message: "View <a href='/search-result.html'>all products</a>" });
        //           done(html);
        //         } else {
        //           done();
        //         }
        //       });
        //     break;
        //   case "product":
        //     message = data.result.fulfillment.speech? (data.result.fulfillment.speech + ' ' + data.result.resolvedQuery) : '';
        //     this.fetchData()
        //       .then((data: any) => {
        //         let response: any = data['chatbot-aem'].case1;
        //         // let countDown = 3;
        //         // message += ' in <span id="cb_countdown">' + countDown + '</span>';
        //         if(response) {
        //           // delay here for simulation
        //           // let countDownInterval = setInterval(() => {
        //           //   countDown--;
        //           //   $('#cb_countdown').text(countDown);
        //           //   if(countDown <= 0) {
        //           //     clearInterval(countDownInterval)
        //           //     window.location.href = dummyData.chatbot[data.result.parameters.product].url;  
        //           //   }
        //           // }, 1000);
        //           if(response.totalResult == 1) {
        //             _.delay(() => {
        //               this.loader.hide(this.loaderWrapper);
        //               window.location.href = response.results[0].pageurl;
        //             }, 3000);  
        //           }
        //         }
        //       });
        //     break;
        //   case "faq":
        //     message = data.result.parameters['faq-demo'];
        //   default:
        //     done();
        //     break;
        // }
    };
    Chatbot.prototype.fetchData = function (chatbotphrases) {
        var defer = $.Deferred();
        $.ajax({
            url: (this.endpoint + '?ctry=' + this.countryCode + '&loc=' + this.localeCode + '&q[]=' + chatbotphrases.join('&q[]=')),
            contentType: 'application/json; charset=utf-8;',
            dataType: 'text',
            success: function (data) {
                if (typeof data == 'string')
                    data = JSON.parse(data);
                defer.resolve(data);
            },
            error: function (error) {
                defer.reject(error);
            }
        });
        return defer.promise();
    };
    return Chatbot;
}());
new Chatbot();
