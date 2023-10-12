/**
 * 
 */
/**
 * 
 */

 
$(document).ready(function(){

	fnSetTagList();

	// 검색
	$("#btn_total_search").click(function(){

		fnSearch();
	});

	$("#total_search").keyup(function(e){

		if(e.keyCode === 13){
			fnSearch();
		}
	});

	$("#frmTour input:checkbox").click(function(e){

		var chkName = $(this).attr("name");
		var idx = chkName.indexOf("_");
		chkName = chkName.substring(0, idx);

		$("input[name^="+chkName+"]").not(this).prop("checked", false);
	});


});

$(document).on("click", ".main_tag .more", function(){

	$("#section_main_tag").addClass("all");
});

$(document).on("click", ".main_tag .close", function(){

	$("#section_main_tag").removeClass("all");
});

//검색
function fnSearch(){

	if(gfn_chkNvl($("#total_search").val())){
		alert("검색어를 입력해 주세요.");
		$("#total_search").focus();
		return;
	}

	if($("#total_search").val().length<2){
		alert("2글자이상 입력해주세요");
		$("#total_search").focus();
		return;
	}	
	
	if($("#total_search").val().length>20){
		alert("20글자까지만 검색할 수 있습니다. ");
		$("#total_search").focus();
		return;
	}	
	/*if($("#ipt_intgrfind_kword").val().indexOf("script") != -1){
		alert("잘못된 검색어입니다.");
		$("#ipt_intgrfind_kword").focus();
		return;
	}*/	
	if(!checkUID($("#total_search").val())){
		alert("특수문자는 사용할수 없습니다.");
		$("#total_search").val("");
		$("#total_search").focus();
		return;
	}	
	$("#frmSearch").submit();
}

//태그 세팅
function fnSetTagList(){
	if(gfn_chkNvl(tagListJson) || tagListJson.length < 1){
		return;
	}

	var h2Text = '<h2 class="blind">인기 태그</h2>';
	var btnMoreText = '<button type="button" class="link more"><span class="blind">목록 더보기</span></button>';
	var htmlText = '';

	var delaySec = 20;
	var delayInc = 20;
	var isBreak = false;

	$.each(tagListJson, function(idx, ref){

		if(isBreak){
			return false;
		}

		setTimeout(function(){

			if(!isBreak){

				htmlText += '<a href="/intgrfind/list.do?ipt_intgrfind_kword='+ref+'" class="link">#'+ref+'</a>';

				$("#section_main_tag_temp").html(h2Text + htmlText + btnMoreText);
				console.log(h2Text + htmlText + btnMoreText);
			}

		}, delaySec);

		delaySec += delayInc;

		setTimeout(function(){

			if(!isBreak){

				var mainTagHeight = $("#section_main_tag_temp").height();

				if(mainTagHeight > 140){
					fnDrawTag(idx - 2);
					isBreak = true;
				}
			}

		}, delaySec);

		delaySec += delayInc;
	});
}

function fnDrawTag(cnt){

	if(cnt < 1){
		return;
	}

	var h2Text = '<h2 class="blind">인기 태그</h2>';
	var btnMoreText = '<button type="button" class="link more"><span class="blind">목록 더보기</span></button>';
	var htmlText = '';

	htmlText = h2Text;

	$.each(tagListJson, function(idx, ref){

		htmlText += '<a href="/intgrfind/list.do?ipt_intgrfind_kword='+ref+'" class="link">#'+ref+'</a>';

		if(idx == cnt){
			htmlText += btnMoreText;
		}
	});

	htmlText += '<button type="button" class="link close"><span class="blind">목록 축소하기</span></button>';

	$("#section_main_tag").html(htmlText);
	$("#section_main_tag").removeClass("all");

}



/* 풋터 연관사이트  */
$(function(){
    $(".footer_site .btn").on('click',function(event){
        $(this).siblings(".list").addClass('active');
        $(".footer_site .list a").removeAttr("tabindex");
        $(".footer_site .list a").attr("tabindex","0");
    });
    $(".footer_site").on('mouseleave',function(event){
        $(".footer_site .list").removeClass('active');
        $(".footer_site .list a").removeAttr("tabindex");
        $(".footer_site .list a").attr("tabindex","-1");
    });
});

$(function(){
    //상단이동
    var top_move_btn = $(".footer .goto_top");
    top_move_btn.click(function(){
        $("html, body").animate({scrollTop : 0},400);
    });
});

$(function(){
    $viewPhotos = $(".view .photos");
    $viewPhotos_list = $viewPhotos.find(".list");
    $viewPhotos_paging = $viewPhotos.find(".paging");
    $viewPhotos_list.on('init reInit afterChange', function (event, slick, currentSlide, nextSlide) {
        var i = (currentSlide ? currentSlide : 0) + 1;
        $viewPhotos_paging.text(i + ' / ' + slick.slideCount);
    });

    $viewPhotos_list.slick({
        infinite: true,
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        autoplay:false,
        autoplaySpeed: 5000,
        fade: false,
        draggable: false,
        dots: false,
        responsive: [
            {

            },

        ]
    });
});

$(function(){
    $('.near_tab').on('click', 'a', function(e) {
        e.preventDefault ();
        var target = $(this).attr("href");
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
        $(".near_wrap .tab_body").removeClass('active');
        $(target).addClass('active');

    });
});


function copyUrl(){
    var obj = document.getElementById("url");
    var range = document.createRange();
    range.selectNode(obj.childNodes[0]);
    var sel = window.getSelection();
    sel.removeAllRanges(); //기존 선택정보 삭제
    sel.addRange(range); //텍스트 정보 선택
    document.execCommand("copy");
    try {
        var successful = document.execCommand('copy');
        var msg = successful ? '성공' : '실패';
        if(successful){
            alert("URL 복사가 되었습니다.");
        }

    } catch(err) {
        alert("URL 복사가 되지 않았습니다.");
    }

}

function gallerySlide(total){
    $gallery_list = $(".slider-for");
    $gallery_list.slick({
        infinite: true,
        slidesToShow: total,
        slidesToScroll: 1,
        arrows: true,
        //autoplay:true,
        //autoplaySpeed: 5000,
        fade: false,
        draggable: false,
        dots: false,
        centerMode:true,
        variableWidth: true,
        asNavFor: '.slider-nav'
    });

    $thumbnail_list = $(".slider-nav");
    $thumbnail_list.slick({
        infinite: true,
        slidesToShow: total,
        slidesToScroll: 1,
        arrows: false,
        //autoplay:true,
        //autoplaySpeed: 5000,
        fade: false,
        draggable: false,
        dots: false,
        centerMode:true,
        variableWidth: true,
        asNavFor: '.slider-for',
        focusOnSelect: true,
    });
}

$(function(){
    $gnbPopup = $(".gnb_popup");
    $gnbPopup_list = $gnbPopup.find(".list");
    $gnbPopup_list.slick({
        infinite: true,
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        autoplay:true,
        autoplaySpeed: 5000,
        fade: true,
        draggable: false,
        dots: false,
    });
    $gnbPopup.find(".close").on("click",function(){
       // $gnbPopup.slideUp();
        $gnbPopup.addClass("slideUp");
    });
});


$(function(){
    $visual = $(".main_visual");
    $visual_list = $visual.find(".list");
    $visual_list.slick({
        infinite: true,
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: true,
        autoplay:true,
        autoplaySpeed: 3000,
        fade: false,
        draggable: false,
        dots: true,
    });
    $('.main_visual .pause').on('click', function() {
        $visual_list.slick('slickPause');
        $(this).removeClass("active");
        $(this).removeAttr("tabindex");
        $(this).attr("tabindex","-1");
        $('.main_visual .play').addClass("active");
        $('.main_visual .play').attr("tabindex","0");
    });

    $('.main_visual .play').on('click', function() {
        $visual_list.slick('slickPlay')
        $(this).removeClass("active");
        $(this).removeAttr("tabindex");
        $(this).attr("tabindex","-1");
        $('.main_visual .pause').addClass("active");
        $('.main_visual .pause').attr("tabindex","0");
    });

    $(window).on('orientationchange', function() {
        $('$visual_list').slick('resize');
    });
});

$(function(){
    $popupzone = $(".popupzone");
    $popupzone_list = $popupzone.find(".list");
    var percent;
    $popupzone_list.on('init reInit beforeChange', function(event, slick, currentSlide, nextSlide){
        var calc = ( (nextSlide) / (slick.slideCount-1) ) * 100;
        percent = calc + '%'
        //console.log(percent);
        $(".popupzone .progress .bar").css('width', percent);
    });

    $popupzone_list.on('init reInit afterChange', function(event, slick, currentSlide, nextSlide){
        //currentSlide is undefined on init -- set it to 0 in this case (currentSlide is 0 based)
        var i = (currentSlide ? currentSlide : 0) + 1;
        $popupzone.find(".total").text(slick.slideCount);
        $popupzone.find(".now").text(i);
    });

    $popupzone_list.slick({
        infinite: true,
        slidesToShow: 2,
        slidesToScroll: 1,
        arrows: true,
        variableWidth: true,
        autoplay: true,
        autoplaySpeed: 5000,
        draggable: false,
    });

});


$(function(){
    $sns = $(".main_sns");
    $sns_list = $sns.find(".sns_list");
    $sns_list.slick({
        infinite: true,
        slidesToShow: 7,
        slidesToScroll: 1,
        arrows: true,
        autoplay:true,
        autoplaySpeed: 3000,
        fade: false,
        draggable: false,
        dots: false,
        centerMode:true,
        variableWidth: true,
        responsive: [
            {
                breakpoint: 1670,
                settings: {
                    slidesToShow:6
                }
            },
            {
                breakpoint: 1420,
                settings: {

                    slidesToShow:5
                }
            },
            {
                breakpoint: 1230,
                settings: {

                    slidesToShow:4
                }
            }
        ]
    });
    $('.main_sns .pause').on('click', function() {
        $sns_list.slick('slickPause');
        $(this).removeClass("active");
        $('.main_sns .play').addClass("active")
    });

    $('.main_sns .play').on('click', function() {
        $sns_list.slick('slickPlay')
        $(this).removeClass("active");
        $('.main_sns .pause').addClass("active")
    });
    $sns_list.on('beforeChange', function(e, slick, currentSlide, nextSlide, prevSlide, arrows) {
        var slideCount = slick.$slides.length - 1,
            direc = currentSlide - nextSlide,
            firstSlide = currentSlide - 1,
            lastSlide = firstSlide + 2;

        if(direc === 1 || direc === (slick.slideCount-1)*(-1) ) {
            //prev

            if( currentSlide ===  0){
                //firstSlide = slick.slideCount - 1;
            }
            $('.sns_list .slick-track').addClass('back');

        } else {
            // next
            firstSlide = currentSlide + 1;
            lastSlide = firstSlide + 2;

            if( currentSlide ===  (slick.slideCount-1)) {
                //firstSlide = 0;
            }
            $('.sns_list.slick-track').removeClass('back');
        }
        $('.sns_lists.slick-track').addClass('move'); 
    });
    $sns_list.on('afterChange', function(e, slick, currentSlide, nextSlide ) {
        slick.$slides.removeClass("prevSlide nextSlide");
        $('.slick-cloned').removeClass('prevSlide nextSlide');
        $('.slick-track').removeClass('move');
    });
});


$(function(){
    $movie = $(".movie");
    $movie_list = $movie.find(".list");
    $movie_list.slick({
        infinite: true, //무한반복
        slidesToShow: 2,
        slidesToScroll: 1,
        arrows: true, //좌우버튼
        //autoplay:true,
        //autoplaySpeed: 5000,
        fade: false,
        draggable: false,
        dots: false,
        centerMode:true,
        variableWidth: true,
        focusOnSelect: true,
    });
    $movie_list.on('beforeChange', function(e, slick, currentSlide, nextSlide, prevSlide, arrows) {
        var slideCount = slick.$slides.length - 1,
            direc = currentSlide - nextSlide,
            firstSlide = currentSlide - 1,
            lastSlide = firstSlide + 2;

        if(direc === 1 || direc === (slick.slideCount-1)*(-1) ) {
            //prev

            if( currentSlide ===  0){
                //firstSlide = slick.slideCount - 1;
            }
            $('.slick-track').addClass('back');

        } else {
            // next
            firstSlide = currentSlide + 1;
            lastSlide = firstSlide + 2;

            if( currentSlide ===  (slick.slideCount-1)) {
                //firstSlide = 0;
            }
            $('.slick-track').removeClass('back');
        }
        $('.slick-track').addClass('move');
    });
    $movie_list.on('afterChange', function(e, slick, currentSlide, nextSlide ) {
        slick.$slides.removeClass("prevSlide nextSlide");
        $('.slick-cloned').removeClass('prevSlide nextSlide');
        $('.slick-track').removeClass('move');
    });
});


$(function(){
    $(".main_tag .more").on("click",function(){
        $(".main_tag").addClass("all");
    })
    $(".main_tag .close").on("click",function(){
        $(".main_tag").removeClass("all");
    })
});


$(function(){
    $('.side_banner .close').on('click', function() {
        $('.side_banner').hide();
    });
    $('.side_banner .btn_chat').on('click', function() {
        $('.chat').addClass("active");
    	$(".chat").attr("tabindex", "0");
    	$(".chat a").attr("tabindex", "0");
    	$(".chat .close").attr("tabindex", "0");
    	$(".chat").focus();
		var op = $(this);
		
		   $('.chat .close').on('click', function() {
		        $('.chat').removeClass("active");
		        $(".chat").attr("tabindex", "-1");
		        $(".chat a").attr("tabindex", "-1");
		        $(".chat .close").attr("tabindex", "-1");
		        op.focus();
		    });
    });
 
});

/*
     _ _      _       _
 ___| (_) ___| | __  (_)___
/ __| | |/ __| |/ /  | / __|
\__ \ | | (__|   < _ | \__ \
|___/_|_|\___|_|\_(_)/ |___/
                   |__/

 Version: 1.8.0
  Author: Ken Wheeler
 Website: http://kenwheeler.github.io
    Docs: http://kenwheeler.github.io/slick
    Repo: http://github.com/kenwheeler/slick
  Issues: http://github.com/kenwheeler/slick/issues

 */
