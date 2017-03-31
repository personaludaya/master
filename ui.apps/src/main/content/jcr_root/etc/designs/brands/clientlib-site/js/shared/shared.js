"use strict";
var $ = require('jquery');
var _ = require('underscore');
var comparisonTempalate = require('product-comparison-item-partial');
var amplify = require('amplify');
var Utils = (function () {
    function Utils() {
        this.productOverviewClassName = '.product-info-overview';
        this.articleClassName = '.article';
        this.compareProductClassName = '.compare-products-slide';
        this.maxAllowedComparison = 4;
        this.productInfoOverviewSelector = '.product-info-overview';
        this.productUniqueIdAttribute = 'data-product-unique-id';
        this.categoryUniqueIdAttribute = 'data-category-unique-id';
        this.ecproductUniqueIdAttribute = 'data-ecproduct-unique-id';
        this.eccategoryUniqueIdAttribute = 'data-eccategory-unique-id';
        this.categoryTitleAttribute = 'data-category-title';
        this.selectedCompareItems = [];
        this.comparisonBarContainerSelector = '.product-comparison-bar-container';
        this.comparisonSelectIndicatorTemplate = _.template("<%= count %> out of <%= total %>");
        this.selectedProductComparisonKey = 'selected-product-comparison';
        this.headerSelector = '.header';
        this.footerSelector = '.footer-container';
        this.chatbotWrapper = '.chatbot-wrapper';
        this.chatbotTransitionDuration = 1000;
        this.chatbotTextList = [
            "..",
        ];
    }
    Utils.prototype.typedAnimate = function () {
        $(this.chatbotWrapper + ':visible').find('h4.message.conversation-loader span').typed({
            strings: this.chatbotTextList,
            loop: true,
            typeSpeed: 500,
            showCursor: false
        });
    };
    Utils.prototype.chatbotUserInteraction = function () {
        var _this = this;
        $(this.chatbotWrapper).show();
        // $(this.chatbotWrapper + ':visible').find('.results').children().slice(3).remove();
        if ($(this.chatbotWrapper + ':visible').find('.from-user').length < 1) {
            $(this.chatbotWrapper + ':visible').find('.from-chatbot').finish().css({ opacity: 0, position: 'absolute', top: '70%' });
        }
        if ($(window).width() <= window['brands'].mobile_screen) {
            $(this.chatbotWrapper + ':visible').find('h1.message').parent().finish().animate({ top: 1, opacity: 1 }, this.chatbotTransitionDuration, 'swing', function () {
                $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').parent().finish().animate({ top: 6 + $(_this.chatbotWrapper + ':visible').find('h1.message').parent().height(), opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                    $(_this.chatbotWrapper + ':visible').find('h4.message:eq(1)').parent().finish().animate({ top: 11 + $(_this.chatbotWrapper + ':visible').find('h1.message').parent().height() + $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').parent().height(), opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                        // this.typedAnimate();
                        $(_this.chatbotWrapper + ':visible').find('h4.message:eq(2)').parent().finish().animate({ top: 16 + $(_this.chatbotWrapper + ':visible').find('h1.message').parent().height() + $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').parent().height() + $(_this.chatbotWrapper + ':visible').find('h4.message:eq(1)').parent().height(), opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                            // $(this.chatbotWrapper + ':visible').find('h4.message:eq(3)').parent().finish().animate({ opacity: 1 }, this.chatbotTransitionDuration, 'swing', () => {
                            // $(this.chatbotWrapper + ':visible').find('.results').css({ position: 'relative' });
                            // });
                            $(_this.chatbotWrapper + ':visible').css({ 'overflow-y': 'auto' });
                        });
                    });
                });
            });
        }
        else {
            $(this.chatbotWrapper + ':visible').find('h1.message').parent().finish().animate({ top: 0, opacity: 1 }, this.chatbotTransitionDuration, 'swing', function () {
                $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').parent().finish().animate({ top: 5 + $(_this.chatbotWrapper + ':visible').find('h1.message').parent().height(), opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                    $(_this.chatbotWrapper + ':visible').find('h4.message:eq(1)').parent().finish().animate({ top: 10 + $(_this.chatbotWrapper + ':visible').find('h1.message').parent().height() + $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').parent().height(), opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                        // this.typedAnimate();
                        $(_this.chatbotWrapper + ':visible').find('h4.message:eq(2)').parent().finish().animate({ top: 15 + $(_this.chatbotWrapper + ':visible').find('h1.message').parent().height() + $(_this.chatbotWrapper + ':visible').find('h4.message:eq(0)').parent().height() + $(_this.chatbotWrapper + ':visible').find('h4.message:eq(1)').parent().height(), opacity: 1 }, _this.chatbotTransitionDuration, 'swing', function () {
                            // $(this.chatbotWrapper + ':visible').find('h4.message:eq(3)').parent().finish().animate({ opacity: 1 }, this.chatbotTransitionDuration, 'swing', () => {
                            $(_this.chatbotWrapper + ':visible').css({ 'overflow-y': 'auto' });
                            // });
                        });
                    });
                });
            });
        }
    };
    Utils.prototype.rebindHeaderAndFooterLinksWithoutHash = function () {
        $(this.headerSelector + ', ' + this.footerSelector).find('a[href]').each(function (index, item) {
            var href = $(item).attr('href');
            if (href.indexOf('#') > -1) {
                var hashVal = href.substr(href.indexOf('#'));
                hashVal = hashVal.split(',')[0];
                href = href.substr(0, href.indexOf('#')) + hashVal;
                $(item).attr('href', href);
            }
        });
    };
    Utils.prototype.productOverviewButtonAlignmentEqualizer = function (cb) {
        if (cb === void 0) { cb = false; }
        if ($(this.productOverviewClassName).parent().parent().find('.col-xs-12').length < 1) {
            if (typeof cb == 'function') {
                cb();
            }
            return void 0;
        }
        if ($(window).width() <= window['brands'].mobile_screen) {
            $(this.productOverviewClassName).parent().parent().each(function (index, item) {
                $(item).find('.col-xs-12').css('height', 'auto');
            });
            if (typeof cb == 'function') {
                cb();
            }
            return void 0;
        }
        var euqalizationProcessor = function (item, isOnload) {
            $(item).find('.col-xs-12').css('height', 'auto');
            var width = $(item).find('.col-xs-12').width();
            var height = Math.max.apply(null, $(item).find('.col-xs-12').map(function (index, colItem) { return $(colItem).height(); }).get());
            var titleHeight = Math.max.apply(null, $(item).find('.col-xs-12 h5').map(function (index, colItem) { return $(colItem).height(); }).get());
            var productInfoOverviewDetailHeight = Math.max.apply(null, $(item).find('.col-xs-12').find('.product-info-overview-detail').map(function (index, colItem) { return $(colItem).height(); }).get());
            if (isOnload) {
                $(item).find('.col-xs-12').css('height', (height));
            }
            else {
                $(item).find('.col-xs-12').css('height', (height));
            }
        };
        $(this.productOverviewClassName).parent().parent().each(function (index, item) {
            euqalizationProcessor(item, false);
            $(item).find('img:last').on('load', function () {
                euqalizationProcessor(item, true);
            });
            $(item).find('img:last').on('error', function () {
                euqalizationProcessor(item, true);
            });
        });
        if (typeof cb == 'function') {
            cb();
        }
    };
    Utils.prototype.articleListingAlignmentEqualizer = function () {
        if ($(this.articleClassName).parent().parent().find('.col-xs-12').length < 1)
            return void 0;
        if ($(window).width() <= window['brands'].mobile_screen) {
            $(this.articleClassName).parent().parent().each(function (index, item) {
                $(item).find('.col-xs-12').css('height', 'auto');
            });
            return void 0;
        }
        $(this.articleClassName).parent().parent().each(function (index, item) {
            var width = $(item).find('.col-xs-12').width();
            var height = Math.max.apply(null, $(item).find('.col-xs-12').map(function (index, colItem) { return $(colItem).height(); }).get());
            $(item).find('.col-xs-12').css('height', height);
        });
    };
    Utils.prototype.compareProductAlignmentEqualizer = function () {
        if ($(this.compareProductClassName).length < 1)
            return void 0;
        var slideInfoContentRow = [];
        $(this.compareProductClassName).each(function (index, item) {
            $(item).find('.info-content-row').each(function (indexRow, itemRow) {
                var height = $(itemRow).find('.col-lg-12').height();
                if (slideInfoContentRow.length > indexRow && height > slideInfoContentRow[indexRow]) {
                    slideInfoContentRow[indexRow] = height;
                }
                else if (slideInfoContentRow.length <= indexRow) {
                    slideInfoContentRow.push(height);
                }
            });
        });
        if (slideInfoContentRow.length > 0) {
            $(this.compareProductClassName).each(function (index, item) {
                $(item).find('.info-content-row').each(function (indexRow, itemRow) {
                    $(itemRow).find('.col-lg-12').css({ 'min-height': slideInfoContentRow[indexRow] });
                });
            });
        }
        var height = Math.max.apply(null, $(this.compareProductClassName).find('.compare-products-info .content h4').map(function (index, colItem) { return $(colItem).height(); }).get());
        $(this.compareProductClassName).find('.compare-products-info .content h4').height(height);
    };
    Utils.prototype.disabledCheckedBox = function () {
        //disable or the unchekc checkbox if items is maximun
        if (this.selectedCompareItems.length == this.maxAllowedComparison) {
            $(':checkbox:not(:checked)').prop('disabled', true);
        }
        else {
            $(':checkbox').prop('disabled', false);
        }
    };
    Utils.prototype.showHideComparisonBarContainer = function () {
        if (this.selectedCompareItems.length > 0) {
            $('.select-indicator').html(this.comparisonSelectIndicatorTemplate({ count: this.selectedCompareItems.length, total: this.maxAllowedComparison }));
            $(this.comparisonBarContainerSelector).removeClass('hide');
        }
        else {
            $(this.comparisonBarContainerSelector).addClass('hide');
        }
    };
    Utils.prototype.removeSelectedComparisonItem = function (selectedId, renderedItem) {
        if (renderedItem === void 0) { renderedItem = false; }
        // let selectedId: string = $(e.currentTarget).attr('data-selected-id');
        this.selectedCompareItems = _.filter(this.selectedCompareItems, function (item) {
            return item.id != selectedId;
        });
        amplify.store(this.selectedProductComparisonKey, this.selectedCompareItems);
        if (renderedItem) {
            renderedItem.remove();
            $('input[data-product-unique-id="' + selectedId + '"]').attr('checked', false);
            this.disabledCheckedBox();
        }
        else {
            var selectedItem = $(this.comparisonBarContainerSelector).find('.col-lg-8').find('.row').find('.brands-icon[data-selected-id="' + selectedId + '"]');
            if (selectedItem.length > 0) {
                selectedItem.parent().parent().remove();
                $('input[data-product-unique-id="' + selectedId + '"]').attr('checked', false);
                this.disabledCheckedBox();
            }
        }
        this.showHideComparisonBarContainer();
    };
    Utils.prototype.renderComparisonbar = function () {
        var _this = this;
        if (!this.selectedCompareItems || this.selectedCompareItems.length < 1) {
            this.selectedCompareItems = amplify.store(this.selectedProductComparisonKey) || [];
        }
        if (this.selectedCompareItems.length > 0) {
            var renderedItemIndex = $(this.comparisonBarContainerSelector).find('.col-lg-8').find('.row').children().length;
            renderedItemIndex += 1;
            var _loop_1 = function(i) {
                var itemToRender = this_1.selectedCompareItems[i - 1];
                itemToRender.icon = window['brands'].icons.close;
                var renderedItem = $(comparisonTempalate.template(itemToRender)).appendTo($(this_1.comparisonBarContainerSelector).find('.col-lg-8').find('.row'));
                $(renderedItem).find('.brands-icon').on('click', function (e) {
                    _this.removeSelectedComparisonItem($(e.currentTarget).attr('data-selected-id'), renderedItem);
                });
                $('input[data-product-unique-id="' + itemToRender.id + '"]').attr('checked', 'checked');
            };
            var this_1 = this;
            for (var i = renderedItemIndex; i <= this.selectedCompareItems.length; i++) {
                _loop_1(i);
            }
            this.disabledCheckedBox();
        }
        else {
            $(this.comparisonBarContainerSelector).find('.col-lg-8').find('.row').find('.brands-icon').each(function (index, item) {
                _this.removeSelectedComparisonItem($(item).attr('data-selected-id'), false);
            });
        }
    };
    Utils.prototype.bindProductComparison = function () {
        var _this = this;
        if ($('.product-comparison-bar-container').attr('data-max-col'))
            this.maxAllowedComparison = $('.product-comparison-bar-container').attr('data-max-col');
        $('#comparenow').off().on('click', function (e) {
            e.preventDefault();
            var href = $(e.currentTarget).attr('data-href');
            if (!href)
                return void 0;
            var dataLayer = {
                "event": {
                    "eventInfo": {
                        "eventType": "product_comparison",
                        "eventName": (_.pluck(_this.selectedCompareItems, "id").join('|'))
                    }
                },
                "product": {
                    "category": {
                        "primaryCategory": (_.pluck(_this.selectedCompareItems, "categoryid").join('|')),
                        "primaryCategoryID": (_.pluck(_this.selectedCompareItems, "eccategoryid").join('|'))
                    },
                    "productInfo": {
                        "productName": (_.pluck(_this.selectedCompareItems, "id").join('|')),
                        "productID": (_.pluck(_this.selectedCompareItems, "ecid").join('|'))
                    }
                }
            };
            var selectedKeys = _.pluck(_this.selectedCompareItems, 'id');
            href += '?maxCol=' + _this.maxAllowedComparison;
            href += '&q=' + selectedKeys.join(',');
            if (window['brands'].tracker) {
                window['brands'].tracker.buildAnalyticsWithLocalStorage(href, dataLayer);
            }
        });
        $('#clearallselection').off().on('click', function (e) {
            _this.selectedCompareItems = [];
            amplify.store(_this.selectedProductComparisonKey, null);
            _this.renderComparisonbar();
            _this.showHideComparisonBarContainer();
        });
        // show the comparison bar here
        this.renderComparisonbar();
        this.showHideComparisonBarContainer();
        $(this.productInfoOverviewSelector).each(function (index, item) {
            $(item).find('.checkbox').find('input[' + _this.productUniqueIdAttribute + ']').off().on('click', function (e) {
                e.stopPropagation();
                var categoryUniqueId = $(e.currentTarget).attr(_this.categoryUniqueIdAttribute);
                var categoryTitle = $(e.currentTarget).attr(_this.categoryTitleAttribute);
                var productUniqueId = $(e.currentTarget).attr(_this.productUniqueIdAttribute);
                var title = $(e.currentTarget).parent().next().find('h5').text();
                var img = $(e.currentTarget).parent().prev().find('img').attr('src');
                var eccategoryUniqueId = $(e.currentTarget).attr(_this.eccategoryUniqueIdAttribute);
                var ecproductUniqueId = $(e.currentTarget).attr(_this.ecproductUniqueIdAttribute);
                var selectedIndex = _.findIndex(_this.selectedCompareItems, function (item) { return item.id == productUniqueId; });
                if (selectedIndex == -1) {
                    if (_this.selectedCompareItems.length < _this.maxAllowedComparison) {
                        _this.selectedCompareItems.push({
                            categoryid: categoryUniqueId,
                            eccategoryid: eccategoryUniqueId,
                            categorytitle: categoryTitle,
                            id: productUniqueId,
                            ecid: ecproductUniqueId,
                            title: title,
                            img: img
                        });
                        amplify.store(_this.selectedProductComparisonKey, _this.selectedCompareItems);
                        _this.renderComparisonbar();
                        _this.showHideComparisonBarContainer();
                        if (window['brands'].tracker) {
                            if ($(e.currentTarget).attr(window['brands'].tracker.dataAnalyticsAttr)) {
                                window['brands'].tracker.customTrack($(e.currentTarget).attr(window['brands'].tracker.dataAnalyticsAttr));
                            }
                        }
                    }
                }
                else {
                    // already selected// remove now
                    _this.removeSelectedComparisonItem(productUniqueId);
                }
            });
            $(item).find('.checkbox').off().on('click', function (e) {
                var target = $(e.currentTarget).find('input[' + _this.productUniqueIdAttribute + ']');
                if (target.length < 1)
                    return void 0;
                $(target).trigger('click');
            });
        });
    };
    return Utils;
}());
exports.Utils = Utils;
var Loader = (function () {
    function Loader() {
        // private loaderHtml: string = '<svg class="brands-icon brands-loader fa-pulse"><use href="/clientlib-site/images/icons/symbol-defs.svg#icon-loading" xlink:href="/en/images/icons/symbol-defs.svg#icon-loading"></use></svg>';
        this.loaderIndicatorTemplate = _.template('<svg class="brands-icon brands-loader icon-center fa-pulse"><use href="<%= icon %>" xlink:href="<%= icon %>"></use></svg>');
    }
    Loader.prototype.show = function (wrapper, center) {
        if (center === void 0) { center = false; }
        if ($(wrapper).length < 1)
            return void 0;
        if (center) {
            $(wrapper).html($(this.loaderIndicatorTemplate({ icon: (window['brands'].icons.loader) })).addClass('pull-center'));
        }
        else {
            $(wrapper).html(this.loaderIndicatorTemplate({ icon: (window['brands'].icons.loader) }));
        }
    };
    Loader.prototype.hide = function (wrapper) {
        if ($(wrapper).length < 1)
            return void 0;
        $(wrapper).find('.brands-loader').remove();
    };
    return Loader;
}());
exports.Loader = Loader;
var AccordionComponent = (function () {
    function AccordionComponent(id, multiexpandable) {
        var _this = this;
        this.accordionCollapsable = '.collapsable';
        this.accordionContent = '.content';
        this.accordionOpenDefault = '.is-open';
        this.trackedFAQQuestions = [];
        this.accordionComponent = '#' + id;
        $(this.accordionComponent).find(this.accordionCollapsable).each(function (index, item) {
            $(item).parent().parent().find(_this.accordionContent).slideUp();
            if ($(item).parent().parent().first().find(_this.accordionContent + _this.accordionOpenDefault).length > 0) {
                $(item).parent().parent().find(_this.accordionContent + _this.accordionOpenDefault).first().slideDown();
                $(item).parent().find('.icon-expand').first().addClass('hide');
                $(item).parent().find('.icon-collapse').first().removeClass('hide');
            }
            var showHide = function () {
                if (!$(item).parent().find(_this.accordionContent).is(":visible")) {
                    if (!multiexpandable) {
                        $(item).parent().parent().find(_this.accordionContent).first().slideUp();
                    }
                    $(item).parent().find(_this.accordionContent).first().slideDown();
                    $(item).parent().find('.icon-expand').first().addClass('hide');
                    $(item).parent().find('.icon-collapse').first().removeClass('hide');
                    if ($(_this.accordionComponent).find('.product-faq').length > 0) {
                        // track faq expand only once
                        if (window['brands'].tracker) {
                            var categoryName = $(item).parent().parent().find('li:first').text();
                            var question = $(item).text();
                            if (!$(_this.accordionComponent).hasClass('product-accordion')) {
                                categoryName = $('#faqaccordion').parent().find('h2:first').text();
                                ;
                                question = $(item).text();
                                ;
                            }
                            if (_this.trackedFAQQuestions.indexOf(question) > -1)
                                return void 0;
                            _this.trackedFAQQuestions.push(question);
                            window['brands'].tracker.trackFAQCategory(categoryName.trim().replace(/(\r\n|\n|\r)/gm, ""), question.trim().replace(/(\r\n|\n|\r)/gm, ""));
                        }
                    }
                }
                else {
                    if (!multiexpandable) {
                        $(item).parent().parent().find(_this.accordionContent).first().slideUp();
                    }
                    $(item).parent().find(_this.accordionContent).first().slideUp();
                    $(item).parent().find('.icon-expand').first().removeClass('hide');
                    $(item).parent().find('.icon-collapse').first().addClass('hide');
                }
            };
            $(item).off().on('click', function ($event) {
                if ($(item).parent().parent().hasClass('product-accordion') && $(window).width() > window['brands'].mobile_screen)
                    return void 0;
                showHide();
            });
            $(item).parent().find('.icon-expand, .icon-collapse').off().on('click', function ($event) {
                if ($(item).parent().parent().hasClass('product-accordion') && $(window).width() > window['brands'].mobile_screen)
                    return void 0;
                showHide();
            });
            if ($('#seemorefaq').length > 0 && $(_this.accordionComponent).find('.product-faq').length > 0) {
                $(_this.accordionComponent).find('.accordion-wrapper').each(function (index, itemSub) {
                    if (index > 3) {
                        $(itemSub).hide();
                    }
                });
                $('#seemorefaq').on('click', function (e) {
                    $(_this.accordionComponent).find('.accordion-wrapper:hidden').each(function (index, item) {
                        if (index < 3) {
                            $(item).fadeIn();
                        }
                    });
                    if ($(_this.accordionComponent).find('.accordion-wrapper:hidden').length < 1) {
                        $('#seemorefaq').hide();
                    }
                });
            }
        });
    }
    return AccordionComponent;
}());
exports.AccordionComponent = AccordionComponent;
var ApiAICustom = (function () {
    function ApiAICustom() {
        this.accessToken = '9df32f4839ff408089222f118d8f266b';
        this.endpoint = 'https://api.api.ai/v1/';
        this.version = '20150910';
        this.sessionId = this.generateSession(32);
    }
    ApiAICustom.prototype.generateSession = function (length) {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        for (var i = 0; i < length; i++) {
            text += possible.charAt(Math.floor(Math.random() * possible.length));
        }
        return text;
    };
    ApiAICustom.prototype.sendQuery = function (msg) {
        var _this = this;
        $.ajax({
            type: "POST",
            url: this.endpoint + "query?v=" + this.version,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            headers: {
                "Authorization": "Bearer " + this.accessToken
            },
            data: JSON.stringify({ q: msg, lang: "en", sessionId: this.sessionId }),
            success: function (data) {
                if (_this.onResults && typeof (_this.onResults) === 'function')
                    _this.onResults(data);
            },
            error: function (xhr, status, error) {
                if (_this.onError && typeof (_this.onError) === 'function')
                    _this.onError(99, error);
            }
        });
    };
    return ApiAICustom;
}());
exports.ApiAICustom = ApiAICustom;
