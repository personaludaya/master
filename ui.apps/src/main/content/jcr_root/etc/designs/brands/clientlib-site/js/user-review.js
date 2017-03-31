"use strict";
var $ = require('jquery');
var Swiper = require('swiper');
var UserReview = (function () {
    function UserReview() {
        this.userReviewFeedClassName = '.js-user-review-feed';
        this.initCarouselFeed();
    }
    UserReview.prototype.initCarouselFeed = function () {
        var _this = this;
        $(document).ready(function () {
            new Swiper(_this.userReviewFeedClassName, {
                loop: false,
                pagination: '.swiper-pagination',
                nextButton: '.swiper-next',
                prevButton: '.swiper-prev',
                slidesPerView: 1,
                paginationClickable: true,
                spaceBetween: 0,
                onInit: function (swiper) {
                    for (var i in swiper.slides) {
                        if (i == swiper.activeIndex) {
                            $(swiper.slides[swiper.activeIndex]).css({ left: 0, opacity: 1 });
                        }
                        else {
                            $(swiper.slides[i]).css({ left: (-1440 * 11), opacity: 0 });
                        }
                    }
                },
                onSlideChangeEnd: function (swiper) {
                    for (var i in swiper.slides) {
                        if (i == swiper.activeIndex) {
                            $(swiper.slides[swiper.activeIndex]).css({ left: 0, opacity: 1 });
                        }
                        else {
                            $(swiper.slides[i]).css({ left: (-1440 * 11), opacity: 0 });
                        }
                    }
                    if (window['brands'].tracker) {
                        window['brands'].tracker.trackCarousel(swiper);
                    }
                }
            });
        });
    };
    return UserReview;
}());
exports.UserReview = UserReview;
new UserReview();
