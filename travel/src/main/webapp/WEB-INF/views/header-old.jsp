<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<style>
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

.header {
    display: flex;
    justify-content: center;
    align-items: center;
    border-top: 1px solid black;
    border-bottom: 1px solid blue;
    height: 100px;
    background-color: rgba(0, 0, 0, 0.4);
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    z-index: 2;
}

.header ul {
    list-style: none;
    margin: 0;
    padding: 0;
    margin-left: 150px;
}

.header li {
    float: left;
    margin-right: 40px;
    margin-left: 40px;
    position: relative;
}

.header a {
    text-decoration: none;
    color: black;
    font-weight: bold;
    font-family: 'Pretendard-Regular';
}

.linkoflog {
    position: relative;
    left: 600%;
    font-size: 15px;
    margin-top: 15%;
}

#search-icon {
    position: absolute;
  	
  	margin-left:100px;
    height: 30px;
    width: 30px;
}

.sub-menu {
    position: absolute;
    left: -250px;
    top: 110%;
    padding: 10px;
    display: flex;
    flex-direction: row;
    min-width: 200px;
    max-width: 500px;
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
    display: none;
    z-index: 2;
    border: 1px solid black;
}

.sub-menu li {
    padding: 5px 0;
    text-align: center;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.sub-menu.active {
    display: flex !important;
}

.header:hover {
    background-color: #EFF8FB;
}

.header:hover .menu {
    color: black;
}

.menu {
    font-size: 25px;
    color: white;
}

.search-container {
	position:absolute;


	display:none;
}

.search-container-visible{
	display:block;
}

.search-icon-unvisible{
	display:none;
}

</style>
<body>
<div class="header">
<a href="/"><img src="/img/logo/TravelJEJU.png" style="width:150px; margin-left:0;"></a>
    <header>
        <ul>
            <li><a href="#" class="menu">여행지</a>
                <ul class="sub-menu">
                    <li><a href="/travel_list">관광지</a></li>
                    <li><a href="#">음식</a></li>
                </ul>
            </li>
            <li><a href="#" class="menu">메뉴2</a>
                <ul class="sub-menu">
                    <li><a href="#">서브3</a></li>
                    <li><a href="#">서브4</a></li>
                </ul>
            </li>
            <li><a href="#" class="menu">메뉴3</a>
                <ul class="sub-menu">
                    <li><a href="#">서브5</a></li>
                    <li><a href="#">서브6</a></li>
                </ul>
            </li>
            <li><a href="#" class="menu">My Page</a>
            	<ul class="sub-menu">
            		<li><a href="#">찜한 여행지</a></li>
            		<li><a href="#">나의 질문</a></li>
            		<li><a href="#">나의 리뷰</a></li>
            		<li><a href="#">정보 수정</a></li>
            	</ul>
            </li>
            <li>
                <a href="#">
                    <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"
                        id="search-icon">
                </a>
                
                <div id="search-container" class="search-container">
   				 <input type="text" id="search-input" placeholder="검색어를 입력하세요">
   				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   				 &nbsp;&nbsp;&nbsp;&nbsp;
   				 <button id="search-close-button">닫기</button>
				</div>
                
            </li>
            <c:if test="${id == null}">
            <li><a href="/login" class="linkoflog">로그인</a></li>
            </c:if>
            <c:if test="${id != null}">
            <li><a href="/logout" class="linkoflog">로그아웃</a><li>
            </c:if>
        </ul>
        
    </header>
    
</div>

</body>


<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
    // 헤더 요소에 마우스 휠 이벤트를 추가
    $(".header").on("wheel", function (event) {
        if (event.originalEvent.deltaY > 0) {
            // 마우스 휠을 아래로 스크롤할 때
            $(this).addClass("header-scroll");
        } else if (event.originalEvent.deltaY < 0) {
            // 마우스 휠을 위로 스크롤할 때
            $(this).removeClass("header-scroll");
        }
    });

    // 서브 메뉴가 열려있는지 여부를 나타내는 변수
    var subMenuOpen = false;

    // 요소에 마우스를 올렸을 때 서브 메뉴를 표시하고 header:hover를 추가
    $(".menu").mouseenter(function () {
        var subMenu = $(this).siblings(".sub-menu");
        subMenu.addClass("active");
        subMenuOpen = true;
        $(".header").addClass("header:hover"); // menu에 마우스를 올릴 때 header:hover 추가
    });

    // 요소에서 마우스가 떠났을 때 서브 메뉴 닫기
    $(".menu").mouseleave(function () {
        if (subMenuOpen) {
            var subMenu = $(this).siblings(".sub-menu");
            // 서브 메뉴에서 마우스가 떠나면 서브 메뉴를 500밀리초 후에 닫음
            if (!subMenu.is(":hover")) {
                subMenu.removeClass("active");
                subMenuOpen = false;
                $(".header").removeClass("header:hover"); // menu에서 마우스가 떠날 때 header:hover 제거
            }
        }
    });

    // 서브 메뉴에 마우스를 올렸을 때 열려있도록 처리
    $(".sub-menu").mouseenter(function () {
        clearTimeout(subMenuTimeout);
        subMenuOpen = true;
    });

    // 서브 메뉴에서 마우스가 떠났을 때 닫기
    $(".sub-menu").mouseleave(function () {
        var subMenu = $(this);
        // 서브 메뉴에서 마우스가 떠나면 서브 메뉴를 500밀리초 후에 닫음
        setTimeout(function () {
            if (!subMenu.is(":hover")) {
                subMenu.removeClass("active");
                subMenuOpen = false;
            }
        }, 500);
    });

    // 다른 곳을 클릭하면 서브 메뉴 닫기
    $(document).click(function (e) {
        if (!$(e.target).closest(".header").length) {
            $(".sub-menu").removeClass("active");
            subMenuOpen = false;
            $(".header").removeClass("header:hover"); 
        }
    });
    
    
    $("#search-icon").click(function (event) {
        event.preventDefault();
        $("#search-container").addClass("search-container-visible");
        $('#search-icon').addClass("search-icon-unvisible")
        $("#search-input").focus(); 
    });

    
    $("#search-close-button").click(function (event) {
        event.preventDefault();
        $("#search-container").removeClass("search-container-visible");
        $('#search-icon').removeClass("search-icon-unvisible");
        $("#search-input").val(""); 
    });
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
});


</script>
</html>
