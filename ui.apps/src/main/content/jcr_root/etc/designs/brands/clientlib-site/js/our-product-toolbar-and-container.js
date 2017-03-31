"use strict";
var $ = require('jquery');
var shared_1 = require('./shared');
var productTemplate = require('product-container-partial');
var Swiper = require('swiper');
var _ = require('underscore');
var OurProductToolbarAndContainer = (function () {
    // private maxAllowedComparison: number = 4;
    // private productInfoOverviewSelector = '.product-info-overview';
    // private productUniqueIdAttribute = 'data-product-unique-id';
    // private selectedCompareItems: Array<any> = [];
    // private comparisonBarContainerSelector: string = '.product-comparison-bar-container';
    // private comparisonSelectIndicatorTemplate: any = _.template("<%= count %> out of <%= total %>");
    function OurProductToolbarAndContainer() {
        this.wrapperClassName = '.js-product-container-wrapper';
        this.swiperSlideClassName = '.js-toolbar-container';
        this.maxAllowedSelection = 2;
        this.ourProductEndPoint = '/dummy-data/data.json';
        this.loader = new shared_1.Loader();
        this.clearAll = '#clearall';
        this.applylifestagesfilter = '#applylifestagesfilter';
        this.utils = new shared_1.Utils();
        this.selectedFilterIds = [];
        this.ourProductBannerItemSelector = '.our-product-banner-item';
        this.init();
    }
    OurProductToolbarAndContainer.prototype.init = function () {
        var _this = this;
        if (typeof prodCategoryPath != 'undefined' && prodCategoryPath) {
            this.ourProductEndPoint = prodCategoryPath;
        }
        // if(typeof prodFilterResultPath != 'undefined' && prodFilterResultPath) {
        //   this.ourProductEndPoint = prodFilterResultPath;
        // }
        var __this = this;
        this.render(false).then(function (html) {
            $(_this.wrapperClassName)
                .html(html)
                .promise()
                .done(function () {
                __this.postRender(html);
            });
        });
        $(document).ready(function () {
            $('.js-toolbar-container li').each(function (index, item) {
                $(this).on('click', function (e) {
                    if ($(item).hasClass('active') === false) {
                        if ($('.js-toolbar-container li.active').length >= __this.maxAllowedSelection)
                            return void 0;
                        $(item).addClass('active');
                        if ($(item).find('.brands-icon').length > 0) {
                            if ($(item).find('.brands-icon use').attr('href').indexOf('icon-active-people-primary') > -1) {
                                $(item).find('.brands-icon use').attr('href', $(item).find('.brands-icon use').attr('href').replace('icon-active-people-primary', 'icon-active-people-secondary'));
                                $(item).find('.brands-icon use').attr('xlink:href', $(item).find('.brands-icon use').attr('xlink:href').replace('icon-active-people-primary', 'icon-active-people-secondary'));
                            }
                            else if ($(item).find('.brands-icon use').attr('href').indexOf('icon-busy-adult') > -1) {
                                $(item).find('.brands-icon use').attr('href', $(item).find('.brands-icon use').attr('href').replace('icon-busy-adult', 'icon-busy-adult-secondary'));
                                $(item).find('.brands-icon use').attr('xlink:href', $(item).find('.brands-icon use').attr('xlink:href').replace('icon-busy-adult', 'icon-busy-adult-secondary'));
                            }
                            else if ($(item).find('.brands-icon use').attr('href').indexOf('icon-student-primary') > -1) {
                                $(item).find('.brands-icon use').attr('href', $(item).find('.brands-icon use').attr('href').replace('icon-student-primary', 'icon-student-secondary'));
                                $(item).find('.brands-icon use').attr('xlink:href', $(item).find('.brands-icon use').attr('xlink:href').replace('icon-student-primary', 'icon-student-secondary'));
                            }
                        }
                        // icon-active-people-primary
                        __this.selectedFilterIds.push($(item).attr('data-id').trim());
                    }
                    else {
                        $(item).removeClass('active');
                        if ($(item).find('.brands-icon').length > 0) {
                            if ($(item).find('.brands-icon use').attr('href').indexOf('icon-active-people-secondary') > -1) {
                                $(item).find('.brands-icon use').attr('href', $(item).find('.brands-icon use').attr('href').replace('icon-active-people-secondary', 'icon-active-people-primary'));
                                $(item).find('.brands-icon use').attr('xlink:href', $(item).find('.brands-icon use').attr('xlink:href').replace('icon-active-people-secondary', 'icon-active-people-primary'));
                            }
                            else if ($(item).find('.brands-icon use').attr('href').indexOf('icon-busy-adult-secondary') > -1) {
                                $(item).find('.brands-icon use').attr('href', $(item).find('.brands-icon use').attr('href').replace('icon-busy-adult-secondary', 'icon-busy-adult'));
                                $(item).find('.brands-icon use').attr('xlink:href', $(item).find('.brands-icon use').attr('xlink:href').replace('icon-busy-adult-secondary', 'icon-busy-adult'));
                            }
                            else if ($(item).find('.brands-icon use').attr('href').indexOf('icon-student-secondary') > -1) {
                                $(item).find('.brands-icon use').attr('href', $(item).find('.brands-icon use').attr('href').replace('icon-student-secondary', 'icon-student-primary'));
                                $(item).find('.brands-icon use').attr('xlink:href', $(item).find('.brands-icon use').attr('xlink:href').replace('icon-student-secondary', 'icon-student-primary'));
                            }
                        }
                        __this.selectedFilterIds.splice(__this.selectedFilterIds.indexOf($(item).attr('data-id').trim()), 1);
                    }
                });
            });
            $(_this.clearAll).on('click', function () {
                $('.js-toolbar-container li.active').removeClass('active');
                _this.selectedFilterIds = [];
                $(_this.applylifestagesfilter).trigger('click');
            });
            $(_this.applylifestagesfilter).off().on('click', function (e) {
                if (window['brands'].tracker && window['brands'].tracker.trackLifestagesFilter) {
                    var value_1 = [];
                    $('.js-toolbar-container li.active').each(function (index, item) {
                        value_1.push($(item).attr('data-id').trim());
                    });
                    if (value_1.length > 0)
                        window['brands'].tracker.trackLifestagesFilter(value_1.join("|"));
                }
                // if($('.js-toolbar-container li.active').length > 0) {
                // do filter now
                __this.render(__this.selectedFilterIds.join(',')).then(function (html) {
                    $(__this.wrapperClassName)
                        .html(html)
                        .promise()
                        .done(function () {
                        __this.postRender(html, __this.selectedFilterIds.join(','));
                        $(_this.wrapperClassName).append("<script>window['brands'].ourProductFunc(false);</script>");
                    });
                });
                // }
            });
            new Swiper(_this.swiperSlideClassName, {
                loop: false,
                // pagination: '.product-instruction-slider-pagination',
                slidesPerView: 7,
                paginationClickable: true,
                centeredSlides: false,
                spaceBetween: 2,
                nextButton: '.swiper-lifestages-next',
                prevButton: '.swiper-lifestages-prev',
                breakpoints: {
                    1500: {
                        slidesPerView: 6
                    },
                    1200: {
                        slidesPerView: 4
                    },
                    1100: {
                        slidesPerView: 3
                    },
                    767: {
                        slidesPerView: 2
                    }
                },
                onSlideChangeEnd: function (swiper) {
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
            _this.utils.rebindHeaderAndFooterLinksWithoutHash();
        });
    };
    OurProductToolbarAndContainer.prototype.postRender = function (html, filterParams) {
        var _this = this;
        if (filterParams === void 0) { filterParams = false; }
        if (filterParams) {
            var filterParamsArray = filterParams.split(',');
            $.each(filterParamsArray, function (index, filterParam) {
                $("ul.product-benefits li").each(function (key, list) {
                    var iconDataId = $(list).data('id');
                    if (iconDataId == filterParam) {
                        $(list).addClass("selected-life-stage");
                    }
                });
            });
        }
        $('.product-row-wrapper').each(function () {
            $(this).find('.product-col-wrapper.hidden-xs').first().removeClass('hidden-xs');
        });
        $('.product-container .view-all').each(function (index, item) {
            //check how many item inside container $(item).hide()
            var productItemCount = $(item).parent().parent().parent().parent().parent().find('.product-row-wrapper').children().length;
            if (productItemCount == 1) {
                $(item).hide();
            }
            $(_this).find('span').text($(_this).closest('.product-container').find('.product-row-wrapper .product-col-wrapper').length);
        });
        $('.product-container .view-all').click(function () {
            if ($(this).closest('.product-container').find('.product-col-wrapper').hasClass('hidden-xs')) {
                $(this).closest('.product-container').find('.product-col-wrapper').removeClass('hidden-xs');
                $(this).closest('.view-all').text($(this).closest('.view-all').attr('data-hide-all-text'));
            }
            else {
                $(this).closest('.product-container').find('.product-col-wrapper').addClass('hidden-xs');
                $(this).closest('.product-container').find('.product-col-wrapper').first().removeClass('hidden-xs');
                var productItemCount = $(this).closest('.product-container').find('.product-info-overview').length;
                // $(this).closest('.view-all span').text(' (' + productItemCount + ')');
                $(this).closest('.view-all').text($(this).closest('.view-all').attr('data-view-all-text'));
                $('html, body').animate({
                    scrollTop: $(this).closest('.product-container').find('.product-col-wrapper').first().offset().top - 100
                }, 500);
            }
        });
        if ($(window).width() <= window['brands'].mobile_screen) {
        }
        else {
        }
        this.utils.bindProductComparison();
        // setTimeout(() => {
        //   this.utils.productOverviewButtonAlignmentEqualizer(() => {
        //     if(location.hash) {
        //       let hash: Array<string> = location.hash.split(',');
        //       if(hash.length > 0) {
        //         $(document.body).animate({
        //           'scrollTop': $(hash[0]).offset().top
        //         }, 600);  
        //       }
        //     }
        //   });
        // }, 500);
        if (!window['brands'].ourProductFunc) {
            window['brands'].ourProductFunc = function (processHash) {
                // SystemJS.import('footer.js').then(() => {
                _this.utils.productOverviewButtonAlignmentEqualizer(function () {
                    if (location.hash && processHash) {
                        var hash = location.hash.split(',');
                        for (var i = 0; i < hash.length; i++) {
                            var hashQs = hash[i].split('=');
                            if (hashQs && hashQs.length > 1) {
                                if (hashQs[0].replace('#', '') == 'profile') {
                                    // select lifestages
                                    if ($('.js-toolbar-container li[data-id="' + hashQs[1] + '"]').length > 0) {
                                        $('.js-toolbar-container li[data-id="' + hashQs[1] + '"]').addClass('active');
                                        _this.selectedFilterIds.push($('.js-toolbar-container li[data-id="' + hashQs[1] + '"]').attr('data-id').trim());
                                        $(_this.applylifestagesfilter).trigger('click');
                                        $(document.body).animate({
                                            'scrollTop': $(_this.swiperSlideClassName).offset().top
                                        }, 600);
                                    }
                                }
                            }
                            else if (i == 0 && hash[i].indexOf('=') < 0) {
                                $(document.body).animate({
                                    'scrollTop': $(hash[0]).offset().top
                                }, 600);
                            }
                        }
                    }
                });
                // });
            };
            $(this.wrapperClassName).append("<script>window['brands'].ourProductFunc(true);</script>");
        }
        // $(window).off().on('load', () => {
        $('.product-container a').on('click', function (e) {
            if (window['brands'].tracker) {
                if ($(e.currentTarget).attr(window['brands'].tracker.dataAnalyticsAttr)) {
                    window['brands'].tracker.customTrack($(e.currentTarget).attr(window['brands'].tracker.dataAnalyticsAttr));
                }
            }
        });
        $(window).resize(function () {
            _this.utils.productOverviewButtonAlignmentEqualizer();
        });
    };
    OurProductToolbarAndContainer.prototype.render = function (filterParams) {
        var _this = this;
        this.loader.show(this.wrapperClassName);
        var html = '';
        var defer = $.Deferred();
        if (filterParams) {
            if (typeof prodFilterResultPath != 'undefined' && prodFilterResultPath) {
                this.ourProductEndPoint = prodFilterResultPath + '?filter=' + filterParams;
            }
        }
        else {
            if (typeof prodCategoryPath != 'undefined' && prodCategoryPath) {
                this.ourProductEndPoint = prodCategoryPath;
            }
        }
        $.get(this.ourProductEndPoint)
            .success(function (data) {
            // just for local testing
            // if($('.js-toolbar-container li.active').length > 0)
            // data.ourProducts.splice($('.js-toolbar-container li.active').length, data.ourProducts.length);
            // just for local testing
            // aem has difficulty to group
            var groupedProducts = _.chain(_.clone(data.ourProducts))
                .groupBy('title')
                .map(function (p) {
                var p1 = {
                    title: '',
                    categoryid: '',
                    eccategoryid: '',
                    tiles: []
                };
                var adsTile = [];
                for (var i = 0; i < p.length; i++) {
                    p1.title = p[i].title;
                    p1.categoryid = p[i].categoryid;
                    p1.eccategoryid = p[i].eccategoryid;
                    if (p[i].tiles[0].type == 'ads' && (p[i].pos == 3 || p[i].pos == 6 || p[i].pos == 9)) {
                        // p1.tiles.splice(p[i].pos-1, 0, p[i].tiles[0]);
                        adsTile.push({
                            pos: p[i].pos,
                            tiles: p[i].tiles[0]
                        });
                    }
                    else {
                        p1.tiles.push(p[i].tiles[0]);
                    }
                }
                for (var i = 0; i < adsTile.length; i++) {
                    p1.tiles.splice(adsTile[i].pos - 1, 0, adsTile[i].tiles);
                }
                return p1;
            })
                .value();
            for (var _i = 0, groupedProducts_1 = groupedProducts; _i < groupedProducts_1.length; _i++) {
                var ourProduct = groupedProducts_1[_i];
                html += productTemplate.template({
                    view_all_label: (data.labels ? data.labels.viewall : false),
                    hide_all_label: (data.labels ? data.labels.hideall : false),
                    selectedLifeStages: (_this.selectedFilterIds),
                    title: ourProduct.title,
                    categoryid: ourProduct.categoryid,
                    eccategoryid: ourProduct.eccategoryid,
                    tileList: ourProduct.tiles,
                    arrowDown: window['brands'].icons.arrowDown,
                    arrowUp: window['brands'].icons.arrowUp
                });
            }
            _this.loader.hide(_this.wrapperClassName);
            defer.resolve(html);
        })
            .error(function (error) {
            _this.loader.hide(_this.wrapperClassName);
            defer.reject(error);
        });
        return defer.promise();
    };
    return OurProductToolbarAndContainer;
}());
exports.OurProductToolbarAndContainer = OurProductToolbarAndContainer;
new OurProductToolbarAndContainer();
