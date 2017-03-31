"use strict";
var $ = require('jquery');
var shared_1 = require('./shared');
var shared_2 = require('./shared');
var faqTempalate = require('faq-container-partial');
var Swiper = require('swiper');
var Faq = (function () {
    function Faq() {
        var _this = this;
        this.wrapperClassName = '.js-faq-content-wrapper';
        this.loader = new shared_2.Loader();
        this.defaultEndpoint = '';
        this.toolbarClassName = '.js-faq-category-toolbar-container';
        $(document).ready(function () {
            _this.init();
        });
    }
    Faq.prototype.init = function () {
        var _this = this;
        var __this = this;
        $(document).ready(function () {
            _this.defaultEndpoint = $('.faq-category-list .btn-action').attr('data-url');
            new Swiper(_this.toolbarClassName, {
                loop: false,
                nextButton: '.faq-next',
                prevButton: '.faq-prev',
                slidesPerView: 4,
                paginationClickable: true,
                centeredSlides: false,
                spaceBetween: 10,
                breakpoints: {
                    1024: {
                        slidesPerView: 3
                    },
                    767: {
                        slidesPerView: 1
                    }
                },
                onInit: function (swiper) {
                    $(_this.toolbarClassName).css('opacity', 1);
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
            $('.faq--category a').each(function (index, category) {
                $(category).on('click', function (e) {
                    var url = $(category).attr('data-url');
                    var text = $(category).text();
                    if (!url)
                        return void 0;
                    $('.faq--category a.btn-action').addClass('btn-default');
                    $('.faq--category a.btn-action').removeClass('btn-action');
                    $(category).addClass('btn-action');
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackFAQCategory(text);
                    }
                    __this.render(url).then(function (html) {
                        $(__this.wrapperClassName).html(html);
                        __this.postRender();
                    });
                });
            });
            _this.render(_this.defaultEndpoint).then(function (html) {
                $(_this.wrapperClassName).html(html);
                _this.postRender();
            });
        });
    };
    Faq.prototype.postRender = function () {
        new shared_1.AccordionComponent('faqaccordion');
    };
    Faq.prototype.render = function (endpoint) {
        var _this = this;
        this.loader.show(this.wrapperClassName);
        var html = '';
        var defer = $.Deferred();
        $.get(endpoint)
            .success(function (data) {
            if (!data.faqs)
                return defer.reject(new Error("Invalid Data"));
            var faqBulletListBuilder = function (items) {
                if (!items || items.length < 1)
                    return void 0;
                var html = '<ul>';
                for (var i = 0; i < items.length; i++) {
                    html += '<li>' + items[i].text + '</li>';
                    if (items[i].children && items[i].children.length > 0) {
                        html += '<li class="children">';
                        html += faqBulletListBuilder(items[i].children);
                        html += '</li>';
                    }
                }
                html += '</ul>';
                return html;
            };
            for (var i = 0; i < data.faqs.faqList.length; i++) {
                var faqList = data.faqs.faqList[i];
                if ('bulletList' in faqList && faqList.bulletList.length > 0) {
                    faqList.content += '<article class="campaign-text bullet-list">';
                    faqList.content += faqBulletListBuilder(faqList.bulletList);
                    // for(let j = 0; j < faqList.bulletList.length; j ++)
                    // {
                    //   faqList.content += '<li>'+ faqList.bulletList[j] +'</li>';
                    // }
                    faqList.content += '</article>';
                }
            }
            html += faqTempalate.template({
                header: data.faqs.header,
                faqList: data.faqs.faqList,
                arrowDown: window['brands'].icons.arrowDown,
                arrowUp: window['brands'].icons.arrowUp
            });
            _this.loader.hide(_this.wrapperClassName);
            defer.resolve(html);
        })
            .error(function (error) {
            _this.loader.hide(_this.wrapperClassName);
            defer.reject(error);
        });
        return defer.promise();
    };
    return Faq;
}());
exports.Faq = Faq;
new Faq();
