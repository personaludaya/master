/// <reference path="../../dts/declaration.d.ts" />
window['brands'] = {
    mobile_screen: 767,
    tablet_screen: 991,
    anime: {},
    tracker: {},
    icons: {
        loader: '/clientlib-site/images/icons/symbol-defs.svg#icon-loading',
        close: '/clientlib-site/images/icons/symbol-defs.svg#icon-close',
        arrowUp: '/clientlib-site/images/icons/symbol-defs.svg#icon-arrow-up',
        arrowDown: '/clientlib-site/images/icons/symbol-defs.svg#icon-arrow-down'
    },
    locale: {},
    chatbot: {}
};
var isMinificationRequired = (typeof isMinified != 'undefined') ? isMinified : false;
// window['brands'].locale.en['some-text'] = 'some text';
System.config({
    baseURL: baseUrl,
    packages: {
        'shared': {
            defaultExtension: (isMinificationRequired ? 'min.js' : 'js'),
            main: 'shared'
        },
        'partials': {
            defaultExtension: (isMinificationRequired ? 'min.js' : 'js')
        }
    },
    paths: {
        'vendors/*.js': 'vendors/*.js',
        '*.js': '*.' + (isMinificationRequired ? 'min.js' : 'js')
    },
    map: {
        jquery: 'vendors/jquery.min.js',
        bootstrap: 'vendors/bootstrap.min.js',
        slick: 'vendors/slick.min.js',
        swiper: 'vendors/swiper.min.js',
        svgxuse: 'vendors/svgxuse.min.js',
        skrollr: 'vendors/skrollr.min.js',
        raphael: 'vendors/raphael.min.js',
        lazyloadxt_main: 'vendors/jquery.lazyloadxt.srcset.min.js',
        lazyloadxt_core: 'vendors/jquery.lazyloadxt.min.js',
        lazyloadxt: 'vendors/jquery.lazyloadxt.bg.min.js',
        underscore: (isMinificationRequired ? 'vendors/underscore.min.js' : 'vendors/underscore.js'),
        'jquery.cookie': (isMinificationRequired ? 'vendors/jquery.cookie.min.js' : 'vendors/jquery.cookie.js'),
        retinajs: 'vendors/retina.min.js',
        'api.ai': 'vendors/ApiAi.min.js',
        'jquery.visible': 'vendors/jquery.visible.min.js',
        'jquery.typist': 'vendors/jquery.typist.min.js',
        'typed.js': 'vendors/typed.min.js',
        fs: '@empty',
        intlTelInput: 'vendors/intlTelInput.min.js',
        intlTelInputUtils: (isMinificationRequired ? 'vendors/utils.min.js' : 'vendors/utils.js'),
        'magnific-popup': 'vendors/jquery.magnific-popup.min.js',
        'jquery.scrollTo': 'vendors/jquery.scrollTo-1.4.2-min.js',
        'jquery.parallax': (isMinificationRequired ? 'vendors/jquery.parallax-1.1.3.min.js' : 'vendors/jquery.parallax-1.1.3.js'),
        'jquery.localscroll': 'vendors/jquery.localscroll-1.2.7-min.js',
        'parallax.js': 'vendors/parallax.min.js',
        'ScrollMagic': 'vendors/ScrollMagic.min.js',
        'animation.gsap.min.js': 'vendors/animation.gsap.min.js',
        'TweenMax': 'vendors/TweenMax.min.js',
        'TimelineMax': 'vendors/TimelineMax.min.js',
        'TweenLite': 'vendors/TweenLite.min.js',
        'bootstrap.floating-label': (isMinificationRequired ? 'vendors/floating-labels.min.js' : 'vendors/floating-labels.js'),
        'amplify': 'vendors/amplify.store.min.js',
        'faq-container-partial': 'partials/faq-container-partial',
        'chatbot-product-info-partial': 'partials/chatbot-product-info-partial',
        'product-container-partial': 'partials/product-container-partial',
        'product-comparison-item-partial': 'partials/product-comparison-item-partial'
    },
    meta: {
        // 'jquery': {
        //   'format': 'global'
        // },
        'vendors/*': {
            deps: [
                'jquery'
            ]
        },
        // '*': {
        //   deps: [
        //     'jquery',
        //     'analytics.js'
        //   ]
        // },
        // 'jquery': {
        //   'format': 'global'
        // },
        // 'analytics.js': {
        //   deps: [
        //     'jquery'
        //   ]
        // },
        'lazyloadxt_main': {
            deps: [
                'lazyloadxt_core'
            ]
        },
        'lazyloadxt': {
            deps: [
                'lazyloadxt_main'
            ]
        },
        'intlTelInput': {
            deps: [
                'intlTelInputUtils'
            ]
        },
        'jquery.localscroll': {
            deps: [
                'bootstrap'
            ]
        },
        'jquery.parallax': {
            deps: [
                'jquery.localscroll'
            ]
        },
        'jquery.scrollTo': {
            deps: [
                'jquery.parallax'
            ]
        },
        'bootstrap.floating-label': {
            deps: [
                'bootstrap'
            ]
        },
        'retinajs': {
            'format': 'global'
        },
        'skrollr': {
            'format': 'global'
        },
        'ScrollMagic': {
            deps: [
                'animation.gsap.min.js'
            ],
            'format': 'global'
        },
        'partials/*': {
            'format': 'global'
        },
        'footer.js': {
            deps: [
                'retinajs',
                'jquery.scrollTo',
                'jquery.cookie',
                'analytics.js'
            ]
        },
        'header.js': {
            deps: [
                'jquery.cookie',
                'analytics.js'
            ]
        },
        'home.js': {
            deps: [
                'jquery.cookie',
                'analytics.js',
                'ux.ui.fancy-animation.js'
            ]
        },
        'shared.js': {
            deps: [
                'analytics.js'
            ]
        },
        'be-magazine-container.js': {
            deps: [
                'analytics.js'
            ]
        },
        'be-magazine-landing.js': {
            deps: [
                'analytics.js'
            ]
        },
        'be-magazine-listing.js': {
            deps: [
                'analytics.js'
            ]
        },
        'campaign.js': {
            deps: [
                'analytics.js'
            ]
        },
        'chatbot-container.js': {
            deps: [
                'analytics.js'
            ]
        },
        'compare-products-container.js': {
            deps: [
                'analytics.js'
            ]
        },
        'contest-participant-form-container.js': {
            deps: [
                'analytics.js'
            ]
        },
        'corporate-enquiries.js': {
            deps: [
                'analytics.js'
            ]
        },
        'discover-our-products.js': {
            deps: [
                'analytics.js'
            ]
        },
        'faq.js': {
            deps: [
                'analytics.js'
            ]
        },
        'milestone.js': {
            deps: [
                'analytics.js'
            ]
        },
        'our-product-toolbar-and-container.js': {
            deps: [
                'analytics.js'
            ]
        },
        'popular-products.js': {
            deps: [
                'analytics.js'
            ]
        },
        'product-instruction.js': {
            deps: [
                'analytics.js'
            ]
        },
        'product-manufacturing-process.js': {
            deps: [
                'analytics.js'
            ]
        },
        'product.js': {
            deps: [
                'analytics.js'
            ]
        },
        'user-review.js': {
            deps: [
                'analytics.js'
            ]
        },
        'ux.ui.fancy-animation.js': {
            deps: [
                'analytics.js'
            ]
        },
        'video-player.js': {
            deps: [
                'analytics.js'
            ]
        },
        'your-brands-story-container.js': {
            deps: [
                'analytics.js'
            ]
        }
    }
});
