"use strict";
var $ = require('jquery');
var _ = require('underscore');
require('magnific-popup');
var YourBrandsStoryContainer = (function () {
    function YourBrandsStoryContainer() {
        var _this = this;
        this.productInstructionSlideClassName = '.js-product-instruction-slide';
        this.instaImgPrefix = "insta";
        this.instaImgStart = 0;
        this.instaImgLimit = 5;
        this.recentRenderedPos = -1;
        this.instaFeeds = [];
        this.endpoint = '/dummy-data/data.json';
        this.timeoutMS = 5000;
        this.visibleRenderedFeedsIndex = [];
        this.flipBackTempalate = _.template("<h4><a><%= data.title %></a></h4><p><%= data.description %></p>");
        this.staticPos = 3;
        this.titleHashTag = '';
        this.descriptionHashTag = '';
        $(document).ready(function () {
            _this.init();
            _this.fetchInstaFeeds().then(function (result) {
                _this.render();
                if (_this.instaFeeds.length > _this.instaImgVisisble) {
                    setInterval(function () {
                        _this.renderRandomly();
                    }, _this.timeoutMS);
                }
                $.ajaxSetup({
                    dataType: "jsonp",
                });
                var magnificClosebtn = '<button style="color: white; position:relative; float: right;" title="Close (Esc)" type="button" class="mfp-close">×</button>';
                var instance = $('.flip-front').magnificPopup({
                    type: 'ajax',
                    // src: 'https://api.instagram.com/oembed?url=https://www.instagram.com/p/BBmuzyyrziX/&omitscript=true',
                    callbacks: {
                        parseAjax: function (response) {
                            if (response && response.data && response.data.html) {
                                response.data = response.data.html;
                            }
                        },
                        ajaxContentAdded: function () {
                            if (window['brands'].tracker) {
                                var dataLayer = {
                                    "event": {
                                        "eventInfo": {
                                            "eventType": "social_wall",
                                            "eventName": ($(instance).attr('data-mfp-src'))
                                        }
                                    }
                                };
                                window['brands'].tracker.customTrack(dataLayer);
                            }
                            $('.mfp-content').prepend(magnificClosebtn);
                            if (window['instgrm']) {
                                window['instgrm'].Embeds.process();
                            }
                        }
                    }
                });
            });
            // $('.your-brands-story-component').lazyLoadXT();
        });
    }
    YourBrandsStoryContainer.prototype.activateRandom = function () {
        var _this = this;
        if (this.instaFeeds.length > this.instaImgVisisble) {
            setInterval(function () {
                _this.renderRandomly();
            }, this.timeoutMS);
        }
    };
    YourBrandsStoryContainer.prototype.init = function () {
        if (typeof instaPath != 'undefined' && instaPath) {
            this.endpoint = instaPath;
        }
        $('body').append('<style>.mfp-content { width: 30% !important; } @media (max-width: 767px){ .mfp-content { width: 100% !important; } }</style>');
        this.instaImgVisisble = $('.insta-feed-item').length - 1;
    };
    YourBrandsStoryContainer.prototype.fetchInstaFeeds = function () {
        var _this = this;
        var defer = $.Deferred();
        $.get(this.endpoint)
            .success(function (data) {
            if (data && data.instaFeeds && data.instaFeeds.instaFeeds && data.instaFeeds.instaFeeds.length > 0) {
                _this.instaFeeds = data.instaFeeds.instaFeeds;
                _this.titleHashTag = data.instaFeeds.title;
                _this.descriptionHashTag = data.instaFeeds.description;
                defer.resolve(true);
            }
            else if (data && data.instaFeeds && data.instaFeeds.length > 0) {
                _this.instaFeeds = data.instaFeeds;
                if (data.title)
                    _this.titleHashTag = data.title;
                if (data.description)
                    _this.descriptionHashTag = data.description;
                defer.resolve(true);
            }
            else {
                defer.resolve(false);
            }
        })
            .error(function (error) {
            defer.reject(error);
        });
        return defer.promise();
    };
    YourBrandsStoryContainer.prototype.render = function () {
        var _this = this;
        $('.insta-feed-item:visible').each(function (index, item) {
            if (index >= _this.instaFeeds.length || !_this.instaFeeds[index])
                return void 0;
            if (index != _this.staticPos) {
                if (_this.visibleRenderedFeedsIndex.indexOf(index) === -1)
                    _this.visibleRenderedFeedsIndex.push(index);
                // $(item).find('img').attr({'src': this.instaFeeds[index].image, 'data-mfp-src': this.instaFeeds[index].url});
                $(item).css("background-image", "url(" + _this.instaFeeds[index].image + ")");
                $(item).attr({ 'data-mfp-src': _this.instaFeeds[index].url });
            }
            $(item).find('div.flip-back').html(_this.flipBackTempalate({ data: { title: _this.titleHashTag, description: _this.descriptionHashTag } }));
        });
    };
    YourBrandsStoryContainer.prototype.renderRandomly = function () {
        var posToRender = -1;
        var attempt = 0;
        while (posToRender === -1 || posToRender === this.recentRenderedPos) {
            if (attempt > 10)
                break;
            posToRender = _.random(this.instaImgStart, this.instaImgVisisble);
            attempt++;
        }
        var feedToRenderIndex = -1;
        while (feedToRenderIndex === -1 || this.visibleRenderedFeedsIndex.indexOf(feedToRenderIndex) !== -1) {
            feedToRenderIndex = _.random(this.instaImgStart, this.instaFeeds.length - 1);
        }
        $($('.insta-feed-item:visible').get(posToRender)).css("background-image", "url(" + this.instaFeeds[feedToRenderIndex].image + ")");
        $($('.insta-feed-item:visible').get(posToRender)).attr({ 'data-mfp-src': this.instaFeeds[feedToRenderIndex].url });
        this.visibleRenderedFeedsIndex.push(feedToRenderIndex);
        if (this.visibleRenderedFeedsIndex.length > 6) {
            this.visibleRenderedFeedsIndex.shift();
        }
        this.recentRenderedPos = posToRender;
    };
    return YourBrandsStoryContainer;
}());
exports.YourBrandsStoryContainer = YourBrandsStoryContainer;
new YourBrandsStoryContainer();