/* global window, document, define, jQuery, setInterval, clearInterval */
(function(factory) {
    'use strict';
    if (typeof define === 'function' && define.amd) {
        define(['jquery'], factory);
    } else if (typeof exports !== 'undefined') {
        module.exports = factory(require('jquery'));
    } else {
        factory(jQuery);
    }

}(function($) {
    'use strict';
    var Slick = window.Slick || {};

    Slick = (function() {

        var instanceUid = 0;

        function Slick(element, settings) {

            var _ = this, dataSettings;

            _.defaults = {
                accessibility: true,
                adaptiveHeight: false,
                appendArrows: $(element),
                appendDots: $(element),
                arrows: true,
                asNavFor: null,
                prevArrow: '<button type="button" data-role="none" class="slick-prev" aria-label="Previous" tabindex="0" role="button"></button>',
                nextArrow: '<button type="button" data-role="none" class="slick-next" aria-label="Next" tabindex="0" role="button"><span class="blind">다음 슬라이드 이동</span></button>',
                autoplay: false,
                autoplaySpeed: 3000,
                centerMode: false,
                centerPadding: '50px',
                cssEase: 'ease',
                customPaging: function(slider, i) {
                    return $('<button type="button" data-role="none" role="button" tabindex="0" />').text(i + 1);
                },
                dots: false,
                dotsClass: 'slick-dots',
                draggable: true,
                easing: 'linear',
                edgeFriction: 0.35,
                fade: false,
                focusOnSelect: false,
                infinite: true,
                initialSlide: 0,
                lazyLoad: 'ondemand',
                mobileFirst: false,
                pauseOnHover: true,
                pauseOnFocus: true,
                pauseOnDotsHover: false,
                respondTo: 'window',
                responsive: null,
                rows: 1,
                rtl: false,
                slide: '',
                slidesPerRow: 1,
                slidesToShow: 1,
                slidesToScroll: 1,
                speed: 500,
                swipe: true,
                swipeToSlide: false,
                touchMove: true,
                touchThreshold: 5,
                useCSS: true,
                useTransform: true,
                variableWidth: false,
                vertical: false,
                verticalSwiping: false,
                waitForAnimate: true,
                zIndex: 1000
            };

            _.initials = {
                animating: false,
                dragging: false,
                autoPlayTimer: null,
                currentDirection: 0,
                currentLeft: null,
                currentSlide: 0,
                direction: 1,
                $dots: null,
                listWidth: null,
                listHeight: null,
                loadIndex: 0,
                $nextArrow: null,
                $prevArrow: null,
                slideCount: null,
                slideWidth: null,
                $slideTrack: null,
                $slides: null,
                sliding: false,
                slideOffset: 0,
                swipeLeft: null,
                $list: null,
                touchObject: {},
                transformsEnabled: false,
                unslicked: false
            };

            $.extend(_, _.initials);

            _.activeBreakpoint = null;
            _.animType = null;
            _.animProp = null;
            _.breakpoints = [];
            _.breakpointSettings = [];
            _.cssTransitions = false;
            _.focussed = false;
            _.interrupted = false;
            _.hidden = 'hidden';
            _.paused = true;
            _.positionProp = null;
            _.respondTo = null;
            _.rowCount = 1;
            _.shouldClick = true;
            _.$slider = $(element);
            _.$slidesCache = null;
            _.transformType = null;
            _.transitionType = null;
            _.visibilityChange = 'visibilitychange';
            _.windowWidth = 0;
            _.windowTimer = null;

            dataSettings = $(element).data('slick') || {};

            _.options = $.extend({}, _.defaults, settings, dataSettings);

            _.currentSlide = _.options.initialSlide;

            _.originalSettings = _.options;

            if (typeof document.mozHidden !== 'undefined') {
                _.hidden = 'mozHidden';
                _.visibilityChange = 'mozvisibilitychange';
            } else if (typeof document.webkitHidden !== 'undefined') {
                _.hidden = 'webkitHidden';
                _.visibilityChange = 'webkitvisibilitychange';
            }

            _.autoPlay = $.proxy(_.autoPlay, _);
            _.autoPlayClear = $.proxy(_.autoPlayClear, _);
            _.autoPlayIterator = $.proxy(_.autoPlayIterator, _);
            _.changeSlide = $.proxy(_.changeSlide, _);
            _.clickHandler = $.proxy(_.clickHandler, _);
            _.selectHandler = $.proxy(_.selectHandler, _);
            _.setPosition = $.proxy(_.setPosition, _);
            _.swipeHandler = $.proxy(_.swipeHandler, _);
            _.dragHandler = $.proxy(_.dragHandler, _);
            _.keyHandler = $.proxy(_.keyHandler, _);

            _.instanceUid = instanceUid++;

            // A simple way to check for HTML strings
            // Strict HTML recognition (must start with <)
            // Extracted from jQuery v1.11 source
            _.htmlExpr = /^(?:\s*(<[\w\W]+>)[^>]*)$/;


            _.registerBreakpoints();
            _.init(true);

        }

        return Slick;

    }());

    Slick.prototype.activateADA = function() {
        var _ = this;

        _.$slideTrack.find('.slick-active').attr({
            'aria-hidden': 'false'
        }).find('a, input, button, select').attr({
            'tabindex': '0'
        });

    };

    Slick.prototype.addSlide = Slick.prototype.slickAdd = function(markup, index, addBefore) {

        var _ = this;

        if (typeof(index) === 'boolean') {
            addBefore = index;
            index = null;
        } else if (index < 0 || (index >= _.slideCount)) {
            return false;
        }

        _.unload();

        if (typeof(index) === 'number') {
            if (index === 0 && _.$slides.length === 0) {
                $(markup).appendTo(_.$slideTrack);
            } else if (addBefore) {
                $(markup).insertBefore(_.$slides.eq(index));
            } else {
                $(markup).insertAfter(_.$slides.eq(index));
            }
        } else {
            if (addBefore === true) {
                $(markup).prependTo(_.$slideTrack);
            } else {
                $(markup).appendTo(_.$slideTrack);
            }
        }

        _.$slides = _.$slideTrack.children(this.options.slide);

        _.$slideTrack.children(this.options.slide).detach();

        _.$slideTrack.append(_.$slides);

        _.$slides.each(function(index, element) {
            $(element).attr('data-slick-index', index);
        });

        _.$slidesCache = _.$slides;

        _.reinit();

    };

    Slick.prototype.animateHeight = function() {
        var _ = this;
        if (_.options.slidesToShow === 1 && _.options.adaptiveHeight === true && _.options.vertical === false) {
            var targetHeight = _.$slides.eq(_.currentSlide).outerHeight(true);
            _.$list.animate({
                height: targetHeight
            }, _.options.speed);
        }
    };

    Slick.prototype.animateSlide = function(targetLeft, callback) {

        var animProps = {},
            _ = this;

        _.animateHeight();

        if (_.options.rtl === true && _.options.vertical === false) {
            targetLeft = -targetLeft;
        }
        if (_.transformsEnabled === false) {
            if (_.options.vertical === false) {
                _.$slideTrack.animate({
                    left: targetLeft
                }, _.options.speed, _.options.easing, callback);
            } else {
                _.$slideTrack.animate({
                    top: targetLeft
                }, _.options.speed, _.options.easing, callback);
            }

        } else {

            if (_.cssTransitions === false) {
                if (_.options.rtl === true) {
                    _.currentLeft = -(_.currentLeft);
                }
                $({
                    animStart: _.currentLeft
                }).animate({
                    animStart: targetLeft
                }, {
                    duration: _.options.speed,
                    easing: _.options.easing,
                    step: function(now) {
                        now = Math.ceil(now);
                        if (_.options.vertical === false) {
                            animProps[_.animType] = 'translate(' +
                                now + 'px, 0px)';
                            _.$slideTrack.css(animProps);
                        } else {
                            animProps[_.animType] = 'translate(0px,' +
                                now + 'px)';
                            _.$slideTrack.css(animProps);
                        }
                    },
                    complete: function() {
                        if (callback) {
                            callback.call();
                        }
                    }
                });

            } else {

                _.applyTransition();
                targetLeft = Math.ceil(targetLeft);

                if (_.options.vertical === false) {
                    animProps[_.animType] = 'translate3d(' + targetLeft + 'px, 0px, 0px)';
                } else {
                    animProps[_.animType] = 'translate3d(0px,' + targetLeft + 'px, 0px)';
                }
                _.$slideTrack.css(animProps);

                if (callback) {
                    setTimeout(function() {

                        _.disableTransition();

                        callback.call();
                    }, _.options.speed);
                }

            }

        }

    };

    Slick.prototype.getNavTarget = function() {

        var _ = this,
            asNavFor = _.options.asNavFor;

        if ( asNavFor && asNavFor !== null ) {
            asNavFor = $(asNavFor).not(_.$slider);
        }

        return asNavFor;

    };

    Slick.prototype.asNavFor = function(index) {

        var _ = this,
            asNavFor = _.getNavTarget();

        if ( asNavFor !== null && typeof asNavFor === 'object' ) {
            asNavFor.each(function() {
                var target = $(this).slick('getSlick');
                if(!target.unslicked) {
                    target.slideHandler(index, true);
                }
            });
        }

    };

    Slick.prototype.applyTransition = function(slide) {

        var _ = this,
            transition = {};

        if (_.options.fade === false) {
            transition[_.transitionType] = _.transformType + ' ' + _.options.speed + 'ms ' + _.options.cssEase;
        } else {
            transition[_.transitionType] = 'opacity ' + _.options.speed + 'ms ' + _.options.cssEase;
        }

        if (_.options.fade === false) {
            _.$slideTrack.css(transition);
        } else {
            _.$slides.eq(slide).css(transition);
        }

    };

    Slick.prototype.autoPlay = function() {

        var _ = this;

        _.autoPlayClear();

        if ( _.slideCount > _.options.slidesToShow ) {
            _.autoPlayTimer = setInterval( _.autoPlayIterator, _.options.autoplaySpeed );
        }

    };

    Slick.prototype.autoPlayClear = function() {

        var _ = this;

        if (_.autoPlayTimer) {
            clearInterval(_.autoPlayTimer);
        }

    };

    Slick.prototype.autoPlayIterator = function() {

        var _ = this,
            slideTo = _.currentSlide + _.options.slidesToScroll;

        if ( !_.paused && !_.interrupted && !_.focussed ) {

            if ( _.options.infinite === false ) {

                if ( _.direction === 1 && ( _.currentSlide + 1 ) === ( _.slideCount - 1 )) {
                    _.direction = 0;
                }

                else if ( _.direction === 0 ) {

                    slideTo = _.currentSlide - _.options.slidesToScroll;

                    if ( _.currentSlide - 1 === 0 ) {
                        _.direction = 1;
                    }

                }

            }

            _.slideHandler( slideTo );

        }

    };

    Slick.prototype.buildArrows = function() {

        var _ = this;

        if (_.options.arrows === true ) {

            _.$prevArrow = $(_.options.prevArrow).addClass('slick-arrow');
            _.$nextArrow = $(_.options.nextArrow).addClass('slick-arrow');

            if( _.slideCount > _.options.slidesToShow ) {

                _.$prevArrow.removeClass('slick-hidden').removeAttr('aria-hidden tabindex');
                _.$nextArrow.removeClass('slick-hidden').removeAttr('aria-hidden tabindex');

                if (_.htmlExpr.test(_.options.prevArrow)) {
                    _.$prevArrow.prependTo(_.options.appendArrows);
                }

                if (_.htmlExpr.test(_.options.nextArrow)) {
                    _.$nextArrow.appendTo(_.options.appendArrows);
                }

                if (_.options.infinite !== true) {
                    _.$prevArrow
                        .addClass('slick-disabled')
                        .attr('aria-disabled', 'true');
                }

            } else {

                _.$prevArrow.add( _.$nextArrow )

                    .addClass('slick-hidden')
                    .attr({
                        'aria-disabled': 'true',
                        'tabindex': '-1'
                    });

            }

        }

    };

    Slick.prototype.buildDots = function() {

        var _ = this,
            i, dot;

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

            _.$slider.addClass('slick-dotted');

            dot = $('<ul />').addClass(_.options.dotsClass);

            for (i = 0; i <= _.getDotCount(); i += 1) {
                dot.append($('<li />').append(_.options.customPaging.call(this, _, i)));
            }

            _.$dots = dot.appendTo(_.options.appendDots);

            _.$dots.find('li').first().addClass('slick-active').attr('aria-hidden', 'false');

        }

    };

    Slick.prototype.buildOut = function() {

        var _ = this;

        _.$slides =
            _.$slider
                .children( _.options.slide + ':not(.slick-cloned)')
                .addClass('slick-slide');

        _.slideCount = _.$slides.length;

        _.$slides.each(function(index, element) {
            $(element)
                .attr('data-slick-index', index)
                .data('originalStyling', $(element).attr('style') || '');
        });

        _.$slider.addClass('slick-slider');

        _.$slideTrack = (_.slideCount === 0) ?
            $('<div class="slick-track"/>').appendTo(_.$slider) :
            _.$slides.wrapAll('<div class="slick-track"/>').parent();

        _.$list = _.$slideTrack.wrap(
            '<div  class="slick-list"/>').parent();
        _.$slideTrack.css('opacity', 0);

        if (_.options.centerMode === true || _.options.swipeToSlide === true) {
            _.options.slidesToScroll = 1;
        }

        $('img[data-lazy]', _.$slider).not('[src]').addClass('slick-loading');

        _.setupInfinite();

        _.buildArrows();

        _.buildDots();

        _.updateDots();


        _.setSlideClasses(typeof _.currentSlide === 'number' ? _.currentSlide : 0);

        if (_.options.draggable === true) {
            _.$list.addClass('draggable');
        }

    };

    Slick.prototype.buildRows = function() {

        var _ = this, a, b, c, newSlides, numOfSlides, originalSlides,slidesPerSection;

        newSlides = document.createDocumentFragment();
        originalSlides = _.$slider.children();

        if(_.options.rows > 1) {

            slidesPerSection = _.options.slidesPerRow * _.options.rows;
            numOfSlides = Math.ceil(
                originalSlides.length / slidesPerSection
            );

            for(a = 0; a < numOfSlides; a++){
                var slide = document.createElement('div');
                for(b = 0; b < _.options.rows; b++) {
                    var row = document.createElement('div');
                    for(c = 0; c < _.options.slidesPerRow; c++) {
                        var target = (a * slidesPerSection + ((b * _.options.slidesPerRow) + c));
                        if (originalSlides.get(target)) {
                            row.appendChild(originalSlides.get(target));
                        }
                    }
                    slide.appendChild(row);
                }
                newSlides.appendChild(slide);
            }

            _.$slider.empty().append(newSlides);
            _.$slider.children().children().children()
                .css({
                    'width':(100 / _.options.slidesPerRow) + '%',
                    'display': 'inline-block'
                });

        }

    };

    Slick.prototype.checkResponsive = function(initial, forceUpdate) {

        var _ = this,
            breakpoint, targetBreakpoint, respondToWidth, triggerBreakpoint = false;
        var sliderWidth = _.$slider.width();
        var windowWidth = window.innerWidth || $(window).width();

        if (_.respondTo === 'window') {
            respondToWidth = windowWidth;
        } else if (_.respondTo === 'slider') {
            respondToWidth = sliderWidth;
        } else if (_.respondTo === 'min') {
            respondToWidth = Math.min(windowWidth, sliderWidth);
        }

        if ( _.options.responsive &&
            _.options.responsive.length &&
            _.options.responsive !== null) {

            targetBreakpoint = null;

            for (breakpoint in _.breakpoints) {
                if (_.breakpoints.hasOwnProperty(breakpoint)) {
                    if (_.originalSettings.mobileFirst === false) {
                        if (respondToWidth < _.breakpoints[breakpoint]) {
                            targetBreakpoint = _.breakpoints[breakpoint];
                        }
                    } else {
                        if (respondToWidth > _.breakpoints[breakpoint]) {
                            targetBreakpoint = _.breakpoints[breakpoint];
                        }
                    }
                }
            }

            if (targetBreakpoint !== null) {
                if (_.activeBreakpoint !== null) {
                    if (targetBreakpoint !== _.activeBreakpoint || forceUpdate) {
                        _.activeBreakpoint =
                            targetBreakpoint;
                        if (_.breakpointSettings[targetBreakpoint] === 'unslick') {
                            _.unslick(targetBreakpoint);
                        } else {
                            _.options = $.extend({}, _.originalSettings,
                                _.breakpointSettings[
                                    targetBreakpoint]);
                            if (initial === true) {
                                _.currentSlide = _.options.initialSlide;
                            }
                            _.refresh(initial);
                        }
                        triggerBreakpoint = targetBreakpoint;
                    }
                } else {
                    _.activeBreakpoint = targetBreakpoint;
                    if (_.breakpointSettings[targetBreakpoint] === 'unslick') {
                        _.unslick(targetBreakpoint);
                    } else {
                        _.options = $.extend({}, _.originalSettings,
                            _.breakpointSettings[
                                targetBreakpoint]);
                        if (initial === true) {
                            _.currentSlide = _.options.initialSlide;
                        }
                        _.refresh(initial);
                    }
                    triggerBreakpoint = targetBreakpoint;
                }
            } else {
                if (_.activeBreakpoint !== null) {
                    _.activeBreakpoint = null;
                    _.options = _.originalSettings;
                    if (initial === true) {
                        _.currentSlide = _.options.initialSlide;
                    }
                    _.refresh(initial);
                    triggerBreakpoint = targetBreakpoint;
                }
            }

            // only trigger breakpoints during an actual break. not on initialize.
            if( !initial && triggerBreakpoint !== false ) {
                _.$slider.trigger('breakpoint', [_, triggerBreakpoint]);
            }
        }

    };

    Slick.prototype.changeSlide = function(event, dontAnimate) {

        var _ = this,
            $target = $(event.currentTarget),
            indexOffset, slideOffset, unevenOffset;

        // If target is a link, prevent default action.
        if($target.is('a')) {
            event.preventDefault();
        }

        // If target is not the <li> element (ie: a child), find the <li>.
        if(!$target.is('li')) {
            $target = $target.closest('li');
        }

        unevenOffset = (_.slideCount % _.options.slidesToScroll !== 0);
        indexOffset = unevenOffset ? 0 : (_.slideCount - _.currentSlide) % _.options.slidesToScroll;

        switch (event.data.message) {

            case 'previous':
                slideOffset = indexOffset === 0 ? _.options.slidesToScroll : _.options.slidesToShow - indexOffset;
                if (_.slideCount > _.options.slidesToShow) {
                    _.slideHandler(_.currentSlide - slideOffset, false, dontAnimate);
                }
                break;

            case 'next':
                slideOffset = indexOffset === 0 ? _.options.slidesToScroll : indexOffset;
                if (_.slideCount > _.options.slidesToShow) {
                    _.slideHandler(_.currentSlide + slideOffset, false, dontAnimate);
                }
                break;

            case 'index':
                var index = event.data.index === 0 ? 0 :
                    event.data.index || $target.index() * _.options.slidesToScroll;

                _.slideHandler(_.checkNavigable(index), false, dontAnimate);
                $target.children().trigger('focus');
                break;

            default:
                return;
        }

    };

    Slick.prototype.checkNavigable = function(index) {

        var _ = this,
            navigables, prevNavigable;

        navigables = _.getNavigableIndexes();
        prevNavigable = 0;
        if (index > navigables[navigables.length - 1]) {
            index = navigables[navigables.length - 1];
        } else {
            for (var n in navigables) {
                if (index < navigables[n]) {
                    index = prevNavigable;
                    break;
                }
                prevNavigable = navigables[n];
            }
        }

        return index;
    };

    Slick.prototype.cleanUpEvents = function() {

        var _ = this;

        if (_.options.dots && _.$dots !== null) {

            $('li', _.$dots)
                .off('click.slick', _.changeSlide)
                .off('mouseenter.slick', $.proxy(_.interrupt, _, true))
                .off('mouseleave.slick', $.proxy(_.interrupt, _, false));

        }

        _.$slider.off('focus.slick blur.slick');

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {
            _.$prevArrow && _.$prevArrow.off('click.slick', _.changeSlide);
            _.$nextArrow && _.$nextArrow.off('click.slick', _.changeSlide);
        }

        _.$list.off('touchstart.slick mousedown.slick', _.swipeHandler);
        _.$list.off('touchmove.slick mousemove.slick', _.swipeHandler);
        _.$list.off('touchend.slick mouseup.slick', _.swipeHandler);
        _.$list.off('touchcancel.slick mouseleave.slick', _.swipeHandler);

        _.$list.off('click.slick', _.clickHandler);

        $(document).off(_.visibilityChange, _.visibility);

        _.cleanUpSlideEvents();

        if (_.options.accessibility === true) {
            _.$list.off('keydown.slick', _.keyHandler);
        }

        if (_.options.focusOnSelect === true) {
            $(_.$slideTrack).children().off('click.slick', _.selectHandler);
        }

        $(window).off('orientationchange.slick.slick-' + _.instanceUid, _.orientationChange);

        $(window).off('resize.slick.slick-' + _.instanceUid, _.resize);

        $('[draggable!=true]', _.$slideTrack).off('dragstart', _.preventDefault);

        $(window).off('load.slick.slick-' + _.instanceUid, _.setPosition);
        $(document).off('ready.slick.slick-' + _.instanceUid, _.setPosition);

    };

    Slick.prototype.cleanUpSlideEvents = function() {

        var _ = this;

        _.$list.off('mouseenter.slick', $.proxy(_.interrupt, _, true));
        _.$list.off('mouseleave.slick', $.proxy(_.interrupt, _, false));

    };

    Slick.prototype.cleanUpRows = function() {

        var _ = this, originalSlides;

        if(_.options.rows > 1) {
            originalSlides = _.$slides.children().children();
            originalSlides.removeAttr('style');
            _.$slider.empty().append(originalSlides);
        }

    };

    Slick.prototype.clickHandler = function(event) {

        var _ = this;

        if (_.shouldClick === false) {
            event.stopImmediatePropagation();
            event.stopPropagation();
            event.preventDefault();
        }

    };

    Slick.prototype.destroy = function(refresh) {

        var _ = this;

        _.autoPlayClear();

        _.touchObject = {};

        _.cleanUpEvents();

        $('.slick-cloned', _.$slider).detach();

        if (_.$dots) {
            _.$dots.remove();
        }


        if ( _.$prevArrow && _.$prevArrow.length ) {

            _.$prevArrow
                .removeClass('slick-disabled slick-arrow slick-hidden')
                .removeAttr('aria-hidden aria-disabled tabindex')
                .css('display','');

            if ( _.htmlExpr.test( _.options.prevArrow )) {
                _.$prevArrow.remove();
            }
        }

        if ( _.$nextArrow && _.$nextArrow.length ) {

            _.$nextArrow
                .removeClass('slick-disabled slick-arrow slick-hidden')
                .removeAttr('aria-hidden aria-disabled tabindex')
                .css('display','');

            if ( _.htmlExpr.test( _.options.nextArrow )) {
                _.$nextArrow.remove();
            }

        }


        if (_.$slides) {

            _.$slides
                .removeClass('slick-slide slick-active slick-center slick-visible slick-current')
                .removeAttr('aria-hidden')
                .removeAttr('data-slick-index')
                .each(function(){
                    $(this).attr('style', $(this).data('originalStyling'));
                });

            _.$slideTrack.children(this.options.slide).detach();

            _.$slideTrack.detach();

            _.$list.detach();

            _.$slider.append(_.$slides);
        }

        _.cleanUpRows();

        _.$slider.removeClass('slick-slider');
        _.$slider.removeClass('slick-initialized');
        _.$slider.removeClass('slick-dotted');

        _.unslicked = true;

        if(!refresh) {
            _.$slider.trigger('destroy', [_]);
        }

    };

    Slick.prototype.disableTransition = function(slide) {

        var _ = this,
            transition = {};

        transition[_.transitionType] = '';

        if (_.options.fade === false) {
            _.$slideTrack.css(transition);
        } else {
            _.$slides.eq(slide).css(transition);
        }

    };

    Slick.prototype.fadeSlide = function(slideIndex, callback) {

        var _ = this;

        if (_.cssTransitions === false) {

            _.$slides.eq(slideIndex).css({
                zIndex: _.options.zIndex
            });

            _.$slides.eq(slideIndex).animate({
                opacity: 1
            }, _.options.speed, _.options.easing, callback);

        } else {

            _.applyTransition(slideIndex);

            _.$slides.eq(slideIndex).css({
                opacity: 1,
                zIndex: _.options.zIndex
            });

            if (callback) {
                setTimeout(function() {

                    _.disableTransition(slideIndex);

                    callback.call();
                }, _.options.speed);
            }

        }

    };

    Slick.prototype.fadeSlideOut = function(slideIndex) {

        var _ = this;

        if (_.cssTransitions === false) {

            _.$slides.eq(slideIndex).animate({
                opacity: 0,
                zIndex: _.options.zIndex - 2
            }, _.options.speed, _.options.easing);

        } else {

            _.applyTransition(slideIndex);

            _.$slides.eq(slideIndex).css({
                opacity: 0,
                zIndex: _.options.zIndex - 2
            });

        }

    };

    Slick.prototype.filterSlides = Slick.prototype.slickFilter = function(filter) {

        var _ = this;

        if (filter !== null) {

            _.$slidesCache = _.$slides;

            _.unload();

            _.$slideTrack.children(this.options.slide).detach();

            _.$slidesCache.filter(filter).appendTo(_.$slideTrack);

            _.reinit();

        }

    };

    Slick.prototype.focusHandler = function() {

        var _ = this;

        _.$slider
            .off('focus.slick blur.slick')
            .on('focus.slick blur.slick',
                '*:not(.slick-arrow)', function(event) {

            event.stopImmediatePropagation();
            var $sf = $(this);

            setTimeout(function() {

                if( _.options.pauseOnFocus ) {
                    _.focussed = $sf.is(':focus');
                    _.autoPlay();
                }

            }, 0);

        });
    };

    Slick.prototype.getCurrent = Slick.prototype.slickCurrentSlide = function() {

        var _ = this;
        return _.currentSlide;

    };

    Slick.prototype.getDotCount = function() {

        var _ = this;

        var breakPoint = 0;
        var counter = 0;
        var pagerQty = 0;

        if (_.options.infinite === true) {
            while (breakPoint < _.slideCount) {
                ++pagerQty;
                breakPoint = counter + _.options.slidesToScroll;
                counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
            }
        } else if (_.options.centerMode === true) {
            pagerQty = _.slideCount;
        } else if(!_.options.asNavFor) {
            pagerQty = 1 + Math.ceil((_.slideCount - _.options.slidesToShow) / _.options.slidesToScroll);
        }else {
            while (breakPoint < _.slideCount) {
                ++pagerQty;
                breakPoint = counter + _.options.slidesToScroll;
                counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
            }
        }

        return pagerQty - 1;

    };

    Slick.prototype.getLeft = function(slideIndex) {

        var _ = this,
            targetLeft,
            verticalHeight,
            verticalOffset = 0,
            targetSlide;

        _.slideOffset = 0;
        verticalHeight = _.$slides.first().outerHeight(true);

        if (_.options.infinite === true) {
            if (_.slideCount > _.options.slidesToShow) {
                _.slideOffset = (_.slideWidth * _.options.slidesToShow) * -1;
                verticalOffset = (verticalHeight * _.options.slidesToShow) * -1;
            }
            if (_.slideCount % _.options.slidesToScroll !== 0) {
                if (slideIndex + _.options.slidesToScroll > _.slideCount && _.slideCount > _.options.slidesToShow) {
                    if (slideIndex > _.slideCount) {
                        _.slideOffset = ((_.options.slidesToShow - (slideIndex - _.slideCount)) * _.slideWidth) * -1;
                        verticalOffset = ((_.options.slidesToShow - (slideIndex - _.slideCount)) * verticalHeight) * -1;
                    } else {
                        _.slideOffset = ((_.slideCount % _.options.slidesToScroll) * _.slideWidth) * -1;
                        verticalOffset = ((_.slideCount % _.options.slidesToScroll) * verticalHeight) * -1;
                    }
                }
            }
        } else {
            if (slideIndex + _.options.slidesToShow > _.slideCount) {
                _.slideOffset = ((slideIndex + _.options.slidesToShow) - _.slideCount) * _.slideWidth;
                verticalOffset = ((slideIndex + _.options.slidesToShow) - _.slideCount) * verticalHeight;
            }
        }

        if (_.slideCount <= _.options.slidesToShow) {
            _.slideOffset = 0;
            verticalOffset = 0;
        }

        if (_.options.centerMode === true && _.options.infinite === true) {
            _.slideOffset += _.slideWidth * Math.floor(_.options.slidesToShow / 2) - _.slideWidth;
        } else if (_.options.centerMode === true) {
            _.slideOffset = 0;
            _.slideOffset += _.slideWidth * Math.floor(_.options.slidesToShow / 2);
        }

        if (_.options.vertical === false) {
            targetLeft = ((slideIndex * _.slideWidth) * -1) + _.slideOffset;
        } else {
            targetLeft = ((slideIndex * verticalHeight) * -1) + verticalOffset;
        }

        if (_.options.variableWidth === true) {

            if (_.slideCount <= _.options.slidesToShow || _.options.infinite === false) {
                targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex);
            } else {
                targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex + _.options.slidesToShow);
            }

            if (_.options.rtl === true) {
                if (targetSlide[0]) {
                    targetLeft = (_.$slideTrack.width() - targetSlide[0].offsetLeft - targetSlide.width()) * -1;
                } else {
                    targetLeft =  0;
                }
            } else {
                targetLeft = targetSlide[0] ? targetSlide[0].offsetLeft * -1 : 0;
            }

            if (_.options.centerMode === true) {
                if (_.slideCount <= _.options.slidesToShow || _.options.infinite === false) {
                    targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex);
                } else {
                    targetSlide = _.$slideTrack.children('.slick-slide').eq(slideIndex + _.options.slidesToShow + 1);
                }

                if (_.options.rtl === true) {
                    if (targetSlide[0]) {
                        targetLeft = (_.$slideTrack.width() - targetSlide[0].offsetLeft - targetSlide.width()) * -1;
                    } else {
                        targetLeft =  0;
                    }
                } else {
                    targetLeft = targetSlide[0] ? targetSlide[0].offsetLeft * -1 : 0;
                }

                targetLeft += (_.$list.width() - targetSlide.outerWidth()) / 2;
            }
        }

        return targetLeft;

    };

    Slick.prototype.getOption = Slick.prototype.slickGetOption = function(option) {

        var _ = this;

        return _.options[option];

    };

    Slick.prototype.getNavigableIndexes = function() {

        var _ = this,
            breakPoint = 0,
            counter = 0,
            indexes = [],
            max;

        if (_.options.infinite === false) {
            max = _.slideCount;
        } else {
            breakPoint = _.options.slidesToScroll * -1;
            counter = _.options.slidesToScroll * -1;
            max = _.slideCount * 2;
        }

        while (breakPoint < max) {
            indexes.push(breakPoint);
            breakPoint = counter + _.options.slidesToScroll;
            counter += _.options.slidesToScroll <= _.options.slidesToShow ? _.options.slidesToScroll : _.options.slidesToShow;
        }

        return indexes;

    };

    Slick.prototype.getSlick = function() {

        return this;

    };

    Slick.prototype.getSlideCount = function() {

        var _ = this,
            slidesTraversed, swipedSlide, centerOffset;

        centerOffset = _.options.centerMode === true ? _.slideWidth * Math.floor(_.options.slidesToShow / 2) : 0;

        if (_.options.swipeToSlide === true) {
            _.$slideTrack.find('.slick-slide').each(function(index, slide) {
                if (slide.offsetLeft - centerOffset + ($(slide).outerWidth() / 2) > (_.swipeLeft * -1)) {
                    swipedSlide = slide;
                    return false;
                }
            });

            slidesTraversed = Math.abs($(swipedSlide).attr('data-slick-index') - _.currentSlide) || 1;

            return slidesTraversed;

        } else {
            return _.options.slidesToScroll;
        }

    };

    Slick.prototype.goTo = Slick.prototype.slickGoTo = function(slide, dontAnimate) {

        var _ = this;

        _.changeSlide({
            data: {
                message: 'index',
                index: parseInt(slide)
            }
        }, dontAnimate);

    };

    Slick.prototype.init = function(creation) {

        var _ = this;

        if (!$(_.$slider).hasClass('slick-initialized')) {

            $(_.$slider).addClass('slick-initialized');

            _.buildRows();
            _.buildOut();
            _.setProps();
            _.startLoad();
            _.loadSlider();
            _.initializeEvents();
            _.updateArrows();
            _.updateDots();
            _.checkResponsive(true);
            _.focusHandler();

        }

        if (creation) {
            _.$slider.trigger('init', [_]);
        }

        if (_.options.accessibility === true) {
            _.initADA();
        }

        if ( _.options.autoplay ) {

            _.paused = false;
            _.autoPlay();

        }

    };

    Slick.prototype.initADA = function() {
        var _ = this;
        _.$slides.add(_.$slideTrack.find('.slick-cloned')).attr({
            'aria-hidden': 'true',
            'tabindex': '-1'
        }).find('a, input, button, select').attr({
            'tabindex': '-1'
        });

        _.$slideTrack.attr('role', 'listbox');

        _.$slides.not(_.$slideTrack.find('.slick-cloned')).each(function(i) {
            $(this).attr({
                'role': 'option',
                'aria-describedby': 'slick-slide' + _.instanceUid + i + ''
            });
        });

        if (_.$dots !== null) {
            _.$dots.attr('role', 'tablist').find('li').each(function(i) {
                $(this).attr({
                    'role': 'presentation',
                    'aria-selected': 'false',
                    'aria-controls': 'navigation' + _.instanceUid + i + '',
                    'id': 'slick-slide' + _.instanceUid + i + ''
                });
            })
                .first().attr('aria-selected', 'true').end()
                .find('button').attr('role', 'button').end()
                .closest('div').attr('role', 'toolbar');
        }
        _.activateADA();

    };

    Slick.prototype.initArrowEvents = function() {

        var _ = this;

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {
            _.$prevArrow
               .off('click.slick')
               .on('click.slick', {
                    message: 'previous'
               }, _.changeSlide);
            _.$nextArrow
               .off('click.slick')
               .on('click.slick', {
                    message: 'next'
               }, _.changeSlide);
        }

    };

    Slick.prototype.initDotEvents = function() {

        var _ = this;

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {
            $('li', _.$dots).on('click.slick', {
                message: 'index'
            }, _.changeSlide);
        }

        if ( _.options.dots === true && _.options.pauseOnDotsHover === true ) {

            $('li', _.$dots)
                .on('mouseenter.slick', $.proxy(_.interrupt, _, true))
                .on('mouseleave.slick', $.proxy(_.interrupt, _, false));

        }

    };

    Slick.prototype.initSlideEvents = function() {

        var _ = this;

        if ( _.options.pauseOnHover ) {

            _.$list.on('mouseenter.slick', $.proxy(_.interrupt, _, true));
            _.$list.on('mouseleave.slick', $.proxy(_.interrupt, _, false));

        }

    };

    Slick.prototype.initializeEvents = function() {

        var _ = this;

        _.initArrowEvents();

        _.initDotEvents();
        _.initSlideEvents();

        _.$list.on('touchstart.slick mousedown.slick', {
            action: 'start'
        }, _.swipeHandler);
        _.$list.on('touchmove.slick mousemove.slick', {
            action: 'move'
        }, _.swipeHandler);
        _.$list.on('touchend.slick mouseup.slick', {
            action: 'end'
        }, _.swipeHandler);
        _.$list.on('touchcancel.slick mouseleave.slick', {
            action: 'end'
        }, _.swipeHandler);

        _.$list.on('click.slick', _.clickHandler);

        $(document).on(_.visibilityChange, $.proxy(_.visibility, _));

        if (_.options.accessibility === true) {
            _.$list.on('keydown.slick', _.keyHandler);
        }

        if (_.options.focusOnSelect === true) {
            $(_.$slideTrack).children().on('click.slick', _.selectHandler);
        }

        $(window).on('orientationchange.slick.slick-' + _.instanceUid, $.proxy(_.orientationChange, _));

        $(window).on('resize.slick.slick-' + _.instanceUid, $.proxy(_.resize, _));

        $('[draggable!=true]', _.$slideTrack).on('dragstart', _.preventDefault);

        $(window).on('load.slick.slick-' + _.instanceUid, _.setPosition);
        $(document).on('ready.slick.slick-' + _.instanceUid, _.setPosition);

    };

    Slick.prototype.initUI = function() {

        var _ = this;

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {

            _.$prevArrow.show();
            _.$nextArrow.show();

        }

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

            _.$dots.show();

        }

    };

    Slick.prototype.keyHandler = function(event) {

        var _ = this;
         //Dont slide if the cursor is inside the form fields and arrow keys are pressed
        if(!event.target.tagName.match('TEXTAREA|INPUT|SELECT')) {
            if (event.keyCode === 37 && _.options.accessibility === true) {
                _.changeSlide({
                    data: {
                        message: _.options.rtl === true ? 'next' :  'previous'
                    }
                });
            } else if (event.keyCode === 39 && _.options.accessibility === true) {
                _.changeSlide({
                    data: {
                        message: _.options.rtl === true ? 'previous' : 'next'
                    }
                });
            }
        }

    };

    Slick.prototype.lazyLoad = function() {

        var _ = this,
            loadRange, cloneRange, rangeStart, rangeEnd;

        function loadImages(imagesScope) {

            $('img[data-lazy]', imagesScope).each(function() {

                var image = $(this),
                    imageSource = $(this).attr('data-lazy'),
                    imageToLoad = document.createElement('img');

                imageToLoad.onload = function() {

                    image
                        .animate({ opacity: 0 }, 100, function() {
                            image
                                .attr('src', imageSource)
                                .animate({ opacity: 1 }, 200, function() {
                                    image
                                        .removeAttr('data-lazy')
                                        .removeClass('slick-loading');
                                });
                            _.$slider.trigger('lazyLoaded', [_, image, imageSource]);
                        });

                };

                imageToLoad.onerror = function() {

                    image
                        .removeAttr( 'data-lazy' )
                        .removeClass( 'slick-loading' )
                        .addClass( 'slick-lazyload-error' );

                    _.$slider.trigger('lazyLoadError', [ _, image, imageSource ]);

                };

                imageToLoad.src = imageSource;

            });

        }

        if (_.options.centerMode === true) {
            if (_.options.infinite === true) {
                rangeStart = _.currentSlide + (_.options.slidesToShow / 2 + 1);
                rangeEnd = rangeStart + _.options.slidesToShow + 2;
            } else {
                rangeStart = Math.max(0, _.currentSlide - (_.options.slidesToShow / 2 + 1));
                rangeEnd = 2 + (_.options.slidesToShow / 2 + 1) + _.currentSlide;
            }
        } else {
            rangeStart = _.options.infinite ? _.options.slidesToShow + _.currentSlide : _.currentSlide;
            rangeEnd = Math.ceil(rangeStart + _.options.slidesToShow);
            if (_.options.fade === true) {
                if (rangeStart > 0) rangeStart--;
                if (rangeEnd <= _.slideCount) rangeEnd++;
            }
        }

        loadRange = _.$slider.find('.slick-slide').slice(rangeStart, rangeEnd);
        loadImages(loadRange);

        if (_.slideCount <= _.options.slidesToShow) {
            cloneRange = _.$slider.find('.slick-slide');
            loadImages(cloneRange);
        } else
        if (_.currentSlide >= _.slideCount - _.options.slidesToShow) {
            cloneRange = _.$slider.find('.slick-cloned').slice(0, _.options.slidesToShow);
            loadImages(cloneRange);
        } else if (_.currentSlide === 0) {
            cloneRange = _.$slider.find('.slick-cloned').slice(_.options.slidesToShow * -1);
            loadImages(cloneRange);
        }

    };

    Slick.prototype.loadSlider = function() {

        var _ = this;

        _.setPosition();

        _.$slideTrack.css({
            opacity: 1
        });

        _.$slider.removeClass('slick-loading');

        _.initUI();

        if (_.options.lazyLoad === 'progressive') {
            _.progressiveLazyLoad();
        }

    };

    Slick.prototype.next = Slick.prototype.slickNext = function() {

        var _ = this;

        _.changeSlide({
            data: {
                message: 'next'
            }
        });

    };

    Slick.prototype.orientationChange = function() {

        var _ = this;

        _.checkResponsive();
        _.setPosition();

    };

    Slick.prototype.pause = Slick.prototype.slickPause = function() {

        var _ = this;

        _.autoPlayClear();
        _.paused = true;

    };

    Slick.prototype.play = Slick.prototype.slickPlay = function() {

        var _ = this;

        _.autoPlay();
        _.options.autoplay = true;
        _.paused = false;
        _.focussed = false;
        _.interrupted = false;

    };

    Slick.prototype.postSlide = function(index) {

        var _ = this;

        if( !_.unslicked ) {

            _.$slider.trigger('afterChange', [_, index]);

            _.animating = false;

            _.setPosition();

            _.swipeLeft = null;

            if ( _.options.autoplay ) {
                _.autoPlay();
            }

            if (_.options.accessibility === true) {
                _.initADA();
            }

        }

    };

    Slick.prototype.prev = Slick.prototype.slickPrev = function() {

        var _ = this;

        _.changeSlide({
            data: {
                message: 'previous'
            }
        });

    };

    Slick.prototype.preventDefault = function(event) {

        event.preventDefault();

    };

    Slick.prototype.progressiveLazyLoad = function( tryCount ) {

        tryCount = tryCount || 1;

        var _ = this,
            $imgsToLoad = $( 'img[data-lazy]', _.$slider ),
            image,
            imageSource,
            imageToLoad;

        if ( $imgsToLoad.length ) {

            image = $imgsToLoad.first();
            imageSource = image.attr('data-lazy');
            imageToLoad = document.createElement('img');

            imageToLoad.onload = function() {

                image
                    .attr( 'src', imageSource )
                    .removeAttr('data-lazy')
                    .removeClass('slick-loading');

                if ( _.options.adaptiveHeight === true ) {
                    _.setPosition();
                }

                _.$slider.trigger('lazyLoaded', [ _, image, imageSource ]);
                _.progressiveLazyLoad();

            };

            imageToLoad.onerror = function() {

                if ( tryCount < 3 ) {

                    /**
                     * try to load the image 3 times,
                     * leave a slight delay so we don't get
                     * servers blocking the request.
                     */
                    setTimeout( function() {
                        _.progressiveLazyLoad( tryCount + 1 );
                    }, 500 );

                } else {

                    image
                        .removeAttr( 'data-lazy' )
                        .removeClass( 'slick-loading' )
                        .addClass( 'slick-lazyload-error' );

                    _.$slider.trigger('lazyLoadError', [ _, image, imageSource ]);

                    _.progressiveLazyLoad();

                }

            };

            imageToLoad.src = imageSource;

        } else {

            _.$slider.trigger('allImagesLoaded', [ _ ]);

        }

    };

    Slick.prototype.refresh = function( initializing ) {

        var _ = this, currentSlide, lastVisibleIndex;

        lastVisibleIndex = _.slideCount - _.options.slidesToShow;

        // in non-infinite sliders, we don't want to go past the
        // last visible index.
        if( !_.options.infinite && ( _.currentSlide > lastVisibleIndex )) {
            _.currentSlide = lastVisibleIndex;
        }

        // if less slides than to show, go to start.
        if ( _.slideCount <= _.options.slidesToShow ) {
            _.currentSlide = 0;

        }

        currentSlide = _.currentSlide;

        _.destroy(true);

        $.extend(_, _.initials, { currentSlide: currentSlide });

        _.init();

        if( !initializing ) {

            _.changeSlide({
                data: {
                    message: 'index',
                    index: currentSlide
                }
            }, false);

        }

    };

    Slick.prototype.registerBreakpoints = function() {

        var _ = this, breakpoint, currentBreakpoint, l,
            responsiveSettings = _.options.responsive || null;

        if ( $.type(responsiveSettings) === 'array' && responsiveSettings.length ) {

            _.respondTo = _.options.respondTo || 'window';

            for ( breakpoint in responsiveSettings ) {

                l = _.breakpoints.length-1;
                currentBreakpoint = responsiveSettings[breakpoint].breakpoint;

                if (responsiveSettings.hasOwnProperty(breakpoint)) {

                    // loop through the breakpoints and cut out any existing
                    // ones with the same breakpoint number, we don't want dupes.
                    while( l >= 0 ) {
                        if( _.breakpoints[l] && _.breakpoints[l] === currentBreakpoint ) {
                            _.breakpoints.splice(l,1);
                        }
                        l--;
                    }

                    _.breakpoints.push(currentBreakpoint);
                    _.breakpointSettings[currentBreakpoint] = responsiveSettings[breakpoint].settings;

                }

            }

            _.breakpoints.sort(function(a, b) {
                return ( _.options.mobileFirst ) ? a-b : b-a;
            });

        }

    };

    Slick.prototype.reinit = function() {

        var _ = this;

        _.$slides =
            _.$slideTrack
                .children(_.options.slide)
                .addClass('slick-slide');

        _.slideCount = _.$slides.length;

        if (_.currentSlide >= _.slideCount && _.currentSlide !== 0) {
            _.currentSlide = _.currentSlide - _.options.slidesToScroll;
        }

        if (_.slideCount <= _.options.slidesToShow) {
            _.currentSlide = 0;
        }

        _.registerBreakpoints();

        _.setProps();
        _.setupInfinite();
        _.buildArrows();
        _.updateArrows();
        _.initArrowEvents();
        _.buildDots();
        _.updateDots();
        _.initDotEvents();
        _.cleanUpSlideEvents();
        _.initSlideEvents();

        _.checkResponsive(false, true);

        if (_.options.focusOnSelect === true) {
            $(_.$slideTrack).children().on('click.slick', _.selectHandler);
        }

        _.setSlideClasses(typeof _.currentSlide === 'number' ? _.currentSlide : 0);

        _.setPosition();
        _.focusHandler();

        _.paused = !_.options.autoplay;
        _.autoPlay();

        _.$slider.trigger('reInit', [_]);

    };

    Slick.prototype.resize = function() {

        var _ = this;

        if ($(window).width() !== _.windowWidth) {
            clearTimeout(_.windowDelay);
            _.windowDelay = window.setTimeout(function() {
                _.windowWidth = $(window).width();
                _.checkResponsive();
                if( !_.unslicked ) { _.setPosition(); }
            }, 50);
        }
    };

    Slick.prototype.removeSlide = Slick.prototype.slickRemove = function(index, removeBefore, removeAll) {

        var _ = this;

        if (typeof(index) === 'boolean') {
            removeBefore = index;
            index = removeBefore === true ? 0 : _.slideCount - 1;
        } else {
            index = removeBefore === true ? --index : index;
        }

        if (_.slideCount < 1 || index < 0 || index > _.slideCount - 1) {
            return false;
        }

        _.unload();

        if (removeAll === true) {
            _.$slideTrack.children().remove();
        } else {
            _.$slideTrack.children(this.options.slide).eq(index).remove();
        }

        _.$slides = _.$slideTrack.children(this.options.slide);

        _.$slideTrack.children(this.options.slide).detach();

        _.$slideTrack.append(_.$slides);

        _.$slidesCache = _.$slides;

        _.reinit();

    };

    Slick.prototype.setCSS = function(position) {

        var _ = this,
            positionProps = {},
            x, y;

        if (_.options.rtl === true) {
            position = -position;
        }
        x = _.positionProp == 'left' ? Math.ceil(position) + 'px' : '0px';
        y = _.positionProp == 'top' ? Math.ceil(position) + 'px' : '0px';

        positionProps[_.positionProp] = position;

        if (_.transformsEnabled === false) {
            _.$slideTrack.css(positionProps);
        } else {
            positionProps = {};
            if (_.cssTransitions === false) {
                positionProps[_.animType] = 'translate(' + x + ', ' + y + ')';
                _.$slideTrack.css(positionProps);
            } else {
                positionProps[_.animType] = 'translate3d(' + x + ', ' + y + ', 0px)';
                _.$slideTrack.css(positionProps);
            }
        }

    };

    Slick.prototype.setDimensions = function() {

        var _ = this;

        if (_.options.vertical === false) {
            if (_.options.centerMode === true) {
                _.$list.css({
                    padding: ('0px ' + _.options.centerPadding)
                });
            }
        } else {
            _.$list.height(_.$slides.first().outerHeight(true) * _.options.slidesToShow);
            if (_.options.centerMode === true) {
                _.$list.css({
                    padding: (_.options.centerPadding + ' 0px')
                });
            }
        }

        _.listWidth = _.$list.width();
        _.listHeight = _.$list.height();


        if (_.options.vertical === false && _.options.variableWidth === false) {
            _.slideWidth = Math.ceil(_.listWidth / _.options.slidesToShow);
            _.$slideTrack.width(Math.ceil((_.slideWidth * _.$slideTrack.children('.slick-slide').length)));

        } else if (_.options.variableWidth === true) {
            _.$slideTrack.width(5000 * _.slideCount);
        } else {
            _.slideWidth = Math.ceil(_.listWidth);
            _.$slideTrack.height(Math.ceil((_.$slides.first().outerHeight(true) * _.$slideTrack.children('.slick-slide').length)));
        }

        var offset = _.$slides.first().outerWidth(true) - _.$slides.first().width();
        if (_.options.variableWidth === false) _.$slideTrack.children('.slick-slide').width(_.slideWidth - offset);

    };

    Slick.prototype.setFade = function() {

        var _ = this,
            targetLeft;

        _.$slides.each(function(index, element) {
            targetLeft = (_.slideWidth * index) * -1;
            if (_.options.rtl === true) {
                $(element).css({
                    position: 'relative',
                    right: targetLeft,
                    top: 0,
                    zIndex: _.options.zIndex - 2,
                    opacity: 0
                });
            } else {
                $(element).css({
                    position: 'relative',
                    left: targetLeft,
                    top: 0,
                    zIndex: _.options.zIndex - 2,
                    opacity: 0
                });
            }
        });

        _.$slides.eq(_.currentSlide).css({
            zIndex: _.options.zIndex - 1,
            opacity: 1
        });

    };

    Slick.prototype.setHeight = function() {

        var _ = this;

        if (_.options.slidesToShow === 1 && _.options.adaptiveHeight === true && _.options.vertical === false) {
            var targetHeight = _.$slides.eq(_.currentSlide).outerHeight(true);
            _.$list.css('height', targetHeight);
        }

    };

    Slick.prototype.setOption =
    Slick.prototype.slickSetOption = function() {

        /**
         * accepts arguments in format of:
         *
         *  - for changing a single option's value:
         *     .slick("setOption", option, value, refresh )
         *
         *  - for changing a set of responsive options:
         *     .slick("setOption", 'responsive', [{}, ...], refresh )
         *
         *  - for updating multiple values at once (not responsive)
         *     .slick("setOption", { 'option': value, ... }, refresh )
         */

        var _ = this, l, item, option, value, refresh = false, type;

        if( $.type( arguments[0] ) === 'object' ) {

            option =  arguments[0];
            refresh = arguments[1];
            type = 'multiple';

        } else if ( $.type( arguments[0] ) === 'string' ) {

            option =  arguments[0];
            value = arguments[1];
            refresh = arguments[2];

            if ( arguments[0] === 'responsive' && $.type( arguments[1] ) === 'array' ) {

                type = 'responsive';

            } else if ( typeof arguments[1] !== 'undefined' ) {

                type = 'single';

            }

        }

        if ( type === 'single' ) {

            _.options[option] = value;


        } else if ( type === 'multiple' ) {

            $.each( option , function( opt, val ) {

                _.options[opt] = val;

            });


        } else if ( type === 'responsive' ) {

            for ( item in value ) {

                if( $.type( _.options.responsive ) !== 'array' ) {

                    _.options.responsive = [ value[item] ];

                } else {

                    l = _.options.responsive.length-1;

                    // loop through the responsive object and splice out duplicates.
                    while( l >= 0 ) {

                        if( _.options.responsive[l].breakpoint === value[item].breakpoint ) {

                            _.options.responsive.splice(l,1);

                        }

                        l--;

                    }

                    _.options.responsive.push( value[item] );

                }

            }

        }

        if ( refresh ) {

            _.unload();
            _.reinit();

        }

    };

    Slick.prototype.setPosition = function() {

        var _ = this;

        _.setDimensions();

        _.setHeight();

        if (_.options.fade === false) {
            _.setCSS(_.getLeft(_.currentSlide));
        } else {
            _.setFade();
        }

        _.$slider.trigger('setPosition', [_]);

    };

    Slick.prototype.setProps = function() {

        var _ = this,
            bodyStyle = document.body.style;

        _.positionProp = _.options.vertical === true ? 'top' : 'left';

        if (_.positionProp === 'top') {
            _.$slider.addClass('slick-vertical');
        } else {
            _.$slider.removeClass('slick-vertical');
        }

        if (bodyStyle.WebkitTransition !== undefined ||
            bodyStyle.MozTransition !== undefined ||
            bodyStyle.msTransition !== undefined) {
            if (_.options.useCSS === true) {
                _.cssTransitions = true;
            }
        }

        if ( _.options.fade ) {
            if ( typeof _.options.zIndex === 'number' ) {
                if( _.options.zIndex < 3 ) {
                    _.options.zIndex = 3;
                }
            } else {
                _.options.zIndex = _.defaults.zIndex;
            }
        }

        if (bodyStyle.OTransform !== undefined) {
            _.animType = 'OTransform';
            _.transformType = '-o-transform';
            _.transitionType = 'OTransition';
            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.webkitPerspective === undefined) _.animType = false;
        }
        if (bodyStyle.MozTransform !== undefined) {
            _.animType = 'MozTransform';
            _.transformType = '-moz-transform';
            _.transitionType = 'MozTransition';
            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.MozPerspective === undefined) _.animType = false;
        }
        if (bodyStyle.webkitTransform !== undefined) {
            _.animType = 'webkitTransform';
            _.transformType = '-webkit-transform';
            _.transitionType = 'webkitTransition';
            if (bodyStyle.perspectiveProperty === undefined && bodyStyle.webkitPerspective === undefined) _.animType = false;
        }
        if (bodyStyle.msTransform !== undefined) {
            _.animType = 'msTransform';
            _.transformType = '-ms-transform';
            _.transitionType = 'msTransition';
            if (bodyStyle.msTransform === undefined) _.animType = false;
        }
        if (bodyStyle.transform !== undefined && _.animType !== false) {
            _.animType = 'transform';
            _.transformType = 'transform';
            _.transitionType = 'transition';
        }
        _.transformsEnabled = _.options.useTransform && (_.animType !== null && _.animType !== false);
    };


    Slick.prototype.setSlideClasses = function(index) {

        var _ = this,
            centerOffset, allSlides, indexOffset, remainder;

        allSlides = _.$slider
            .find('.slick-slide')
            .removeClass('slick-active slick-center slick-current')
            .attr('aria-hidden', 'true');

        _.$slides
            .eq(index)
            .addClass('slick-current');

        if (_.options.centerMode === true) {

            centerOffset = Math.floor(_.options.slidesToShow / 2);

            if (_.options.infinite === true) {

                if (index >= centerOffset && index <= (_.slideCount - 1) - centerOffset) {

                    _.$slides
                        .slice(index - centerOffset, index + centerOffset + 1)
                        .addClass('slick-active')
                        .attr('aria-hidden', 'false');

                } else {

                    indexOffset = _.options.slidesToShow + index;
                    allSlides
                        .slice(indexOffset - centerOffset + 1, indexOffset + centerOffset + 2)
                        .addClass('slick-active')
                        .attr('aria-hidden', 'false');

                }

                if (index === 0) {

                    allSlides
                        .eq(allSlides.length - 1 - _.options.slidesToShow)
                        .addClass('slick-center');

                } else if (index === _.slideCount - 1) {

                    allSlides
                        .eq(_.options.slidesToShow)
                        .addClass('slick-center');

                }

            }

            _.$slides
                .eq(index)
                .addClass('slick-center');

        } else {

            if (index >= 0 && index <= (_.slideCount - _.options.slidesToShow)) {

                _.$slides
                    .slice(index, index + _.options.slidesToShow)
                    .addClass('slick-active')
                    .attr('aria-hidden', 'false');

            } else if (allSlides.length <= _.options.slidesToShow) {

                allSlides
                    .addClass('slick-active')
                    .attr('aria-hidden', 'false');

            } else {

                remainder = _.slideCount % _.options.slidesToShow;
                indexOffset = _.options.infinite === true ? _.options.slidesToShow + index : index;

                if (_.options.slidesToShow == _.options.slidesToScroll && (_.slideCount - index) < _.options.slidesToShow) {

                    allSlides
                        .slice(indexOffset - (_.options.slidesToShow - remainder), indexOffset + remainder)
                        .addClass('slick-active')
                        .attr('aria-hidden', 'false');

                } else {

                    allSlides
                        .slice(indexOffset, indexOffset + _.options.slidesToShow)
                        .addClass('slick-active')
                        .attr('aria-hidden', 'false');

                }

            }

        }

        if (_.options.lazyLoad === 'ondemand') {
            _.lazyLoad();
        }

    };

    Slick.prototype.setupInfinite = function() {

        var _ = this,
            i, slideIndex, infiniteCount;

        if (_.options.fade === true) {
            _.options.centerMode = false;
        }

        if (_.options.infinite === true && _.options.fade === false) {

            slideIndex = null;

            if (_.slideCount > _.options.slidesToShow) {

                if (_.options.centerMode === true) {
                    infiniteCount = _.options.slidesToShow + 1;
                } else {
                    infiniteCount = _.options.slidesToShow;
                }

                for (i = _.slideCount; i > (_.slideCount -
                        infiniteCount); i -= 1) {
                    slideIndex = i - 1;
                    $(_.$slides[slideIndex]).clone(true).attr('id', '')
                        .attr('data-slick-index', slideIndex - _.slideCount)
                        .prependTo(_.$slideTrack).addClass('slick-cloned');
                }
                for (i = 0; i < infiniteCount; i += 1) {
                    slideIndex = i;
                    $(_.$slides[slideIndex]).clone(true).attr('id', '')
                        .attr('data-slick-index', slideIndex + _.slideCount)
                        .appendTo(_.$slideTrack).addClass('slick-cloned');
                }
                _.$slideTrack.find('.slick-cloned').find('[id]').each(function() {
                    $(this).attr('id', '');
                });

            }

        }

    };

    Slick.prototype.interrupt = function( toggle ) {

        var _ = this;

        if( !toggle ) {
            _.autoPlay();
        }
        _.interrupted = toggle;

    };

    Slick.prototype.selectHandler = function(event) {

        var _ = this;

        var targetElement =
            $(event.target).is('.slick-slide') ?
                $(event.target) :
                $(event.target).parents('.slick-slide');

        var index = parseInt(targetElement.attr('data-slick-index'));

        if (!index) index = 0;

        if (_.slideCount <= _.options.slidesToShow) {

            _.setSlideClasses(index);
            _.asNavFor(index);
            return;

        }

        _.slideHandler(index);

    };

    Slick.prototype.slideHandler = function(index, sync, dontAnimate) {

        var targetSlide, animSlide, oldSlide, slideLeft, targetLeft = null,
            _ = this, navTarget;

        sync = sync || false;

        if (_.animating === true && _.options.waitForAnimate === true) {
            return;
        }

        if (_.options.fade === true && _.currentSlide === index) {
            return;
        }

        if (_.slideCount <= _.options.slidesToShow) {
            return;
        }

        if (sync === false) {
            _.asNavFor(index);
        }

        targetSlide = index;
        targetLeft = _.getLeft(targetSlide);
        slideLeft = _.getLeft(_.currentSlide);

        _.currentLeft = _.swipeLeft === null ? slideLeft : _.swipeLeft;

        if (_.options.infinite === false && _.options.centerMode === false && (index < 0 || index > _.getDotCount() * _.options.slidesToScroll)) {
            if (_.options.fade === false) {
                targetSlide = _.currentSlide;
                if (dontAnimate !== true) {
                    _.animateSlide(slideLeft, function() {
                        _.postSlide(targetSlide);
                    });
                } else {
                    _.postSlide(targetSlide);
                }
            }
            return;
        } else if (_.options.infinite === false && _.options.centerMode === true && (index < 0 || index > (_.slideCount - _.options.slidesToScroll))) {
            if (_.options.fade === false) {
                targetSlide = _.currentSlide;
                if (dontAnimate !== true) {
                    _.animateSlide(slideLeft, function() {
                        _.postSlide(targetSlide);
                    });
                } else {
                    _.postSlide(targetSlide);
                }
            }
            return;
        }

        if ( _.options.autoplay ) {
            clearInterval(_.autoPlayTimer);
        }

        if (targetSlide < 0) {
            if (_.slideCount % _.options.slidesToScroll !== 0) {
                animSlide = _.slideCount - (_.slideCount % _.options.slidesToScroll);
            } else {
                animSlide = _.slideCount + targetSlide;
            }
        } else if (targetSlide >= _.slideCount) {
            if (_.slideCount % _.options.slidesToScroll !== 0) {
                animSlide = 0;
            } else {
                animSlide = targetSlide - _.slideCount;
            }
        } else {
            animSlide = targetSlide;
        }

        _.animating = true;

        _.$slider.trigger('beforeChange', [_, _.currentSlide, animSlide]);

        oldSlide = _.currentSlide;
        _.currentSlide = animSlide;

        _.setSlideClasses(_.currentSlide);

        if ( _.options.asNavFor ) {

            navTarget = _.getNavTarget();
            navTarget = navTarget.slick('getSlick');

            if ( navTarget.slideCount <= navTarget.options.slidesToShow ) {
                navTarget.setSlideClasses(_.currentSlide);
            }

        }

        _.updateDots();
        _.updateArrows();

        if (_.options.fade === true) {
            if (dontAnimate !== true) {

                _.fadeSlideOut(oldSlide);

                _.fadeSlide(animSlide, function() {
                    _.postSlide(animSlide);
                });

            } else {
                _.postSlide(animSlide);
            }
            _.animateHeight();
            return;
        }

        if (dontAnimate !== true) {
            _.animateSlide(targetLeft, function() {
                _.postSlide(animSlide);
            });
        } else {
            _.postSlide(animSlide);
        }

    };

    Slick.prototype.startLoad = function() {

        var _ = this;

        if (_.options.arrows === true && _.slideCount > _.options.slidesToShow) {

            _.$prevArrow.hide();
            _.$nextArrow.hide();

        }

        if (_.options.dots === true && _.slideCount > _.options.slidesToShow) {

            _.$dots.hide();

        }

        _.$slider.addClass('slick-loading');

    };

    Slick.prototype.swipeDirection = function() {

        var xDist, yDist, r, swipeAngle, _ = this;

        xDist = _.touchObject.startX - _.touchObject.curX;
        yDist = _.touchObject.startY - _.touchObject.curY;
        r = Math.atan2(yDist, xDist);

        swipeAngle = Math.round(r * 180 / Math.PI);
        if (swipeAngle < 0) {
            swipeAngle = 360 - Math.abs(swipeAngle);
        }

        if ((swipeAngle <= 45) && (swipeAngle >= 0)) {
            return (_.options.rtl === false ? 'left' : 'right');
        }
        if ((swipeAngle <= 360) && (swipeAngle >= 315)) {
            return (_.options.rtl === false ? 'left' : 'right');
        }
        if ((swipeAngle >= 135) && (swipeAngle <= 225)) {
            return (_.options.rtl === false ? 'right' : 'left');
        }
        if (_.options.verticalSwiping === true) {
            if ((swipeAngle >= 35) && (swipeAngle <= 135)) {
                return 'down';
            } else {
                return 'up';
            }
        }

        return 'vertical';

    };

    Slick.prototype.swipeEnd = function(event) {

        var _ = this,
            slideCount,
            direction;

        _.dragging = false;
        _.interrupted = false;
        _.shouldClick = ( _.touchObject.swipeLength > 10 ) ? false : true;

        if ( _.touchObject.curX === undefined ) {
            return false;
        }

        if ( _.touchObject.edgeHit === true ) {
            _.$slider.trigger('edge', [_, _.swipeDirection() ]);
        }

        if ( _.touchObject.swipeLength >= _.touchObject.minSwipe ) {

            direction = _.swipeDirection();

            switch ( direction ) {

                case 'left':
                case 'down':

                    slideCount =
                        _.options.swipeToSlide ?
                            _.checkNavigable( _.currentSlide + _.getSlideCount() ) :
                            _.currentSlide + _.getSlideCount();

                    _.currentDirection = 0;

                    break;

                case 'right':
                case 'up':

                    slideCount =
                        _.options.swipeToSlide ?
                            _.checkNavigable( _.currentSlide - _.getSlideCount() ) :
                            _.currentSlide - _.getSlideCount();

                    _.currentDirection = 1;

                    break;

                default:


            }

            if( direction != 'vertical' ) {

                _.slideHandler( slideCount );
                _.touchObject = {};
                _.$slider.trigger('swipe', [_, direction ]);

            }

        } else {

            if ( _.touchObject.startX !== _.touchObject.curX ) {

                _.slideHandler( _.currentSlide );
                _.touchObject = {};

            }

        }

    };

    Slick.prototype.swipeHandler = function(event) {

        var _ = this;

        if ((_.options.swipe === false) || ('ontouchend' in document && _.options.swipe === false)) {
            return;
        } else if (_.options.draggable === false && event.type.indexOf('mouse') !== -1) {
            return;
        }

        _.touchObject.fingerCount = event.originalEvent && event.originalEvent.touches !== undefined ?
            event.originalEvent.touches.length : 1;

        _.touchObject.minSwipe = _.listWidth / _.options
            .touchThreshold;

        if (_.options.verticalSwiping === true) {
            _.touchObject.minSwipe = _.listHeight / _.options
                .touchThreshold;
        }

        switch (event.data.action) {

            case 'start':
                _.swipeStart(event);
                break;

            case 'move':
                _.swipeMove(event);
                break;

            case 'end':
                _.swipeEnd(event);
                break;

        }

    };

    Slick.prototype.swipeMove = function(event) {

        var _ = this,
            edgeWasHit = false,
            curLeft, swipeDirection, swipeLength, positionOffset, touches;

        touches = event.originalEvent !== undefined ? event.originalEvent.touches : null;

        if (!_.dragging || touches && touches.length !== 1) {
            return false;
        }

        curLeft = _.getLeft(_.currentSlide);

        _.touchObject.curX = touches !== undefined ? touches[0].pageX : event.clientX;
        _.touchObject.curY = touches !== undefined ? touches[0].pageY : event.clientY;

        _.touchObject.swipeLength = Math.round(Math.sqrt(
            Math.pow(_.touchObject.curX - _.touchObject.startX, 2)));

        if (_.options.verticalSwiping === true) {
            _.touchObject.swipeLength = Math.round(Math.sqrt(
                Math.pow(_.touchObject.curY - _.touchObject.startY, 2)));
        }

        swipeDirection = _.swipeDirection();

        if (swipeDirection === 'vertical') {
            return;
        }

        if (event.originalEvent !== undefined && _.touchObject.swipeLength > 4) {
            event.preventDefault();
        }

        positionOffset = (_.options.rtl === false ? 1 : -1) * (_.touchObject.curX > _.touchObject.startX ? 1 : -1);
        if (_.options.verticalSwiping === true) {
            positionOffset = _.touchObject.curY > _.touchObject.startY ? 1 : -1;
        }


        swipeLength = _.touchObject.swipeLength;

        _.touchObject.edgeHit = false;

        if (_.options.infinite === false) {
            if ((_.currentSlide === 0 && swipeDirection === 'right') || (_.currentSlide >= _.getDotCount() && swipeDirection === 'left')) {
                swipeLength = _.touchObject.swipeLength * _.options.edgeFriction;
                _.touchObject.edgeHit = true;
            }
        }

        if (_.options.vertical === false) {
            _.swipeLeft = curLeft + swipeLength * positionOffset;
        } else {
            _.swipeLeft = curLeft + (swipeLength * (_.$list.height() / _.listWidth)) * positionOffset;
        }
        if (_.options.verticalSwiping === true) {
            _.swipeLeft = curLeft + swipeLength * positionOffset;
        }

        if (_.options.fade === true || _.options.touchMove === false) {
            return false;
        }

        if (_.animating === true) {
            _.swipeLeft = null;
            return false;
        }

        _.setCSS(_.swipeLeft);

    };

    Slick.prototype.swipeStart = function(event) {

        var _ = this,
            touches;

        _.interrupted = true;

        if (_.touchObject.fingerCount !== 1 || _.slideCount <= _.options.slidesToShow) {
            _.touchObject = {};
            return false;
        }

        if (event.originalEvent !== undefined && event.originalEvent.touches !== undefined) {
            touches = event.originalEvent.touches[0];
        }

        _.touchObject.startX = _.touchObject.curX = touches !== undefined ? touches.pageX : event.clientX;
        _.touchObject.startY = _.touchObject.curY = touches !== undefined ? touches.pageY : event.clientY;

        _.dragging = true;

    };

    Slick.prototype.unfilterSlides = Slick.prototype.slickUnfilter = function() {

        var _ = this;

        if (_.$slidesCache !== null) {

            _.unload();

            _.$slideTrack.children(this.options.slide).detach();

            _.$slidesCache.appendTo(_.$slideTrack);

            _.reinit();

        }

    };

    Slick.prototype.unload = function() {

        var _ = this;

        $('.slick-cloned', _.$slider).remove();

        if (_.$dots) {
            _.$dots.remove();
        }

        if (_.$prevArrow && _.htmlExpr.test(_.options.prevArrow)) {
            _.$prevArrow.remove();
        }

        if (_.$nextArrow && _.htmlExpr.test(_.options.nextArrow)) {
            _.$nextArrow.remove();
        }

        _.$slides
            .removeClass('slick-slide slick-active slick-visible slick-current')
            .attr('aria-hidden', 'true')
            .css('width', '');

    };

    Slick.prototype.unslick = function(fromBreakpoint) {

        var _ = this;
        _.$slider.trigger('unslick', [_, fromBreakpoint]);
        _.destroy();

    };

    Slick.prototype.updateArrows = function() {

        var _ = this,
            centerOffset;

        centerOffset = Math.floor(_.options.slidesToShow / 2);

        if ( _.options.arrows === true &&
            _.slideCount > _.options.slidesToShow &&
            !_.options.infinite ) {

            _.$prevArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');
            _.$nextArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

            if (_.currentSlide === 0) {

                _.$prevArrow.addClass('slick-disabled').attr('aria-disabled', 'true');
                _.$nextArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

            } else if (_.currentSlide >= _.slideCount - _.options.slidesToShow && _.options.centerMode === false) {

                _.$nextArrow.addClass('slick-disabled').attr('aria-disabled', 'true');
                _.$prevArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

            } else if (_.currentSlide >= _.slideCount - 1 && _.options.centerMode === true) {

                _.$nextArrow.addClass('slick-disabled').attr('aria-disabled', 'true');
                _.$prevArrow.removeClass('slick-disabled').attr('aria-disabled', 'false');

            }

        }

    };

    Slick.prototype.updateDots = function() {

        var _ = this;

        if (_.$dots !== null) {

            _.$dots
                .find('li')
                .removeClass('slick-active')
                .attr('aria-hidden', 'true');

            _.$dots
                .find('li')
                .eq(Math.floor(_.currentSlide / _.options.slidesToScroll))
                .addClass('slick-active')
                .attr('aria-hidden', 'false');

        }

    };

    Slick.prototype.visibility = function() {

        var _ = this;

        if ( _.options.autoplay ) {

            if ( document[_.hidden] ) {

                _.interrupted = true;

            } else {

                _.interrupted = false;

            }

        }

    };

    $.fn.slick = function() {
        var _ = this,
            opt = arguments[0],
            args = Array.prototype.slice.call(arguments, 1),
            l = _.length,
            i,
            ret;
        for (i = 0; i < l; i++) {
            if (typeof opt == 'object' || typeof opt == 'undefined')
                _[i].slick = new Slick(_[i], opt);
            else
                ret = _[i].slick[opt].apply(_[i].slick, args);
            if (typeof ret != 'undefined') return ret;
        }
        return _;
    };

}));

