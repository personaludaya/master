"use strict";
var $ = require('jquery');
var _ = require('underscore');
var shared_1 = require('./shared');
var Swiper = require('swiper');
var VideoPlayer = (function () {
    function VideoPlayer() {
        //{"type":"youtube","vid":"GLylryzTmDs","width":"100%","height":"100%","autoplay":"1"}
        this.loader = new shared_1.Loader();
        this.className = '.campaign-video-player-wrapper';
        this.template = '<iframe src="//about:blank" frameborder="0" allowfullscreen width="100%" height="100%"></iframe>';
        this.patterns = {
            youtube: {
                index: 'youtube',
                id: 'v=',
                src: '//www.youtube.com/embed/%id%?autoplay=1'
            },
            vimeo: {
                index: 'vimeo',
                id: '/',
                src: '//player.vimeo.com/video/%id%?autoplay=1'
            }
        };
        // private loaderWrapper: string = '.campaign-video-player-container .campaign-video-loader';
        this.loaderWrapper = '.campaign-video-loader';
        this.swiperClass = '.js-campaign-video';
        this.swiperPaginationClass = '.swiper-pagination';
        this.swiperPrevClass = '.swiper-prev';
        this.swiperNextClass = '.swiper-next';
        this.initPlayer();
    }
    VideoPlayer.prototype.initPlayer = function () {
        var _this = this;
        $(document).ready(function () {
            $(_this.className).each(function (index, player) {
                $(player).on('click', function () {
                    _this.play(player);
                });
                // reinit video icon
                var iconHeight = Math.max.apply(null, $(player).find('.background-container').map(function (index, colItem) { return $(colItem).height(); }).get());
                $(player).find('.background-container .play-icon').css('top', (iconHeight - $(player).find('.background-container .play-icon').height()) / 2);
            });
            $(_this.swiperClass).each(function (index, swiper) {
                if ($(swiper).find('.swiper-slide').length > 1) {
                    new Swiper(swiper, {
                        loop: false,
                        pagination: _this.swiperClass + ' .swiper-pagination',
                        nextButton: _this.swiperClass + ' .swiper-next',
                        prevButton: _this.swiperClass + ' .swiper-prev',
                        slidesPerView: 1,
                        paginationClickable: true,
                        spaceBetween: 0,
                        onSlideChangeEnd: function (swiper) {
                            if (window['brands'].tracker) {
                                window['brands'].tracker.trackCarousel(swiper);
                            }
                        }
                    });
                }
                else {
                    $(swiper).find(_this.swiperPaginationClass).hide();
                    $(swiper).find(_this.swiperPrevClass).hide();
                    $(swiper).find(_this.swiperNextClass).hide();
                }
            });
        });
    };
    VideoPlayer.prototype.play = function (player) {
        var _this = this;
        this.loader.show($(player).parent().find(this.loaderWrapper), true);
        var options = $(player).attr('data-options');
        if (!options)
            return void 0;
        options = JSON.parse(options);
        // options.vid
        // options.name
        if (window['brands'].tracker && options.vid) {
            window['brands'].tracker.trackVideoPlay(options.vid + '|' + options.name);
        }
        var pattern = _.find(this.patterns, function (pattern) {
            return pattern.index == options.type;
        });
        if (!pattern || !options.vid)
            return void 0;
        var embedSrc = '';
        if (typeof options.vid === 'string') {
            embedSrc = options.vid;
        }
        else {
            embedSrc = options.vid.call(this, embedSrc);
        }
        embedSrc = pattern.src.replace('%id%', embedSrc);
        var localTemplate = _.clone(this.template);
        localTemplate = $(localTemplate).attr('src', embedSrc);
        if (options.width) {
            localTemplate = $(localTemplate).attr('width', options.width);
        }
        if (options.height) {
            localTemplate = $(localTemplate).attr('height', options.height);
        }
        $(player).html(localTemplate[0].outerHTML);
        $(player).find('iframe').on('load', function () {
            _this.loader.hide($(player).parent().find(_this.loaderWrapper));
        });
    };
    return VideoPlayer;
}());
exports.VideoPlayer = VideoPlayer;
new VideoPlayer();
