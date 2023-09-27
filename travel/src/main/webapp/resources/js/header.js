
/* nav */
$(function(){
    var lnb = $('.lnb_nav_wrap'),
        depth2 = $(".lnb_nav .depth2");

    $(".lnb_nav_link").on('mouseenter focusin', function(event){
        event.preventDefault ();
        depth2.slideDown();
        var depth1HoverActive = $(this).closest("li").hasClass("hover");
        if(!depth1HoverActive){
            lnb.find("li").removeClass("hover");
            $(this).closest("li").addClass("hover");
        }
        $(".nav_bg").slideDown();
    });

    depth2.on('mouseenter focusin', function(event){
        var depth2HoverActive = $(this).closest("li").hasClass("hover");
        if(!depth2HoverActive){
            lnb.find("li").removeClass("hover");
            $(this).closest("li").addClass("hover");
        }
    });

    lnb.mouseleave(function(){
        depth2.stop().slideUp();
        $(".nav_bg").slideUp();
        lnb.find("li").removeClass("hover");
    });
})

/* 로그인&회원가입 이동 */
$(function(){
    $(".signup .btn").on('click',function(event){
        $(this).siblings(".list").addClass('active');
        $(".signup .gnb_site .list a").attr("tabindex","0");
    });
    $(".signup").on('mouseleave',function(event){
        $(".signup .list").removeClass('active');
        $(".signup .gnb_site .list a").attr("tabindex","-1");
    });
});