var dateMsg1,dateMsg2;

var arrWinHandle = new Array();	// 팝업창 핸들 저장 array

/*
 * 콤보조회(selectBox)
 * @param : url
 * @param : selectBox id
 * @param : firstOpt > "전체", "선택" 등 첫번째 옵션 추가시 넘긴다.
 * @param : callBack function
 */
function gfnSelectBox(sUrl, obj, firstOpt, callBackFn, sync){

	sync = sync == null ? true : sync;

    var loop = 0;
    var params = {};

    $.ajax({
        url:sUrl,
        type:'post',
        async: sync,
        data: params,
        dataType : "json",
        error:function(){
            //alert('Error');
        },
        success:function(rtnData){

        	$("#"+obj).empty();

        	if(firstOpt && firstOpt != ""){
                $("#"+obj).get(0).options[0] = new Option(firstOpt, "");
                loop = 1;
            }

            $.each(rtnData, function(idx, ref) {
                $("#"+obj).get(0).options[idx+loop] = new Option(ref.cdNm, ref.cd);
            });

            //if (loop == 1) $("#"+obj+" option:eq(0)").prop("selected", true);

            if (callBackFn) {
                //실행 후 callback function
                try {
                    callBackFn();
                } catch (e){
                    //alert("callback 함수 에러!!");
                }
            }
        }
    });
}

