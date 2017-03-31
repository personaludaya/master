"use strict";
var $ = require('jquery');
var skrollr = require('skrollr');
var _ = require('underscore');
var Raphael = require('raphael');
var UXUIFancyAnime = (function () {
    function UXUIFancyAnime() {
        this.skrollrNodePos = [];
        this.heroCanvas = '.hero-canvas';
        this.leftNavBar = 'leftNavBar';
        this.opacity = 0.3;
        this.leftNavBarOpacity = 0.7;
        this.color = '#fff';
        this.duration = 1000;
        this.startX = 10;
        this.startY = 10;
        this.x = 50;
        this.y = 50;
        this.ANIME_TYPE_HOME_POPULAR_PRODUCT = 'home--popular-product';
        this.MILESTONE_RULER = '.milestone--toolbar';
        this.MILESTONE_POINT_INDICATOR_LIST = [];
        this.MILESTONE_ACTIVE_COLOR = '#FF7800';
        this.init();
    }
    UXUIFancyAnime.prototype.init = function () {
        var _this = this;
        $(document).ready(function () {
            if ($(window).width() > window['brands'].tablet_screen) {
                _this.initHeroCanvas();
            }
            // this.initSkrollrIndicatorForHome();
        });
    };
    UXUIFancyAnime.prototype.initSkrollrIndicatorForHome = function () {
        var _this = this;
        $(".home--screen1, .home--screen2, .home--screen3, .home--screen4, .home--screen5").each(function (index, node) {
            _this.skrollrNodePos.push($(node).offset().top - 300);
        });
        var s = skrollr.init({
            forceHeight: false,
            render: function (data) {
                var index = _.findIndex(_this.skrollrNodePos, function (pos) {
                    return data.curTop == 0 || data.curTop <= pos;
                });
                if (index > -1) {
                    $('.nodes').find('.node').removeClass('active');
                    if (index > 0)
                        index -= 1;
                    $($('.nodes').find('.node').get(index)).addClass('active');
                }
                else {
                    $('.nodes').find('.node').removeClass('active');
                    $('.nodes').find('.node:last-child').addClass('active');
                }
            }
        });
        if (s.isMobile()) {
            s.destroy();
            $('.nodes').remove();
        }
    };
    UXUIFancyAnime.prototype.initHeroCanvas = function () {
        var _this = this;
        if ($(this.heroCanvas).length < 1)
            return void 0;
        var resizeCanvas = function () {
            // let width: number = $(window).attr('innerWidth');
            // let height: number = $(window).attr('innerWidth');
            // $(this.heroCanvas).css('width', width);
            // $(this.heroCanvas).css('height', height);
            // $(this.heroCanvas).attr('width', width);
            // $(this.heroCanvas).attr('height', height);
            _this.MILESTONE_POINT_INDICATOR_LIST = [];
            setTimeout(function () {
                _this.drawOnCanvas();
            }, 1);
        };
        $(window).on('resize', resizeCanvas);
        // resizeCanvas();
        this.drawOnCanvas();
    };
    UXUIFancyAnime.prototype.drawOnCanvas = function (parentCanvasSelector) {
        var _this = this;
        if (parentCanvasSelector === void 0) { parentCanvasSelector = ''; }
        if ($(window).width() <= window['brands'].tablet_screen) {
            return void 0;
        }
        if (!parentCanvasSelector)
            parentCanvasSelector = 'body';
        $(parentCanvasSelector).find(this.heroCanvas).html('');
        var width = $(parentCanvasSelector).find(this.heroCanvas).width();
        var height = $(parentCanvasSelector).find(this.heroCanvas).height();
        Raphael(function () {
            $(parentCanvasSelector).find(_this.heroCanvas).each(function (index, canvas) {
                var paper = Raphael(canvas);
                var grid = [];
                for (var w = _this.startX; w < width; w += _this.x) {
                    for (var h = _this.startY; h < height; h += _this.y) {
                        paper.rect(w, h, 1, 1).attr({ stroke: _this.color, "stroke-width": 2, opacity: _this.opacity });
                        grid.push({
                            x: w,
                            y: h
                        });
                    }
                }
                _this.drawSimplifiedDots(paper, grid);
                _this.drawLeftNavBar(paper, grid);
                _this.drawMilestoneRuler(paper, grid);
                var occupiedCoordinates = [];
                if ($(paper.canvas).parent().attr('data-anime-type') == _this.ANIME_TYPE_HOME_POPULAR_PRODUCT) {
                    var maxBoxesOnRight = 3;
                    var maxBoxesOnLeft = 3;
                    var orgX_1 = (($(window).width() * index) - $(paper.canvas).parent().parent().find('.product-info-image').offset().left);
                    var orgY_1 = ($(paper.canvas).parent().parent().find('.product-info-image').offset().top - $(paper.canvas).parent().parent().find('.product-info-image').height());
                    var idx = _.findIndex(grid, function (g) {
                        return g.x >= orgX_1 && g.y >= orgY_1;
                    });
                    var stepY = -1;
                    for (var i = 0; i < maxBoxesOnRight; i++) {
                        if (grid[idx - i] && grid[(idx - i) + stepY]) {
                            occupiedCoordinates.push({
                                x: grid[idx - i].x + (_this.x * i),
                                y: grid[(idx - i) + stepY].y - (_this.y * i)
                            });
                        }
                    }
                    for (var i = 0; i < maxBoxesOnLeft; i++) {
                        if (grid[idx - i] && grid[(idx - i) + stepY]) {
                            occupiedCoordinates.push({
                                x: (grid[idx - i].x - $(paper.canvas).parent().parent().find('.product-info-image').width() - (_this.x * i)),
                                y: grid[(idx - i) + stepY].y - (_this.y * i)
                            });
                        }
                    }
                }
                _this.drawFancyBoxes(paper, grid, occupiedCoordinates);
            });
        });
    };
    UXUIFancyAnime.prototype.drawSimplifiedDots = function (paper, grid) {
        var _this = this;
        if ($(window).width() <= window['brands'].mobile_screen)
            return void 0;
        var minGap = 100;
        // let containerX: number = _.random(10, $(this.heroCanvas).width()-10) - minGap;
        // let containerY: number = _.random(10, 200);
        var totalCircle = 6;
        var totalLinePerCircle = 3;
        var totalBoundaryPoints = 3;
        var totalInnerPoints = 6;
        // let container: any = paper.rect(containerX, containerY, 300, 300).attr({
        //   stroke: 'none'
        // });
        var circlegrp = paper.set();
        var matrix = [];
        var withinX = 300;
        var withinY = 300;
        // let gridStartingIndex: number = _.random(0, grid.length);
        var width = $(this.heroCanvas).width();
        var height = $(window).height();
        var stablePosX = (width / 2);
        var stablePosY = withinY;
        var startingCoor = _.chain(grid)
            .shuffle()
            .find(function (g) {
            return g.x >= stablePosX && g.y <= stablePosY;
        }).value();
        var circlePoints = [];
        circlePoints.push(startingCoor);
        circlePoints.push({
            x: (startingCoor.x + withinX / 2),
            y: (startingCoor.y + withinY)
        });
        circlePoints.push({
            x: (startingCoor.x + withinX),
            y: (startingCoor.y / 1.5)
        });
        circlePoints.push({
            x: (startingCoor.x),
            y: (startingCoor.y + withinY / 2)
        });
        circlePoints.push({
            x: (startingCoor.x + withinX),
            y: (startingCoor.y + withinY)
        });
        circlePoints.push({
            x: (startingCoor.x + withinX / 2),
            y: (startingCoor.y + withinY / 2)
        });
        circlePoints.push({
            x: (startingCoor.x),
            y: (startingCoor.y)
        });
        circlePoints.push({
            x: (startingCoor.x + withinX),
            y: (startingCoor.y / 1.5)
        });
        circlePoints.push({
            x: (startingCoor.x + withinX * 2),
            y: (startingCoor.y + withinY / 3)
        });
        // old pattern below. dont remove
        // circlePoints.push(startingCoor);
        // circlePoints.push({
        //   x: (startingCoor.x),
        //   y: (startingCoor.y + withinY)
        // });
        // circlePoints.push({
        //   x: (startingCoor.x + withinX),
        //   y: (startingCoor.y)
        // });
        // circlePoints.push({
        //   x: (startingCoor.x),
        //   y: (startingCoor.y + withinY/2)
        // });
        // circlePoints.push({
        //   x: (startingCoor.x + withinX),
        //   y: (startingCoor.y + withinY)
        // });
        // circlePoints.push({
        //   x: (startingCoor.x + withinX/2),
        //   y: (startingCoor.y + withinY/2)
        // });
        // circlePoints.push({
        //   x: (startingCoor.x),
        //   y: (startingCoor.y)
        // });
        // circlePoints.push({
        //   x: (startingCoor.x + withinX),
        //   y: (startingCoor.y)
        // });
        var circleAttr = {
            'stroke': this.color,
            'stroke-width': 1,
            'stroke-opacity': this.opacity,
            'fill': this.color,
            'fill-rule': 'evenodd',
            'opacity': this.opacity,
            'name': 'circlegrp'
        };
        var lineAttr = {
            stroke: this.color,
            "stroke-linecap": 'square',
            "stroke-width": 1,
            fill: this.color,
            "fill-rule": 'evenodd',
            opacity: this.opacity,
            'stroke-opacity': this.opacity + 0.5
        };
        var draw = function (circlePointIndex, drawLineOnly) {
            if (!circlePoints[circlePointIndex])
                return void 0;
            var circlePoint = circlePoints[circlePointIndex];
            var nextCirclePoint = circlePoints[circlePointIndex + 1];
            var noMoreCirclePoint = !nextCirclePoint;
            if (noMoreCirclePoint) {
            }
            if (!drawLineOnly) {
                paper
                    .circle(circlePoint.x, circlePoint.y, 4)
                    .attr(circleAttr);
            }
            if (nextCirclePoint) {
                paper
                    .path("M" + circlePoint.x + " " + circlePoint.y)
                    .attr(lineAttr)
                    .animate({
                    // path: "M10 10 L60 10"
                    path: "M" + circlePoint.x + " " + circlePoint.y + " L" + nextCirclePoint.x + " " + nextCirclePoint.y
                }, _this.duration * 2, function () {
                    if (!noMoreCirclePoint) {
                        draw(circlePointIndex + 1, drawLineOnly);
                    }
                });
            }
        };
        draw(0, false);
        // circlegrp.attr({
        //   id: 'circlegrp',
        //   'stroke': this.color,
        //   'stroke-width': 1,
        //   'stroke-opacity': this.opacity,
        //   'fill': this.color,
        //   'fill-rule': 'evenodd',
        //   'opacity': this.opacity,
        //   'name': 'circlegrp'
        // });
    };
    UXUIFancyAnime.prototype.drawLeftNavBar = function (paper, grid) {
        var _this = this;
        if ($(paper.canvas).parent().attr('data-anime-type') != this.ANIME_TYPE_HOME_POPULAR_PRODUCT || $(window).width() <= window['brands'].mobile_screen)
            return void 0;
        var startY = paper.height / 2 - 27;
        var endY = startY;
        var startX = 0;
        var endX = startX + 300 + this.startX;
        // dont draw border line for tablet because we don't have enough space
        if ($(window).width() > window['brands'].tablet_screen) {
            var line = paper.path("M" + startX + " " + startY + "L" + endX + " " + endY).attr({
                stroke: this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                fill: this.color,
                "fill-rule": 'evenodd',
                opacity: this.leftNavBarOpacity,
                'stroke-opacity': this.leftNavBarOpacity
            });
            paper.rect(endX - 5, endY - 5, 10, 10).attr({
                stroke: this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                // fill: this.color,
                "fill-rule": 'evenodd',
                opacity: this.leftNavBarOpacity,
                'stroke-opacity': this.leftNavBarOpacity
            });
            paper.rect(endX - 2, endY - 2, 3, 3).attr({
                stroke: this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                fill: this.color,
                "fill-rule": 'evenodd',
                opacity: this.leftNavBarOpacity,
                'stroke-opacity': this.leftNavBarOpacity
            });
            endY = startY + $('.leftNavBar').height() / 2 + 50; // 250
            startX = endX;
            endX = startX;
            var line1 = paper.path("M" + startX + " " + startY + "L" + endX + " " + endY).attr({
                stroke: this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                fill: this.color,
                "fill-rule": 'evenodd',
                opacity: this.leftNavBarOpacity,
                'stroke-opacity': this.leftNavBarOpacity
            });
            paper.rect(endX - 1, endY, 3, 3).attr({
                stroke: this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                fill: this.color,
                "fill-rule": 'evenodd',
                opacity: this.leftNavBarOpacity,
                'stroke-opacity': this.leftNavBarOpacity
            });
            startY = startY + $('.leftNavBar').height() + 50;
            endY = startY;
            startX = 0;
            endX = startX + 150 + this.startX;
            var line2 = paper.path("M" + startX + " " + startY + "L" + endX + " " + endY).attr({
                stroke: this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                fill: this.color,
                "fill-rule": 'evenodd',
                opacity: this.leftNavBarOpacity,
                'stroke-opacity': this.leftNavBarOpacity
            });
        }
        var idx = _.findIndex(grid, function (g) {
            return g.x >= endX && g.y >= (endY - _this.y);
        });
        if (idx > -1) {
            var occupiedCoordinates = [];
            var orgX = grid[idx].x + this.x;
            for (var i = 0; i < 3; i++) {
                if (grid[idx]) {
                    occupiedCoordinates.push({
                        x: orgX + (this.x * i),
                        y: grid[idx].y - (this.y * i)
                    });
                }
            }
            this.drawFancyBoxes(paper, grid, occupiedCoordinates);
        }
        var numberOfShortLines = $('.leftNavBar').find('li').length;
        startY = (paper.height / 2 - 27) + 5 + ($('.leftNavBar').find('h5').height() * 3);
        var drawShortLines = function (startX, startY, endX, endY, index) {
            var shortLines = paper
                .path("M" + startX + " " + startY)
                .attr({
                stroke: _this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                fill: _this.color,
                "fill-rule": 'evenodd',
                opacity: 0,
                'stroke-opacity': 0
            })
                .animate({
                path: "M" + startX + " " + startY + "L" + endX + " " + endY,
                opacity: _this.leftNavBarOpacity, 'stroke-opacity': _this.leftNavBarOpacity
            }, _this.duration);
            setTimeout(function () {
                if ($('.leftNavBar').find('h5').css('opacity') == 0) {
                    shortLines.remove();
                    drawShortLines(startX, startY, endX, endY, index);
                }
            }, _this.duration);
        };
        // for(let i=0;i<numberOfShortLines;i++) {
        //   endY = startY;
        //   startX = 0;
        //   endX = startX + 45;
        //   drawShortLines(startX, startY, endX, endY, i);
        //   startY = startY + 35;
        // }
        var leftNavBarLines = [];
        var drawLine = function (startX, startY, endX, endY, index) {
            var attrs = {
                stroke: _this.color,
                "stroke-linecap": 'square',
                "stroke-width": 1,
                fill: _this.color,
                "fill-rule": 'evenodd',
                opacity: 0,
                'stroke-opacity': 0
            };
            var animeAttrs = {
                path: "M" + startX + " " + startY + "L" + endX + " " + endY,
                opacity: _this.leftNavBarOpacity, 'stroke-opacity': _this.leftNavBarOpacity
            };
            var line = paper
                .path("M" + startX + " " + startY)
                .attr(attrs)
                .animate(animeAttrs, _this.duration, function () {
                // $($('.leftNavBar').find('li').get(index)).animate({ opacity: 1}, this.duration);
                if (index + 1 < numberOfShortLines) {
                    startY = startY + 35;
                    endY = startY;
                    drawLine(startX, startY, endX, endY, index + 1);
                }
            });
            leftNavBarLines.push(line);
        };
        var drawLinesOneByOne = function () {
            setTimeout(function () {
                if ($('.leftNavBar').find('h5').css('opacity') > 0) {
                    // start drawing from li(0)
                    var index = 0;
                    endY = startY;
                    startX = 0;
                    endX = startX + 45;
                    drawLine(startX, startY, endX, endY, index);
                }
                else {
                    drawLinesOneByOne();
                }
            }, _this.duration / 3);
        };
        drawLinesOneByOne();
    };
    UXUIFancyAnime.prototype.drawFancyBoxes = function (paper, grid, occupiedCoordinates) {
        var _this = this;
        if (!occupiedCoordinates)
            occupiedCoordinates = [];
        // if($(paper.canvas).parent().attr('data-anime-type') != this.ANIME_TYPE_HOME_POPULAR_PRODUCT) return void 0;
        var totalBoxes = 3;
        var width = 50;
        var height = 50;
        var drawStaticBoxes = false;
        var fancyBoxOpacity = 0.1;
        var containerX = _.random(10, $(this.heroCanvas).width());
        var containerY = _.random(10, $(this.heroCanvas).height());
        if (containerY < 250)
            containerY += 250;
        var pathAttr = {
            stroke: this.color,
            "stroke-linecap": 'square',
            "stroke-width": 1,
            fill: this.color,
            "fill-rule": 'evenodd',
            opacity: 0.5,
            'stroke-opacity': 0.5
        };
        // draw dynamic boxes
        if (occupiedCoordinates.length < 1) {
            // let container: any = paper.rect(containerX, containerY, $(this.heroCanvas).width(), $(this.heroCanvas).height()).attr({
            //   stroke: 'none',
            // });
            var maxFindToBreak = 10;
            for (var i = 0; i < totalBoxes; i++) {
                var gridIndex = _.random(0, grid.length);
                // let success: boolean = false;
                // let x: number = 0;
                // let y: number = 0;
                // let count = 0;
                // while(!success) {
                //   if(count > maxFindToBreak) {
                //     break;
                //   }
                //   x = _.random(0, container.attrs.x);
                //   y = _.random(0, container.attrs.y);
                //   let index = _.findIndex(occupiedCoordinates, (coor: any): any => {
                //     // return (coor.x < x && (coor.x + width) < x) || (coor.y < y && (coor.y + height) < y)
                //     return (x + width) > coor.x && x < (coor.x + width);
                //   });
                //   if(index == -1) {
                //     success = true;
                //   }
                //   count++;
                // }
                // if(success) {
                // paper.rect(x, y, width, height).attr({ fill: this.color, stroke: this.color, "stroke-width": 0, opacity: 0.2 });
                // paper.rect(grid[gridIndex].x, grid[gridIndex].y, width, height).attr({ fill: this.color, stroke: this.color, "stroke-width": 0, opacity: fancyBoxOpacity });
                if (grid[gridIndex]) {
                    occupiedCoordinates.push({
                        x: grid[gridIndex].x,
                        y: grid[gridIndex].y
                    });
                }
            }
        }
        else {
            // draw static boxese
            drawStaticBoxes = true;
        }
        var draw = function (coor) {
            var p1 = paper
                .path("M" + coor.x + " " + coor.y)
                .attr(pathAttr)
                .animate({
                // path: "M10 10 L60 10"
                path: "M" + coor.x + " " + coor.y + " L" + (coor.x + width) + " " + coor.y,
                opacity: 0.8, 'stroke-opacity': 0.8
            }, _this.duration, function () {
                var p2 = paper
                    .path("M" + (coor.x + width) + " " + coor.y)
                    .attr(pathAttr)
                    .animate({ path: "M" + (coor.x + width) + " " + coor.y + " L" + (coor.x + width) + " " + (coor.y + height), opacity: 0.8, 'stroke-opacity': 0.8 }, _this.duration, function () {
                    var p3 = paper
                        .path("M" + (coor.x + width) + " " + (coor.y + height))
                        .attr(pathAttr)
                        .animate({ path: "M" + (coor.x + width) + " " + (coor.y + height) + " L" + coor.x + " " + (coor.y + height), opacity: 0.8, 'stroke-opacity': 0.8 }, _this.duration, function () {
                        var p4 = paper
                            .path("M" + coor.x + " " + (coor.y + height))
                            .attr(pathAttr)
                            .animate({ path: "M" + coor.x + " " + (coor.y + height) + " L" + coor.x + " " + coor.y, opacity: 0.8, 'stroke-opacity': 0.8 }, _this.duration);
                        setTimeout(function () {
                            p4.remove();
                            p3.remove();
                            p2.remove();
                            p1.remove();
                            draw(coor);
                        }, 1000);
                    });
                });
            });
        };
        var drawBoxes = function (coor, count) {
            var rect1 = paper
                .rect(coor.x, coor.y, width, height)
                .attr({ fill: _this.color, stroke: _this.color, "stroke-width": 0, opacity: 0 })
                .animate({ opacity: 0.1 }, (drawStaticBoxes ? (_this.duration * (count) * 2) : _this.duration), function () { if (drawStaticBoxes) {
                rect1.remove();
                drawBoxes(coor, count);
            } });
            // if(drawStaticBoxes) {
            // animate
            // setTimeout(() => { drawBoxes(coor, count) }, (this.duration*2) * count);
            // }
        };
        var count = 1;
        for (var _i = 0, occupiedCoordinates_1 = occupiedCoordinates; _i < occupiedCoordinates_1.length; _i++) {
            var coor = occupiedCoordinates_1[_i];
            // if(drawStaticBoxes) {
            //   paper.rect(coor.x, coor.y, width, height).attr({ fill: this.color, stroke: this.color, "stroke-width": 0, opacity: fancyBoxOpacity });
            // }
            drawBoxes(coor, count);
            count++;
        }
    };
    UXUIFancyAnime.prototype.drawMilestoneRuler = function (paper, grid) {
        if ($(this.MILESTONE_RULER).length < 1 || this.MILESTONE_POINT_INDICATOR_LIST.length > 0)
            return void 0;
        var __this = this;
        var x = 0;
        var y = $(this.MILESTONE_RULER).offset().top - ($(window).width() <= window['brands'].mobile_screen ? 120 : 70);
        var width = $(this.heroCanvas).width();
        var toolbarItemList = [];
        var activeToolbarIndex = -1;
        $(this.MILESTONE_RULER).find('li').each(function (index, item) {
            // toolbarItemList.push(($(item).offset().left + $(item).width())/ 1.5);
            if ($(item).hasClass('active'))
                activeToolbarIndex = index;
            toolbarItemList.push(($(item).offset().left + ($(item).width() / 2) - (index)));
        });
        var pathAttr = {
            stroke: this.color,
            "stroke-linecap": 'square',
            "stroke-width": 1,
            fill: this.color,
            "fill-rule": 'evenodd',
            opacity: 1,
            'stroke-opacity': 1
        };
        if ($(window).width() <= window['brands'].mobile_screen) {
            x = $('.swiper-milestone-prev').offset().left + $('.swiper-milestone-prev').width() * 2;
            width = $('.swiper-milestone-next').offset().left + $('.swiper-milestone-next').width() * 0.2;
        }
        paper
            .path("M" + x + " " + y + ' L' + width + ' ' + y)
            .attr(pathAttr);
        var tbIndex = 0;
        var _loop_1 = function(i) {
            var isMilestonePointIndicator = false;
            var endY = y + 25;
            pathAttr.stroke = this_1.color;
            pathAttr["stroke-width"] = 1;
            pathAttr["opacity"] = 1;
            if ($(window).width() <= window['brands'].mobile_screen &&
                (i < ($('.swiper-milestone-prev').offset().left + $('.swiper-milestone-prev').width() * 2) ||
                    (i > ($('.swiper-milestone-next').offset().left + $('.swiper-milestone-next').width() * 0.2)))) {
                pathAttr["opacity"] = 0.3;
            }
            if (_.findIndex(toolbarItemList, function (item) {
                return (item + 5) <= i && (item - 5) <= i;
                // return (item+5) >= i && (item-5) >= i;
            }) > -1) {
                if (tbIndex == activeToolbarIndex) {
                    pathAttr.stroke = this_1.MILESTONE_ACTIVE_COLOR;
                    pathAttr["stroke-width"] = 2;
                }
                endY = y + 35;
                toolbarItemList.splice(0, 1);
                tbIndex++;
                isMilestonePointIndicator = true;
            }
            var path = paper
                .path("M" + i + " " + (y + 5) + ' L' + i + ' ' + endY)
                .attr(pathAttr);
            if (isMilestonePointIndicator) {
                __this.MILESTONE_POINT_INDICATOR_LIST.push(path);
            }
        };
        var this_1 = this;
        for (var i = 0; i < width; i += 5) {
            _loop_1(i);
        }
    };
    UXUIFancyAnime.prototype.changeActiveMilestonePointIndicator = function (index) {
        // if(index < 0 || index > this.MILESTONE_POINT_INDICATOR_LIST.length || !this.MILESTONE_POINT_INDICATOR_LIST[index]) return void 0;
        for (var i = 0; i < this.MILESTONE_POINT_INDICATOR_LIST.length; i++) {
            this.MILESTONE_POINT_INDICATOR_LIST[i]
                .attr({
                stroke: (index == i ? this.MILESTONE_ACTIVE_COLOR : this.color),
                "stroke-width": 2
            });
        }
    };
    return UXUIFancyAnime;
}());
window['brands'].anime = new UXUIFancyAnime();
