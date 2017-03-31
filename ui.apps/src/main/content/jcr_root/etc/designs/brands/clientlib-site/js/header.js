"use strict";
var $ = require('jquery');
require('bootstrap');
require('chatbot-container.js');
var shared_1 = require('./shared');
var Header = (function () {
    function Header() {
        this.dataMenuId = "menu-id";
        this.lastScrollPosition = 0;
        this.homeScreen = '.home-screen';
        this.cookiePolicy = '.cookie-policy';
        this.header = '.header';
        this.loader = new shared_1.Loader();
        this.loaderWrapper = '.loader';
        this.utils = new shared_1.Utils();
        this.init();
    }
    Header.prototype.init = function () {
        var _this = this;
        $(document).ready(function () {
            if (!$.cookie('cookiepolicy')) {
                $(_this.cookiePolicy).show();
            }
            if ($('.btnsearch:visible').data("disabled") == 1) {
                _this.loader.show(_this.loaderWrapper);
                $('.btnsearch:visible').addClass('selected-search-icon');
                $('#btnsubmenu').addClass('low-index');
                $('.btnsubmenu').show();
                $('#search-box').show();
                $('#search-box').focus();
            }
            // $('#home').on('click', ($event: any) => {
            //   //alert('test home');
            //   $('.navbar-collapse').removeClass('in');
            // });
            $('.btnchatbot:visible').on('click', function ($event) {
                if ($(window).width() <= window['brands'].mobile_screen) {
                    $('.chatbot-component').hide();
                }
                if ($('#chatbot-global').css('display') == 'none') {
                    $($event.currentTarget).addClass('active');
                    // $('#chatbot-global').slideDown();
                    $('#chatbot-global').removeClass('hide').addClass('show');
                    _this.utils.chatbotUserInteraction();
                    $('.navbar-collapse').removeClass('in');
                    $(document.body).removeClass('no-scroll');
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
                    $($event.currentTarget).removeClass('active');
                }
            });
            $('#closeglobalchatbot').on('click', function ($event) {
                // $('#chatbot-global').slideUp();
                if (window['brands'].chatbot.chatbotNoInteractionTimer) {
                    clearTimeout(window['brands'].chatbot.chatbotNoInteractionTimer);
                }
                if ($(window).width() <= window['brands'].mobile_screen) {
                    $('.chatbot-component').show();
                    $('#header').height('auto');
                }
                $('#chatbot-global').removeClass('show').addClass('hide');
                $('.btnchatbot:visible').removeClass('active');
            });
            $('#closemenu').on('click', function ($event) {
                $('.navbar-collapse').removeClass('in');
                $(document.body).removeClass('no-scroll');
            });
            $('.btn-toggle-menu').on('click', function ($event) {
                if ($('.btnsearch:visible').data("disabled") != 1) {
                    $('#search-box').hide();
                    $('.btnsubmenu').hide();
                }
            });
            $('.btnsearch:visible').on('click', function ($event) {
                if ($('.btnsearch:visible').data("disabled") == 1) {
                }
                else {
                    // hide menu links hover
                    $('.submenu').hide();
                    $('.nav-brands li').removeClass('active');
                    $('.submenu').find("[data-" + _this.dataMenuId + "=\"" + _this.prevSelectedMenu + "\"]").addClass('hide');
                    _this.prevSelectedMenu = "";
                    // end hide menu links hover
                    if ($('#btnsubmenu').css('display') == 'none') {
                        $('.navbar-collapse').removeClass('in');
                        $(document.body).removeClass('no-scroll');
                        $('.btnsubmenu').show();
                        $('#search-box').show();
                        //$('#search-box').focus();
                        $('.form-control.search-box-control').focus();
                        // track analytics
                        var dataLayer = {
                            "event": {
                                "eventInfo": {
                                    "eventType": "internalsearch_initiate",
                                    "eventName": "header|search"
                                }
                            },
                            "search": {
                                "category": {
                                    "primaryCategory": "Internal Search"
                                },
                                "attributes": {
                                    "source": (location.href)
                                }
                            }
                        };
                        if (window['brands'].tracker) {
                            window['brands'].tracker.customTrack(dataLayer);
                        }
                        if ($(window).width() <= window['brands'].mobile_screen) {
                            $(document.body).off().on('click, touchstart', function (e) {
                                if ($(e.target).hasClass('search-box-control'))
                                    return void 0;
                                if ($('#search-box').css('display') != 'none') {
                                    $('#search-box').hide();
                                    $(document.body).unbind('click, touchstart');
                                    if (document.activeElement)
                                        $(document.activeElement).blur();
                                    var inputs = document.querySelectorAll('input');
                                    for (var i = 0; i < inputs.length; i++) {
                                        inputs[i].blur();
                                    }
                                }
                            });
                        }
                    }
                    else {
                        $('#search-box').hide();
                        $('.btnsubmenu').hide();
                    }
                }
            });
            if ($('.search-result-container').length > 0) {
                $('#search-box').slideDown();
            }
            $('.nav-brands a').hover(function ($event) {
                var selectedMenu = $($event.target).data(_this.dataMenuId);
                if ($('.btnsearch:visible').data("disabled") != 1) {
                    $('#search-box').hide();
                    $('.btnsubmenu').hide();
                }
                if (_this.prevSelectedMenu != selectedMenu) {
                    if (_this.prevSelectedMenu && $('.submenu').find("[data-" + _this.dataMenuId + "=\"" + _this.prevSelectedMenu + "\"]").length > 0) {
                        $('.submenu').hide();
                        $('.submenu').find("[data-" + _this.dataMenuId + "=\"" + _this.prevSelectedMenu + "\"]").addClass('hide');
                        $('.nav-brands li').find("[data-" + _this.dataMenuId + "=\"" + _this.prevSelectedMenu + "\"]").parent().removeClass('active');
                        _this.prevSelectedMenu = "";
                    }
                    if ($('.submenu').find("[data-" + _this.dataMenuId + "=\"" + selectedMenu + "\"]").length > 0) {
                        $($event.target).parent().addClass('active');
                        $('.submenu').find("[data-" + _this.dataMenuId + "=\"" + selectedMenu + "\"]").removeClass('hide');
                        //$('.submenu').slideDown('slow');
                        $('.submenu').show();
                        _this.prevSelectedMenu = selectedMenu;
                    }
                }
            });
            $('.submenu').mouseleave(function ($event) {
                $('.submenu').hide();
                $('.nav-brands li').removeClass('active');
                $('.submenu').find("[data-" + _this.dataMenuId + "=\"" + _this.prevSelectedMenu + "\"]").addClass('hide');
                _this.prevSelectedMenu = "";
            });
            $('.btn-toggle-menu').on('click', function ($event) {
                $('#header').removeClass('fixed');
                $(document.body).addClass('no-scroll');
            });
            $('#closecookiepolicy').on('click', function ($event) {
                $(_this.cookiePolicy).remove();
                $(_this.header).removeClass('with-cookiepolicy');
                $(_this.cookiePolicy).removeClass('fixed');
                $(_this.homeScreen).removeClass('with-cookiepolicy');
                $.cookie('cookiepolicy', 1);
            });
            $(window).scroll(function ($event) {
                var scrollTop = $(window).scrollTop();
                if (scrollTop <= _this.lastScrollPosition) {
                    // scroll up
                    if (!$('#header').visible() && !$('#chatbot-global').find('.message-group').visible() && !$('.navbar-collapse').hasClass('in')) {
                        $('#header').addClass('fixed');
                    }
                }
                if (scrollTop <= 80) {
                    $('#header').removeClass('fixed');
                }
                // chatbot global
                if (!$('#chatbot-global').find('.message-group').visible()) {
                    // $('#chatbot-global').slideUp();
                    if ($(window).width() > window['brands'].mobile_screen) {
                        $('#chatbot-global').removeClass('show').addClass('hide');
                        $('.btnchatbot:visible').removeClass('active');
                    }
                }
                // if(!$('#header').visible()) {
                //   if(scrollTop > 80) {
                //     $('#header').addClass('fixed');
                //   }
                // } else {
                //   if(scrollTop <= 80) {
                //     $('#header').removeClass('fixed');
                //   }
                // }
                _this.lastScrollPosition = scrollTop;
            });
        });
    };
    return Header;
}());
new Header();