/*
 * 공통코드(selectBox) - 비동기 방식
 * @param : 요청 url
 * @param : selectBox id
 * @param : firstOpt > "전체", "선택" 등 첫번째 옵션 추가시 넘긴다.
 */
function gfnAXSelBxUrl(sUrl, obj, firstOpt){

	var isspace = firstOpt != "" ? true : false;

	$("#"+obj).bindSelect({
        reserveKeys: {
            options: "resultList",
            optionValue: "CD",
            optionText: "CDNM"
        },
        ajaxUrl: sUrl,
        ajaxPars: {},
        isspace: isspace,
        isspaceTitle: firstOpt,
        onchange: function(){
        	//console.log(Object.toJSON(this));
        }
    });
}

/*
 * 공통코드(selectBox) - 동기 방식
 * @param : 요청 url
 * @param : selectBox id
 * @param : firstOpt > "전체", "선택" 등 첫번째 옵션 추가시 넘긴다.
 */
function gfnSyncAXSelBxUrl(sUrl, obj, firstOpt){

	var isspace = firstOpt != "" ? true : false;

	$("#"+obj).bindSelect({
        reserveKeys: {
            options: "resultList",
            optionValue: "CD",
            optionText: "CDNM"
        },
        ajaxUrl: sUrl,
        ajaxPars: {},
        ajaxAsync: false,
        isspace: isspace,
        isspaceTitle: firstOpt,
        onchange: function(){
        	//console.log(Object.toJSON(this));
        }
    });
}


/*
 * 공통코드(selectBox) - 비동기 방식
 * @param : 그룹코드
 * @param : selectBox id
 * @param : firstOpt > "전체", "선택" 등 첫번째 옵션 추가시 넘긴다.
 */
function gfnAXSelBx(codeId, obj, firstOpt){

	var isspace = firstOpt != "" ? true : false;

	$("#"+obj).bindSelect({
        reserveKeys: {
            options: "resultList",
            optionValue: "CD",
            optionText: "CDNM"
        },
        ajaxUrl: "/common/combo/codeList",
        ajaxPars: {codeId: codeId},
        isspace: isspace,
        isspaceTitle: firstOpt,
        onchange: function(){
        	//console.log(Object.toJSON(this));
        }
    });
}

/*
 * 공통코드(selectBox) - 동기방식
 * @param : 그룹코드
 * @param : selectBox id
 * @param : firstOpt > "전체", "선택" 등 첫번째 옵션 추가시 넘긴다.
 */
function gfnSyncAXSelBx(codeId, obj, firstOpt){

	var isspace = firstOpt != "" ? true : false;

	$("#"+obj).bindSelect({
        reserveKeys: {
            options: "resultList",
            optionValue: "CD",
            optionText: "CDNM"
        },
        ajaxPars: {codeId: codeId},
        ajaxUrl: "/common/combo/codeList",
        ajaxAsync: false,
        isspace: isspace,
        isspaceTitle: firstOpt,
        onchange: function(){
        	//console.log(Object.toJSON(this));
        }
    });
}

/*
 * 공통코드(selectBox) - 비동기 방식
 * @param : 그룹코드
 * @param : selectBox id
 * @param : firstOpt > "전체", "선택" 등 첫번째 옵션 추가시 넘긴다.
 * @param : callBack function
 */
function gfnAsyncAXSelBx(codeId, obj, firstOpt, callbackFunc){

	var isspace = firstOpt != "" ? true : false;

	$("#"+obj).bindSelect({
        reserveKeys: {
            options: "resultList",
            optionValue: "CD",
            optionText: "CDNM"
        },
        ajaxUrl: "/common/combo/codeList",
        ajaxPars: {codeId: codeId},
        ajaxAsync: true,
        isspace: isspace,
        isspaceTitle: firstOpt,
        onchange: function(){
        	//console.log(Object.toJSON(this));
        },
        onLoad: function(){
        	if(callbackFunc && callbackFunc != null && typeof(callbackFunc) == "function"){
   				callbackFunc();
   			}
        }
    });
}

/*
 * 공통코드(selectBox)
 * @param : 그룹코드
 * @param : selectBox id
 * @param : firstOpt > "전체", "선택" 등 첫번째 옵션 추가시 넘긴다.
 * @param : callBack function
 */
function gfnComCdSelBx(codeId, obj, firstOpt, callBackFn, sync){

	sync = sync == null ? true : sync;

    var loop = 0;

    var params = {};
	params["codeId"] = codeId;

    $.ajax({
        url:'/common/combo/codeList',
        type:'post',
        async: sync,
        data: params,
        dataType : "json",
        error:function(){
            //alert('Error');
        },
        success:function(rtnData){

        	$("#"+obj).empty();

        	debugger;
        	if(firstOpt && firstOpt != ""){
                $("#"+obj).get(0).options[0] = new Option(firstOpt, "");
                loop = 1;
            }

            $.each(rtnData, function(idx, ref) {
                $("#"+obj).get(0).options[idx+loop] = new Option(ref.CDNM, ref.CD);
            });

            //if (loop == 1) $("#"+obj+" option:eq(0)").prop("selected", true);

            if (callBackFn) {
                //실행 후 callback function
                try {
                    callBackFn();
                } catch (e){
                    //alert("callback 함수 에러!!");
                }
            }
        }
    });
}

// 코드내용에 코드가 표시 됨
function gfnComCdSelBx2(codeGp, obj, firstOpt, callBackFn, sync){

	sync = sync == null ? true : sync;

    var loop = 0;

    var params = {};
	params["codeGroup"] = codeGp;
	params["order"] = "1";

    $.ajax({
        url:'/common/codeList',
        type:'post',
        async: sync,
        data: params,
        dataType : "json",
        error:function(){
            //alert('Error');
        },
        success:function(rtnData){

        	$("#"+obj).empty();

        	if(firstOpt && firstOpt != ""){
                $("#"+obj).get(0).options[0] = new Option(firstOpt, "");
                loop = 1;
            }

            $.each(rtnData, function(idx, ref) {
                $("#"+obj).get(0).options[idx+loop] = new Option(ref.cd, ref.cdNm);
            });

            //if (loop == 1) $("#"+obj+" option:eq(0)").prop("selected", true);

            if (callBackFn) {
                //실행 후 callback function
                try {
                    callBackFn();
                } catch (e){
                    //alert("callback 함수 에러!!");
                }
            }
        }
    });
}

//코드내용에 코드가 표시 됨 - url이용
function gfnComCdSelBx2UseUrl(reqUrl, params, obj, firstOpt, callBackFn, sync){

	sync = sync == null ? true : sync;

    var loop = 0;

    $.ajax({
        url:reqUrl,
        type:'post',
        async: sync,
        data: params,
        dataType : "json",
        error:function(){
            //alert('Error');
        },
        success:function(rtnData){

        	$("#"+obj).empty();

        	if(firstOpt && firstOpt != ""){
                $("#"+obj).get(0).options[0] = new Option(firstOpt, "");
                loop = 1;
            }

            $.each(rtnData, function(idx, ref) {
                $("#"+obj).get(0).options[idx+loop] = new Option(ref.cd, ref.cdNm);
            });

            //if (loop == 1) $("#"+obj+" option:eq(0)").prop("selected", true);

            if (callBackFn) {
                //실행 후 callback function
                try {
                    callBackFn();
                } catch (e){
                    //alert("callback 함수 에러!!");
                }
            }
        }
    });
}

function gfn_comCdData(codeGp, codeId, firstOpt, callBackFn) {

    $.ajax({
    	url:'/common/codeList',
        type:'post',
        data: {codeGroup: codeGp},
        dataType : "json",
        error:function(){
            //alert('Error');
        },
        success:function(rtnData){
        	callBackFn(rtnData);
        }
    });
}

function gfnSyncComboCodeData(codeGp, callBackFn){

	$.ajax({
        url:'/common/combo/codeList',
        type:'post',
        async: false,
        data: {codeId: codeGp},
        dataType : "json",
        error:function(){
        },
        success:function(rtnData){
        	callBackFn(rtnData);
        }
    });
}

function gfnComCdGrid(codeGp, bSelectStr) {

	var resultData = "";

    $.ajax({
        url:'/common/codeList',
        type:'post',
        async: false,
        data: {codeGroup: codeGp},
        dataType : "json",
        error:function(){
            alert('Error');
        },
        success:function(rtnData){
        	resultData =  rtnData;
        }
    });

    var datas = "";
	for(var i in resultData){
		datas += resultData[i].CD +":"+ resultData[i].CD_NM+";";
	}

	if(bSelectStr != null && bSelectStr != "")datas = ":" + bSelectStr + ";" + datas;

	return datas.substring(0, datas.length-1);

}

//콤마찍기
function gfn_comma(str) {

	try{
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}catch(e){
		return str;
	}


}

/* 필수값 체크 유효성 검사
 * @author :
 * @param  : value
 * @return : true,false
 */
function isRequiredCheck(data){
if(typeof data == "undefined" || data == "" || data == null ){
	return false;
   }
return true;
}

/* 길이 체크 유효성 검사
 * @author :
 * @param  : value
 * @return : true,false
 */
function isLengthCheck(data,start,end){
	var leng = data.length;
	if(leng < start || leng > end){
		return false;
	}
return true;
}


/* 숫자 유효성 검사
 * @author :
 * @param  : value
 * @return : true,false
 */
function isNumberCheck(data) {
	if(isNaN(data) == true) {
		return false;
	} else {
		return true;
	}
 }

 /* 이메일 유효성 검사
  * @author :
  * @param  : value
  * @return : true,false
  */
 function isEmailCheck(data) {
	 var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	 if(regex.test(data) == false) {
		 return false;
	} else {
		return true;
	}
}

 /* 날짜 유효성 검사
  * @author :
  * @param  : date value
  * @return : true,false
  * type = 'yyyy-mm-dd'
  */
 function isDateCheck(d) {
	    // 포맷에 안맞으면 false리턴
	    if(!isDateFormat(d)) {
	        return false;
	    }

	    var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	    var dateToken = d.split('-');
	    var year = Number(dateToken[0]);
	    var month = Number(dateToken[1]);
	    var day = Number(dateToken[2]);

	    // 날짜가 0이면 false
	    if(day == 0) {
	        return false;
	    }

	    var isValid = false;

	    // 윤년일때
	    if(isLeaf(year)) {
	        if(month == 2) {
	            if(day <= month_day[month-1] + 1) {
	                isValid = true;
	            }
	        } else {
	            if(day <= month_day[month-1]) {
	                isValid = true;
	            }
	        }
	    } else {
	        if(day <= month_day[month-1]) {
	            isValid = true;
	        }
	    }

	    return isValid;
	}

 /*  날짜포맷에 맞는지 검사
  * @author :
  * @param  : date value,
  * @return : true,false
  */
 function isDateFormat(d) {
     var df = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
     return d.match(df);
 }

 /*
  * 날짜 윤년여부 검사
  * @author :
  * @param  : year value,
  * @return : true,false
  */
 function isLeaf(year) {
     var leaf = false;

     if(year % 4 == 0) {
         leaf = true;

         if(year % 100 == 0) {
             leaf = false;
         }

         if(year % 400 == 0) {
             leaf = true;
         }
     }

     return leaf;
 }

 /*
  * 숫자체크 함수
  * @author :
  * @param  : Object
  * @return :
  */
 function numChk(obj){
		if(obj.value == null || obj.value == ""){
		return;
	}

	if(isNaN(obj.value)){
		alert(comm_msg.COMM012);
		obj.value = "";
		return;
	}
}

 /*
  * Enter key 이벤트
  * @author :
  * @param  : e, 호출 펑션
  * @return :
  */
 /*function enterEvent(e, fn){
	// alert("11");
		if(e.keyCode == 13){
			eval(fn);
			return false;
		}
		else{
			return true;
		}
	}

*/
 /*
  * 입력 문자 길이 반환 함수
  * @author :
  * @param  : 객체, 표시할객체, 길이
  * @return :
  */
 function returnLength(obj, leng) {
 	var strCount = 0;
 	var tempStr;

 	for(var i=0;i<obj.value.length;i++){
 		tempStr = obj.value.charAt(i);
 		if(escape(tempStr).length > 4) {
 			strCount += 2;
 		} else {
 			strCount += 1 ;
 		}
 	}

 	var isNumber = (strCount>leng)?false:true;
 	if(!isNumber) {
 		alert("길이가 "+leng+"byte를 초과했습니다");
 		obj.value=obj.value.substring(0,obj.value.length-1);
 		strCount = leng;
 	}
 }

 /*
  * replaceAll
  * @author :
  * @param  :
  * @return :
  */
 String.prototype.replaceAll = function( searchStr, replaceStr ){
     return this.split( searchStr ).join( replaceStr );
 }

 /*
  * 특수문자 변경
  * @author :
  * @param  :
  * @return :
  */
 function escapeReplace(vals){
 	return vals.replaceAll("&","&amp").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("'","&#39;").replaceAll("\"","&quot;");
 }

 /*
  * 확장자 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function fnGetExt(file_name){
	 if(file_name == "" || file_name == null){
		 return "";
	 }
	 var ext = "";
	 if(file_name != "" && file_name.length>0){
		 var cnt = file_name.length;
		 for(var i=(cnt-1);i>0;i--){
			 var str = file_name.charAt(i);
			 if(str == "."){
				 break;
			 }
			 else{
				 ext = str+ext;
			 }
		 }
	 }
	 return ext;
 }

 /*
  * 오늘날짜 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function gfn_getStringDateYMD() {
	    var date = new Date();

	    var month;
	    var days;
	    var hour;
	    var min;
	    var sec;

	    if (Number(date.getMonth() + 1) < 10) {
	        month = "0" + Number(date.getMonth() + 1);
	    } else {
	        month = Number(date.getMonth() + 1);
	    }

	    if (Number(date.getDate()) < 10) {
	        days = "0" + date.getDate();
	    } else {
	        days = date.getDate();
	    }

	    var today = {
	        year : String(date.getFullYear()),
	        mon : String(month),
	        day : String(days)
	    };

	    var fullString = today.year + "-" + today.mon + "-" + today.day;

	    return fullString;
}

 /*
  * 오늘날짜 가져오기
  * @author :
  * @param  :
  * @return :
  */
function gfn_getStringDateYYYMMDDHH24MISS() {
	    var date = new Date();

	    var month;
	    var days;
	    var hour;
	    var min;
	    var sec;

	    if (Number(date.getMonth() + 1) < 10) {
	        month = "0" + Number(date.getMonth() + 1);
	    } else {
	        month = Number(date.getMonth() + 1);
	    }

	    if (Number(date.getDate()) < 10) {
	        days = "0" + date.getDate();
	    } else {
	        days = date.getDate();
	    }

	    if (Number(date.getHours()) < 10) {
	    	hour = "0" + date.getHours();
	    } else {
	    	hour = date.getHours();
	    }

	    if (Number(date.getMinutes()) < 10) {
	    	min = "0" + date.getMinutes();
	    } else {
	    	min = date.getMinutes();
	    }

	    if (Number(date.getSeconds()) < 10) {
	    	sec = "0" + date.getSeconds();
	    } else {
	    	sec = date.getSeconds();
	    }

	    var today = {
	        year : String(date.getFullYear()),
	        mon : String(month),
	        day : String(days),
	        hour : String(hour),
	        min : String(min),
	        sec : String(sec),
	    };

	    var fullString = today.year + "-" + today.mon + "-" + today.day + " " + today.hour + ":" + today.min + ":" + today.sec;

	    return fullString;
}

 /*
  * 이번달 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function fnGetStringDateYM() {
	    var date = new Date();

	    var month;

	    if (Number(date.getMonth() + 1) < 10) {
	        month = "0" + Number(date.getMonth() + 1);
	    } else {
	        month = Number(date.getMonth() + 1);
	    }

	    var today = {
	        year : String(date.getFullYear()),
	        mon : String(month)
	    };

	    var fullString = today.year + "-" + today.mon;

	    return fullString;
}


 /*
  * 하루전 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function getStringDateYMD1D(date){
	 var selectDate = date.split("-");
	 var changeDate = new Date();
	 changeDate.setFullYear(selectDate[0], selectDate[1]-1, selectDate[2]-1);

	 var year = changeDate.getFullYear();
	 var month = changeDate.getMonth() + 1;
	 var days = changeDate.getDate();
	 if(month < 10) { month = "0" + month; }
	 if(days < 10) { days = "0" + days; }

	 var resultDate = year + "-" + month + "-" + days;
	 return resultDate;
 }


 /*
  * 일주일전 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function getStringDateYMD7M(date){
	 var selectDate = date.split("-");
	 var changeDate = new Date();
	 changeDate.setFullYear(selectDate[0], selectDate[1]-1, selectDate[2]-7);

	 var year = changeDate.getFullYear();
	 var month = changeDate.getMonth() + 1;
	 var days = changeDate.getDate();
	 if(month < 10) { month = "0" + month; }
	 if(days < 10) { days = "0" + days; }

	 var resultDate = year + "-" + month + "-" + days;
	 return resultDate;
 }

 /*
  * 한달전 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function getStringDateYMD1Mon(date){
	 var selectDate = date.split("-");
	 var changeDate = new Date();
	 changeDate.setFullYear(selectDate[0], selectDate[1]-2);

	 var year = changeDate.getFullYear();
	 var month = changeDate.getMonth() + 1;
	 var days = changeDate.getDate();
	 if(month < 10) { month = "0" + month; }
	 if(days < 10) { days = "0" + days; }

	 var resultDate = year + "-" + month + "-" + days;
	 return resultDate;
 }

 /*
  * 한달후 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function getStringDateYMDAft1Mon(date){
	 var selectDate = date.split("-");
	 var changeDate = new Date();
	 changeDate.setFullYear(selectDate[0], selectDate[1]);

	 var year = changeDate.getFullYear();
	 var month = changeDate.getMonth() + 1;
	 var days = changeDate.getDate();
	 if(month < 10) { month = "0" + month; }
	 if(days < 10) { days = "0" + days; }

	 var resultDate = year + "-" + month + "-" + days;
	 return resultDate;
 }

 /*
  * 1년후 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function getStringDateYMDAft1Year(date){
	 var selectDate = date.split("-");
 /*
	 var changeDate = new Date();
	 changeDate.setFullYear(selectDate[0], selectDate[1] - 1);

	 var year = changeDate.getFullYear() + 1;
	 var month = changeDate.getMonth();
	 var days = changeDate.getDate();
	 if(month < 10) { month = "0" + month; }
	 if(days < 10) { days = "0" + days; }
*/
	 var resultDate = (Number(selectDate[0]) + 1) + "-" + selectDate[1] + "-" + selectDate[2];
	 return resultDate;
 }

 /*
  * 두달전 가져오기
  * @author :
  * @param  :
  * @return :
  */
 function getStringDateYMD2Mon(date){
	 var selectDate = date.split("-");
	 var changeDate = new Date();
	 changeDate.setFullYear(selectDate[0], selectDate[1]-3);

	 var year = changeDate.getFullYear();
	 var month = changeDate.getMonth() + 1;
	 var days = changeDate.getDate();
	 if(month < 10) { month = "0" + month; }
	 if(days < 10) { days = "0" + days; }

	 var resultDate = year + "-" + month + "-" + days;
	 return resultDate;
 }


 function fnNvl(str1, str2){
	 if(str1 == "" || str1 == null || str1 == undefined || str1 == "undefined"){
		 return str2;
	 }else{
		 return str1;
	 }
 }

 /*
  * 입력필드 영문 숫자만 허용
  * @author :
  * @param  :
  * @return :
  */
 function fnAlphaNum(target){
	var target = "#"+target;
	var pattern = /[^(a-zA-Z0-9)]/; //영문, 숫자만 허용
	if(pattern.test($(""+target+"").val())){
		alert("영문, 숫자만 허용 가능합니다.");
		$(""+target+"").val('');
		$(""+target+"").focus();
		return false;
	}

	return true;
}

 /*
  * 입력필드 한글 영문 숫자만 허용
  * @author :
  * @param  :
  * @return :
  */
function fnTextAlphaNum(target){
	var target = "#"+target;
	var pattern = /[^(가-힣a-zA-Z0-9)]/; //한글,영문,숫자만 허용
	if(pattern.test($(""+target+"").val())){
		alert("한글, 영문, 숫자만 허용");
		$(""+target+"").val('');
		$(""+target+"").focus();
		return false;
	}
}

/*
 * 입력필드 영문 숫자 @ . 만 허용
 * @author :
 * @param  :
 * @return :
 */
function fnEmailAlphaNum(target){
	var target = "#"+target;
	var pattern = /[^(a-zA-Z0-9@.)]/; //영문, 숫자, @ . 만 허용
	if(pattern.test($(""+target+"").val())){
		alert("영문, 숫자, @ 만 허용");
		$(""+target+"").val('');
		$(""+target+"").focus();
		return false;
	}
}

/*
 * 한글입력 방지
 * @author :
 * @param  :
 * @return :
 */
function fnHangulChk(obj){
	var id_pattern = new RegExp('[^a-zA-Z0-9]');
	if (id_pattern.test(obj.value)) {
		alert(comm_msg.COMM032);
		obj.value = "";
	    return;
	}
}

/*
 * url 형식
 * @author :
 * @param  :
 * @return :
 */
function fnUrlChk(obj){
	var id_pattern = new RegExp('[^a-zA-Z0-9:/-_?&.=]');
	if (id_pattern.test(obj.value)) {
		alert(comm_msg.COMM033);
		obj.value = "";
	    return;
	}
}


/*
 * byte 체크후 byte 값 표시 및 byte 에 맞게 value 값 설정
 * @author :
 * @param  :
 * @return :
 */
function fnCheckGetByte(objName, idName, TempValue, maxLength)	{

	var OrgText = '';
	var CharLength = 0;
	var OrgCharLength = 0;
	var OrgTextLength = 0;
	var NowLength = TempValue.length;  // 현재 가져온 입력된 길이
	var lineFeedLength = (TempValue.split("\n").length) - 1;
	var OneCharacter = ""; // 한글자씩 넣어둘 임시 변수

	CharLength += lineFeedLength;
	// 저장된 길이와 같은지 비교
	if (NowLength > OrgTextLength) {
		// 저장된 길이 보다 많을 경우 초과된 부분만 비교
		for(var i=OrgTextLength ; i< NowLength ; i++) {
			// 한글자추출
		OneCharacter = TempValue.charAt(i);

		// 한글이면 2를 더한다.
			if (escape(OneCharacter).length > 4){
				CharLength += 2;
			} else{ // 그밗의 경우는 1을 더한다.
				CharLength++;
			}

			// 전체길이를 초과하면
			if(CharLength > maxLength) {
				alert( maxLength + " byte를 초과 입력할수 없습니다. \n초과된 내용은 자동으로 삭제 됩니다. ");
				objName.value = OrgText;
				if(idName != null && idName != ''){
					document.getElementById(idName).innerHTML = OrgCharLength;
				}
				return;
			} else {
				OrgText += OneCharacter;
				OrgTextLength = TempValue.length;
				OrgCharLength = CharLength;
			}
		}
	} else if (NowLength < OrgTextLength) {
		OrgText = "";
		CharLength = 0;
		// 저장된 길이보다 작은 경우 처음부터 검색
		for(var i=0 ; i< NowLength ; i++) {
			// 한글자추출
			OneCharacter = TempValue.charAt(i);

			// 한글이면 2를 더한다.
			if (escape(OneCharacter).length > 4) {
				CharLength += 2;
			} else{ // 그밗의 경우는 1을 더한다.
				CharLength++;
			}

			OrgText += OneCharacter;
		}

		OrgTextLength = TempValue.length;
	}
	if(idName != null && idName != ''){
		document.getElementById(idName).innerHTML = CharLength;
	}
	return;
}

/**
 *
 * 오늘일자 기준으로 특정 요일 구하기
 *
 * @author	진영권
 * @since	2013-08-13
 * @returns	String
 */
function getStringDateYoIl(source) {

	// 0:일요일, 1:월요일, 2:화요일, 3:수요일, 4:목요일, 5:금요일, 6:토요일
	var setYoIl = 0;

	if (source != "undefined" || source != "" || source != null) {
		setYoIl = source;
	}

	var myToday = new Date();
	var myDate = new Date();

	myDate.setYear(myToday.getFullYear());
	myDate.setMonth(myToday.getMonth());
	myDate.setDate(myToday.getDate());
	myDate.setHours(0, 0, 0, 0);

	var setRequireDay = setYoIl;
	while (myDate.getDay() != setRequireDay) {
//		alert( "DAY :: " + myDate.getDay());
		myDate.setDate(myDate.getDate() + 1);
	}

	return myDate;
}

/**
 *
 * 날짜 형태 변환
 *
 * @author	진영권
 * @since	2013-08-13
 * @returns	String
 */
function getStringDateByFlag(source, flag) {

	var returnSource = 0;
	var returnFalg = "-";

	if (source != "undefined" || source != "" || source != null) {
		returnSource = source;
	}

	if (flag != "undefined" || flag != "" || flag != null) {
		returnFalg = flag;
	}

	var flagDate = getStringDateYoIl(returnSource);

	var returnYean = flagDate.getFullYear();
	var returnMonth = (flagDate.getMonth() + 1);
	var returnDate = flagDate.getDate();

	if (returnMonth < 10) {
		returnMonth = "0" + returnMonth;
	}

	return returnYean + returnFalg + returnMonth + returnFalg + returnDate;
}

/**
 *
 * 오늘일자 기준, 돌아오는 토요일 구하기
 *
 * @author	진영권
 * @since	2013-08-13
 * @returns	String
 */
function getStringDateSaturday() {
	return getStringDateByFlag(6, "-");
}

/**
 *
 * 오늘일자 기준, 돌아오는일요일 구하기
 *
 * @author	진영권
 * @since	2013-08-13
 * @returns	String
 */
function getStringDateSunday() {
	return getStringDateByFlag(0, "-");
}

/**
 * 인자로 넘어온 '월'이 '0'보다 작으면 '0'을 더한다
 *
 * @author	진영권
 * @since	2013-08-23
 * @returns	String
 */
//﻿﻿function setAddzero(n) {
    //return n < 10 ? "0" + n: n;
//}

/**
 * 오늘 일자 기준으로 지난 일자를 구한다.
 *
 * @param n 월
 * @param m 년
 * @returns {String}
 */
function getStringBeforeDate(n,m){

     var date = new Date();
     var resDate = new Date(Date.parse(date)-n* 1000 * 60 * 60 * 24);

     if(n < 10){
    	 resDate.setMonth(resDate.getMonth()-n);
     }
     var yyyy = resDate.getFullYear();
     var mm = resDate.getMonth()+1;
     var dd = resDate.getDate();

	return yyyy+'-'+setAddzero(mm)+'-'+setAddzero(dd);

}

/*
 * 년, 월, 일 날짜 셋팅 (selectBox)
 *
 * @author jaehun
 * @param : selectBox id(year)
 * @param : selectBox id(month)
 * @param : selectBox id(day)
 * ex) setDefaultSelectDate("birthYear", "birthMonth", "birthDay");
 */
function setDefaultSelectDate(year, month, day) {
    var yLen = 0;
    for(var i=1900;i<=new Date().getFullYear();i++){
        $("#"+year).get(0).options[yLen] = new Option(i,i);
        yLen++;
    }
    var vMonth = "";
    for(var i=1;i<=12;i++){
        if (i < 10) vMonth = "0" + i;
        else vMonth = i;
        $("#"+month).get(0).options[i-1] = new Option(i,vMonth);
    }

    //dafault year
    $("#"+year).val("1980");

    var vDay = "";
    for(var i=1;i<=new Date($("#"+year+" option:selected").val(), $("#"+month+" option:selected").val(), 0).getDate();i++){
        if (i < 10) vDay = "0" + i;
        else vDay = i;
        $("#"+day).get(0).options[i-1] = new Option(i,vDay);
    }

    $("#"+year+", #"+month).change(function(){
        var lastDate = new Date($("#"+year+" option:selected").val(), $("#"+month+" option:selected").val(), 0);
        var lastDay = lastDate.getDate();

        $("#"+day).empty();
        for(var i=1;i<=lastDay;i++){
            if (i < 10) vDay = "0" + i;
            else vDay = i;
            $("#"+day).get(0).options[i-1] = new Option(i,vDay);
        }
    });
}

/*
 * Input 입력키 막기 (현재 숫자만 처리되어 있음)
 *
 * @author jaehun
 * @param : objId > 다중적용은 , 로 구분
 * @param : inpGb > "number"
 * ime-mode를 반드시 disabled로 설정해야 함.
 * 예) style="ime-mode:disabled"
 */
function inpWrtBlc(objId, inpGb){
    var arrObj = objId.split(",");
    $(function(){
        $.each(arrObj, function(idx, ref) {
            $("#"+$.trim(ref)).keydown(function(e){
                if (inpGb == "number"){
                    //e.altkey == true
                    if((e.keyCode < 48 || e.keyCode > 57) && (e.keyCode < 96 || e.keyCode > 105) && e.keyCode != 8 && e.keyCode != 9 && e.keyCode != 0) return false;
                }
            });
        });
    });
}

/*
 * Get Cookie
 *
 * @author jaehun
 * @param : name
 */
function getCookie(name) {
    var nameOfCookie = name + "=";
    var x = 0;
    while (x <= document.cookie.length) {
        var y = (x+nameOfCookie.length);
        if (document.cookie.substring(x, y)== nameOfCookie) {
            if ((endOfCookie=document.cookie.indexOf(";", y))== -1)
                endOfCookie = document.cookie.length;
            return unescape(document.cookie.substring(y, endOfCookie));
        }
        x = document.cookie.indexOf(" ", x)+ 1;
        if (x == 0)
            break;
    }
    return "";
}

/*
 * Set Cookie
 *
 * @author jaehun
 * @param : name
 * @param : value
 * @param : expiredays 유지기간
 */
function setCookie(name, value, expiredays) {
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate()+ expiredays);
    document.cookie = name + "=" + escape(value)+ "; path=/; expires=" + todayDate.toGMTString()+ ";";
}

/*
 * Clear Cookie
 *
 * @author jaehun
 * @param : name
 * @param : value
 * @param : expiredays 유지기간
 */
function clearCookie(name) {
    var expire_date = new Date();
    //어제 날짜를 쿠키 소멸 날짜로 설정한다.
    expire_date.setDate(expire_date.getDate() - 1);
    document.cookie = name + "= " + "; expires=" + expire_date.toGMTString() + "; path=/";
}

//input title 지정
function gfn_setInputTitle(){
	for(var i=0;i<$("input").length; i++){
		if($("input").eq(i).attr("placeholder") != null){
			$("input").eq(i).attr("title", $("input").eq(i).attr("placeholder"));
		}else if($("input").eq(i).attr("value") != null){
			$("input").eq(i).attr("title", $("input").eq(i).attr("value"));
		}else if($("input").eq(i).text() != null){
			$("input").eq(i).attr("title", $("input").eq(i).text());
		}
	}
}
/* undefined
 * @author :
 * @param  : value
 * @return : value or ''
 */
function isUndefined(data){

	if(typeof data == "undefined" || data == "" || data == null || data == "undefined"){
		data = "";
    }
	return data;
}

/* 문자열 스트링 포맷 변경
 * @author :
 * @param  : 20140808 ->2014-08-08
 * @return : value or ''
 */
function gfn_isStrFormat(str,format){
	try{
		if(typeof str == "undefined" || str == "" || str == null || str == "undefined"){
			str = "";
	    }else{
	    	if(str.length == 6){
	    		str = String(str.substring(0,4)) + format + String(str.substring(4,6));
	    	}else if(str.length == 8){
	    		str = String(str.substring(0,4)) + format + String(str.substring(4,6)) + format + String(str.substring(6,8));
	    	}
	    }
	}catch(e){
		str = "";
	}
	return str;
}

/* 현재일로부터 day만큼 증가한 날짜를 리턴
 * @author :
 * @param  : 20140808 ->2014-08-08
 * @return : value or ''
 */
function getCalDate(day){

	var caledmonth, caledday, caledYear, returnDay;
	var loadDt = new Date();
	var v = new Date(Date.parse(loadDt) + day*1000*60*60*24);

	caledYear = v.getFullYear();

	if( v.getMonth() < 9 ){
		caledmonth = '0'+(v.getMonth()+1);
	}else{
		caledmonth = v.getMonth()+1;
	}

	if( v.getDate() < 9 ){
		caledday = '0'+v.getDate();
	}else{
		caledday = v.getDate();
	}

	returnDay = caledYear+"-"+caledmonth+"-"+caledday;

	return returnDay;

}

function getCalUserDate(date, day){

	var caledmonth, caledday, caledYear, returnDay;
	var loadDt = new Date(date);
	var v = new Date(Date.parse(loadDt) + day*1000*60*60*24);

	caledYear = v.getFullYear();
/*
	if( v.getMonth() < 9 ){
		caledmonth = '0'+(v.getMonth()+1);
	}else{
		caledmonth = v.getMonth()+1;
	}
*/
	caledmonth = lpad(v.getMonth()+1, 2, "0");
/*
	if( v.getDate() < 9 ){
		caledday = '0'+v.getDate();
	}else{
		caledday = v.getDate();
	}
	*/

	caledday = lpad(v.getDate(), 2, "0");

	returnDay = caledYear+"-"+caledmonth+"-"+caledday;

	return returnDay;

}

function fnCommonAjaxGet(actionUrl, paramObj, callBackFn ) {

	if(actionUrl == ""){
		return;
	}

    $.ajax({
        url:actionUrl,
        type:'get',
        data: paramObj,
        dataType : "json",
        error : function(data) {

        },
        success:function(rtnData){

            if (callBackFn) {
                //실행 후 callback function
                try {

                    callBackFn(rtnData);

                } catch (e){
                }
            }
        }
    });
}

function fnCommonAjaxPost(actionUrl, paramObj, callBackFn ) {

	if(actionUrl == ""){
		return;
	}

    $.ajax({
        url:actionUrl,
        type:'post',
        data: paramObj,
        dataType : "json",
        error : function(data) {
        },
        success:function(rtnData){

            if (callBackFn) {
                //실행 후 callback function
                try {

                    callBackFn(rtnData);

                } catch (e){
                }
            }
        }
    });
}

function gfn_callPostJsonData(url, data, callBackFn, syncType){

	syncType = syncType == null ? true : syncType;

    $.ajax({
        url:url,
        type:'post',
        data:data,
        dataType : "json",
        async: syncType,
		cache: false,
		beforeSend : function(){
	 	},
        error:function(request,status,error){

    		//alert("요청 처리 중 오류가 발생하였습니다.");
    		unblockUI();
        },
        success:function(rtnData){

        	//unblockUI();
        	if(callBackFn != null)callBackFn(rtnData);
        },
        complete: function(){
		}
    });
}

/**
 * @param obj
 * @returns {Boolean}
 */
function gfn_chkNvl(obj){
	 if(obj == null || obj == "" || obj == "undefined" || obj == undefined || (typeof(obj) == "string" && obj.trim() == "")){
		 return true;
	 }else{
		 return false;
	 }
}

function gfn_nvl(obj){
	 if(obj == null || obj == "" || obj == "undefined" || obj == undefined || (typeof(obj) == "string" && obj.trim() == "") || obj == "null"){
		 return "";
	 }else{
		 return obj;
	 }
}

//숫자형태로 변환
function gfn_toInt(val){
	if(gfn_chkNvl(val))return 0;

	try{
		val = Number(val);
	}catch(e){
		return 0;
	}

	return val;
}


function cutStr(str, limit){

	var strLength = 0;
	var strTitle = "";
	var strPiece = "";

	for (var i = 0; i < str.length; i++){
		var code = str.charCodeAt(i);
		var ch = str.substr(i,1).toUpperCase();
		//체크 하는 문자를 저장
		strPiece = str.substr(i,1);

		code = parseInt(code);

		if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
			strLength = strLength + 3; //UTF-8 3byte 로 계산
		}else{
			strLength = strLength + 1;
		}

		if(strLength>limit){ //제한 길이 확인
			break;
		}else{
			strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
		}

	}
	return strTitle;
}

// 문자열 길이(byte)
function fnGetStringByte(str){
	return str.replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length;
}

//콤마찍기
function comma(str) {
  str = String(str);
  return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//콤마풀기
function uncomma(str) {
  str = String(str);
  return str.replace(/[^\d]+/g, '');
}


function fnGoPage(url){

	location.href = url;

}

function fnCallParentFunc(funcNm){
	try{
		// 활성 frame 찾기
		var activeFrame = parent.$("#contents > div[aria-hidden=false] > iframe").attr("id");
		eval("parent.$('#"+activeFrame+"').get(0).contentWindow."+funcNm);

	}catch(e){
	}
}

function onlyIP(obj){
	obj.value = obj.value.replace(/[^0-9\.]/gi,"");
}

function onlyNum(obj){
	obj.value = obj.value.replace(/[^0-9]/gi,"");
}

function phoneNum(obj){
	obj.value = obj.value.replace(/[^0-9\-]/gi,"");
}

function emailType(obj){
	obj.value = obj.value.replace(/[^(a-zA-Z0-9@.)]/gi,"");
}

// 입력값 초기화
function gfnResetValue(){

	// input 초기화
	$(".body input").not("[type=submit]").val("");

	// textarea 초기화
	$(".body textarea").val("");

	// select 초기화
	$(".body select").bindSelectSetValue("");

}

// ie 브라우저 확인
function gfnChkIeBrowser(){

	var agent = navigator.userAgent.toLowerCase(),
    name = navigator.appName;

	// MS 계열 브라우저를 구분하기 위함.
	if(name === 'Microsoft Internet Explorer' || agent.indexOf('trident') > -1 || agent.indexOf('edge/') > -1) {
		return true;
	}else{
		return false;
	}


}

function phoneFormat(obj){
	try{
		var reObj = obj.replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-");

		if(reObj == ""){
			reObj = obj;
		}
		return reObj;
	}catch(e){
		return obj;
	}
}

function fnOnlyNum(e){

	var e = e || window.event;
	var keyCode	= (e.which) ? e.which : e.keyCode;

	if(keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 39){
		return;
	}else{
		e.target.value = e.target.value.replace(/[^0-9]/g, '');
	}
}

function fnParseNum(val){

	try{
		return Number(val);
	}catch(e){
		return 0;
	}
}



// 통합검색시 검색어 체크
/*function textChk(){
	if (topFrm_top.gnb_search.value.replace(/\s/gi,"").length > 20) {
		alert("20글자 까지 검색할수 있습니다.");
		topFrm_top.gnb_search.value=topFrm_top.gnb_search.value.slice(0,20);
		return;
	}   
	if(checkUID(topFrm_top.gnb_search.value) == false){
		alert("특수문자는 사용할수 없습니다."); 
		topFrm_top.gnb_search.value=repUID(topFrm_top.gnb_search.value);
		return;
	}
}  
*/

function checkUID(objEv){
	var result=true;		
	 var num = "{}[]()<>?|`~'!@#$%^&*-+=,.;:\"'\\/";
	 var bFlag = true;

	 for (var i = 0;i < objEv.length;i++)	
	 {
	  if(num.indexOf(objEv.charAt(i)) != -1)
	   bFlag = false;
	 }
	 
	 if (!bFlag){ 
		 result = false;
	 }
	return result;
}

function repUID(objEv){
	
	 // 특수 문자 모음 
	 // "{}[]()<>?|`~'!@#$%^&*-+=,.;:\"'\\/ "  
	 var num = "{}[]()<>?|`~'!@#$%^&*-+=,.;:\"'\\/";
	 var bFlag = true;

	 for (var i = 0;i < objEv.length;i++){			 
	  if(num.indexOf(objEv.charAt(i)) != -1){
		  objEv = objEv.replace(objEv.charAt(i),''); 
	  }		 
	 }
	
}

/* 모달 애니메이션 */

var $button         = $('.button'),
    $modalContainer = $('#modal-container'),
    $body           = $('body'),
    $content        = $('.content'),
    btnId;

$button.on('click', function () {
  btnId = $(this).attr('id');
  
  $modalContainer
      .removeAttr('class')
      .addClass(btnId);
  $content
      .removeAttr('class')
      .addClass('content');
  
  $body.addClass('modal-active');
  
  if (btnId == 'two' || btnId == 'three'|| btnId == 'four') {
    $content.addClass(btnId);
  }
  
});

$modalContainer.on('click', function () {
  $(this).addClass('out');
  $body.removeClass('modal-active');
  if ($(this).hasClass(btnId)) {
    
    $content.addClass('out');
    
  }
});