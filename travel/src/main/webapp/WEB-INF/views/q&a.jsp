<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<style>


  body {
    font-family: 'Arial', sans-serif;
    background-color: white;
    margin: 0;
    padding: 0;
   
  }



  table {
    
    margin: 20px auto;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;

  }

@font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

.tdtitle {
font-family: 'SUIT-Regular';
font-weight:500;
}


  th, td {
    padding: 12px;
    text-align: center;
    
    border: none !important; /* 세로 줄 없애기 */
    border-bottom: 1px solid #ddd !important; /* 가로 줄만 남기기 */
  }

  th {
    background-color: transparent !important;
    border-bottom: 1px solid grey !important;
    border-top:2px solid black !important;
    color: black !important;
  }
  
  
  /* Add some spacing between table rows */
#tblBoard tbody tr {
    margin-bottom: 10px; /* Adjust the value to your preference */
}

/* Increase padding for td elements */
#tblBoard tbody td {
    padding: 10px; /* Adjust the value to your preference */
}
  



  button.btnPrev {
    background-color: #e74c3c;
    color: #fff;
    border: none;
    padding: 12px 20px;
    cursor: pointer;
    position: relative;
    left: 20%;
    font-family: 'Verdana', sans-serif;
  }

  button.btnPrev:hover {
    background-color: #c0392b;
  }

  button#btnWrite {
    background-color: #D8D8D8;
    color: black;
    border: none;
    padding: 12px 20px;
    cursor: pointer;
    font-family: 'Verdana', sans-serif;
    
  }
  
  
  button#btnlogin {
  	background-color: #D8D8D8;
    color: black;
    border: none;
    padding: 12px 20px;
    cursor: pointer;
    font-family: 'Verdana', sans-serif;
  }

  button#btnWrite:hover {
    background-color: #A4A4A4;
  }

  .pdiv {
    text-align: left;
    margin-top: 10px;
  }

  .wDiv {
    text-align: center;
    margin-top: 10px;
  }

  p {
    font-weight: bold;
  }

  a {
    text-decoration: none;
    color: #3498db;
    margin: 0 10px;
  }

  a:hover {
    text-decoration: underline;
  }
  
  

  #prevNext {
    text-align: center;
  }

  #pagestr-container {
    text-align: center;
    margin-top: 20px;
    font-size: 18px;
  }

  #pagestr-container a {
    text-decoration: none;
    color: #555;
    margin: 0 5px;
    padding: 8px 12px;
    border: 1px solid #999;
    border-radius: 5px;
    background-color: #f7f7f7;
    transition: background-color 0.3s ease, color 0.3s ease;
  }

  #pagestr-container a:hover {
    background-color: #999;
    color: #fff;
  }

  #tblBoard tbody tr:hover {
    cursor: pointer;
  
  }
  
  #tblBoard {
  	
  margin: 10% auto 0; /* 위쪽 여백을 30px로 조절 */
    width: 80%; /* 화면 너비의 70%로
  }
  

 .q&a-container {
            text-align: center; /* 이미지와 텍스트를 가운데로 정렬하기 위한 스타일 */
            position: relative; /* 포지션을 설정하여 하위 요소를 조작 */
            
     
        }

        .q&aimg img {
            max-width: 100%; /* 이미지 크기를 부모 요소에 맞게 조절 */
	
        }
        
        .qandaimg {
        	height:500px;
        	width:100%;
        }

        .imga {
            position: absolute; /* 포지션을 설정하여 이미지 위에 위치시킴 */
            top: 23%; /* 상단 여백을 50%로 설정하여 세로 중앙 정렬 */
            left: 50%; /* 왼쪽 여백을 50%로 설정하여 가로 중앙 정렬 */
            transform: translate(-50%, -400%); /* 50% 만큼 이동하여 가운데 정렬 */
        
            padding: 10px; /* 텍스트 주위에 여백 추가 (선택 사항) */
            text-align:center;
            
        }
        
        
        @font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

        .imga a {
        
        font-family: 'Pretendard-Regular';
            font-size: 20px;
            font-weight: 400;
            line-height: 32px;
            color: white;
            text-decoration: none;
            
        }
        
        .imga a:hover{
        	color:white;
        	text-decoration:none;
        }
        
        .popular {
        	margin-left:15%;
        	margin-bottom:1%;
        }
        
        .popular tbody > tr:hover {
        	background-color:#ccc;
        }
        
        @font-face {
    font-family: 'GangwonState';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/GangwonState.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

.poph3 {
	font-family: 'GangwonState';
	font-weight:bold;
	font-size: 25px;
}
        
        @font-face {
    font-family: 'Happiness-Sans-Title';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/Happiness-Sans-Title.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
        
        
        
.mid {
	text-align:center;	
}   

.mid p, .mid h1 {
font-family: 'Happiness-Sans-Title';
}

.mid h1 {
	color:darkgrey;
}

.mid p {
	font-size:20px;
}

@font-face {
    font-family: 'LINESeedKR-Bd';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

.tbfirst{
	font-family: 'LINESeedKR-Bd';
}     

#btnTravelTips,#btnWrite,#btnlogin {
    border: 1px solid black !important;
    background-color: #D8D8D8 !important;
    color: black !important;
    padding: 12px 20px !important;
    cursor: pointer !important;
    font-family: 'Verdana', sans-serif !important;
    border-radius: 5px !important;
    transition: background-color 0.3s ease, color 0.3s ease !important;
}

/* 버튼에 호버 스타일 추가 */
button:hover {
    background-color: #A4A4A4 !important;
    color: white !important;
}    


  .popular {
        margin-left:15%;
    }

    .poph3 {
        font-size: 24px; /* 원하는 제목 크기 설정 */
    }

    .poplist-container {
        display: flex; /* Flexbox를 사용하여 내용 정렬 */
        align-items: flex-start; /* 아이템을 위로 정렬 */
    }

    .poplist {
        margin-left: 15%;
        width:50%;
        margin-right: 20px; /* 원하는 간격 설정 */
        
   
    }

  
  @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

    .popitem {
        border: 1px solid #ccc; /* 테두리 설정 */
        padding: 30px; /* 안쪽 여백 설정 */
        margin-bottom: 10px; /* 아래 여백 설정 */
        font-family: 'GmarketSansMedium';
             cursor:pointer;
        border-radius:10px;
    }

    /* 제목 스타일링 예제 */
    .popitem h1 {
        font-size: 20px; /* 원하는 글꼴 크기 설정 */
        margin: 0; /* 위 아래 여백 제거 */
    }

    /* 답변수, 조회수, 작성일자 스타일링 예제 */
    .popitem p {
        margin: 5px 0; /* 위 아래 여백 설정 */
        font-size: 13px;
        color: #535353;
    }

    .btm {
        text-align: right;
        font-size: 10px;
        display:flex;
        margin-left: 72%;
    }


.catea buttons {
	background: url(data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30.018' viewBox='0 0 30 30.018'%3E%3Cdefs%3E%3CclipPath id='a'%3E%3Cpath data-name='사각형 322' fill='none' d='M0 0h30v30.018H0z'/%3E%3C/clipPath%3E%3C/defs%3E%3Cg data-name='그룹 3347'%3E%3Cg data-name='그룹 3346' clip-path='url(%23a)' fill='none' stroke='%23fff' stroke-width='2'%3E%3Cpath data-name='사각형 318' d='M1.145 1.145h11.227v11.227H1.145z'/%3E%3Cpath data-name='사각형 319' d='M17.628 1.145h11.227v11.227H17.628z'/%3E%3Cpath data-name='사각형 320' d='M1.145 17.646h11.227v11.227H1.145z'/%3E%3Cpath data-name='사각형 321' d='M17.628 17.646h11.227v11.227H17.628z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E);

}
.catea {
	text-align:center;
}

.allbtn {
    background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30.018' viewBox='0 0 30 30.018'%3E%3Cdefs%3E%3CclipPath id='a'%3E%3Cpath data-name='사각형 322' fill='none' d='M0 0h30v30.018H0z'/%3E%3C/clipPath%3E%3C/defs%3E%3Cg data-name='그룹 3347'%3E%3Cg data-name='그룹 3346' clip-path='url(%23a)' fill='none' stroke='%23fff' stroke-width='2'%3E%3Cpath data-name='사각형 318' d='M1.145 1.145h11.227v11.227H1.145z'/%3E%3Cpath data-name='사각형 319' d='M17.628 1.145h11.227v11.227H17.628z'/%3E%3Cpath data-name='사각형 320' d='M1.145 17.646h11.227v11.227H1.145z'/%3E%3Cpath data-name='사각형 321' d='M17.628 17.646h11.227v11.227H17.628z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    background: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30.018' viewBox='0 0 30 30.018'%3E%3Cdefs%3E%3CclipPath id='a'%3E%3Cpath data-name='사각형 322' fill='none' d='M0 0h30v30.018H0z'/%3E%3C/clipPath%3E%3C/defs%3E%3Cg data-name='그룹 3347'%3E%3Cg data-name='그룹 3346' clip-path='url(%23a)' fill='none' stroke='%23a1a1a1' stroke-width='2'%3E%3Cpath data-name='사각형 318' d='M1.145 1.145h11.227v11.227H1.145z'/%3E%3Cpath data-name='사각형 319' d='M17.628 1.145h11.227v11.227H17.628z'/%3E%3Cpath data-name='사각형 320' d='M1.145 17.646h11.227v11.227H1.145z'/%3E%3Cpath data-name='사각형 321' d='M17.628 17.646h11.227v11.227H17.628z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") no-repeat center top 20px/30px auto;
    height: 100%; transition: transform .2s ease, padding .2s ease;display:inline-block
}


.landmark{
background: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='36.983' height='27.597' viewBox='0 0 36.983 27.597'%3E%3Cg data-name='그룹 64' transform='translate(-453.953 -441.175)' fill='none' stroke='%23a1a1a1' stroke-width='2'%3E%3Cpath data-name='패스 18463' d='M456.047 467.123l11.214-10.431 11.316 10.666' stroke-linecap='round' stroke-linejoin='round'/%3E%3Cpath data-name='패스 18464' d='M471.213 460.368l3.951-3.677 10.4 9.8' stroke-linecap='round' stroke-linejoin='round'/%3E%3Cpath data-name='패스 18465' d='M463.746 452.537a2.657 2.657 0 1 1-2.657-2.657 2.657 2.657 0 0 1 2.657 2.657z' stroke-miterlimit='10'/%3E%3Crect data-name='사각형 32' width='31.485' height='22.389' rx='4' transform='translate(454.953 445.206)' stroke-miterlimit='10'/%3E%3Cpath data-name='패스 18466' d='M458.451 444.974a2.8 2.8 0 0 1 2.8-2.8h25.887a2.8 2.8 0 0 1 2.8 2.8v16.792a2.8 2.8 0 0 1-2.8 2.8h-1.9' stroke-miterlimit='10'/%3E%3C/g%3E%3C/svg%3E") no-repeat center top 22px/35px auto;
}


.food {
background: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='38.811' height='20.865' viewBox='0 0 38.811 20.865'%3E%3Cg data-name='그룹 62' fill='grey' stroke='%23a1a1a1' stroke-linejoin='round' stroke-width='2'%3E%3Cpath data-name='패스 18462' d='M19.406 4.079A15.786 15.786 0 0 0 3.62 19.865h31.572A15.786 15.786 0 0 0 19.406 4.079z'/%3E%3Cpath data-name='선 2' d='M0 19.865h38.811'/%3E%3Cpath data-name='선 3' d='M19.406 4.079V0'/%3E%3C/g%3E%3C/svg%3E") no-repeat center top 26px/39px auto;
}

.etc {
background: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='36.16' height='27.025' viewBox='0 0 36.16 27.025'%3E%3Cg data-name='그룹 68' fill='grey' stroke='%23a1a1a1' stroke-linecap='round' stroke-linejoin='round' stroke-width='2'%3E%3Cpath data-name='패스 18473' d='M20.907 11.855c0-4.251-4.456-7.7-9.953-7.7s-9.953 3.446-9.953 7.7c0 3.569 3.147 6.562 7.41 7.432l3.515 6.738-.617-6.488c5.33-.146 9.598-3.524 9.598-7.682z'/%3E%3Cpath data-name='패스 18474' d='M31.568 1h-14.79a3.593 3.593 0 0 0-3.592 3.592v6.8a3.593 3.593 0 0 0 3.592 3.592h8.56l-.757 7.966 4.155-7.966h2.831a3.592 3.592 0 0 0 3.592-3.592v-6.8A3.592 3.592 0 0 0 31.568 1z'/%3E%3C/g%3E%3C/svg%3E") no-repeat center top 27px/34px auto;
}

.popimg {
	height:500px;
	margin-top:2%;
}

@font-face {
    font-family: 'SUIT-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

.catea input[type="button"] {
font-family: 'SUIT-Regular';
color:white;
font-weight:bold;
}

.logplease{
	text-align:center !important;
}


        
</style>
</head>

<%@include file="header.jsp"%>
<body>
<br><br>

<div class="q&a-container">

        <div class="q&aimg">
            <img src="https://www.visitjeju.net/image/knowledge/bg_wide.jpg" class="qandaimg">
        </div>
        
        <div class="imga">
            <a>여행에 관한 모든 궁금한점을 남겨주세요.</a>
            <br>
            <a>전문가를 비롯해 제주를 잘 아는 사람이라면 누구에게라도 답변 받을 수 있습니다</a>
        </div>
    </div>



<br><br><br><br><br><br>




<!-- 조회수 높은 두가지 출력 -->
<div class="popular">
    <h3 class="poph3">많이 본 Q&A</h3>
</div>

<div class="poplist-container">
    <div class="poplist">
        <c:forEach items="${popularPosts}" var="post">
            <div class="popitem">
                <h1>${post.title}</h1>
                <br>
                <p>${post.content }</p>
                <div class="btm">
                    <p style="color:#A4A4A4; font-size:10px;">답변수: ${post.answer_count}</p>&nbsp;&nbsp;
                    <p style="color:#A4A4A4; font-size:10px;">조회수: ${post.hit}</p>&nbsp;&nbsp;
                    <p style="color:#A4A4A4; font-size:10px;">작성일자:${post.created}</p>
                    <p style="display:none;" class="pseq">${post.seqno }</p>
                </div>
            </div>
            <br><br>
        </c:forEach>
    </div>
    <div class="popimg">
        <img src="https://www.visitjeju.net/image/knowledge/banner.png" alt="여행 팁 이미지">
    </div>
</div>

<br><br><br>


<div class="catea">
    <input type="button" value="전체보기" class="allbtn" style="width:150px;
        height:150px; border-radius:10px; background-color:#ef6d00; margin-right: 0; cursor:pointer;">
    <input type="button" value="관광지" class="landmark" style="width:150px;
        height:150px; border-radius:10px; background-color:#ef6d00; margin-right: 0; cursor:pointer;">
    <input type="button" value="음식점" class="food" style="width:150px;
        height:150px; border-radius:10px; background-color:#ef6d00; margin-right: 0; cursor:pointer;">
    <input type="button" value="기타" class="etc" style="width:150px;
        height:150px; border-radius:10px; background-color:#ef6d00; margin-right: 0; cursor:pointer;">
</div>


  
        


<table id="tblBoard">
    <thead>
    <tr> 
        <th style="display:none;">번호</th>
        <th>제목</th>
        <th>카테고리</th>
        <th>답변수</th>
        <th>작성일</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${blist}" var="bpost">
        <tr>
            <td style="display:none;">${bpost.seqno}</td>
            <td class="tdtitle">
                <c:choose>
                    <c:when test="${bpost.answer_count > 0}">
                       <span style="color: #ef6d00;">[답변]</span> ${bpost.title}
                    </c:when>
                    <c:otherwise>
                        <span style="font-family: 'SUIT-Regular';">${bpost.title}</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td style="font-family: 'SUIT-Regular';">${bpost.category}</td>
            <td style="font-family: 'SUIT-Regular';">${bpost.answer_count}</td>
            <td style="font-family: 'SUIT-Regular';">${bpost.created}</td>
            <!-- 조회수ㅡ -->
            <td style="display:none;">${bpost.hit}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<br><br><br><br>

<table>
<tr>
    <td id="prevNext">
        <div id="pagestr-container" align="center">${pagestr}</div>
        <br><br>
        
            </td>
</tr>
</table>

<br><br>
        
        
        
        <c:if test="${not empty sessionScope.id}">
            <div class="wDiv">
                <button id="btnWrite" class="btnWrite">글쓰기</button>
            </div>    
        </c:if>
        
         <c:if test="${empty sessionScope.id}">
        <div class="logplease">
        <button id="btnlogin" class="btnlogin">글쓰기</button> 
          
            </div>
        </c:if>
      
     

<br><br><br>
<%@include file="footer.jsp"%>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
  
    function filter(category) {
       
        $('#tblBoard tbody tr').show();

      
        if (category !== 'all') {
            $('#tblBoard tbody tr').each(function () {
                const categoryC = $(this).find('td:eq(2)').text(); // 카테고리 열 위치
                if (categoryC !== category) {
                    $(this).hide();
                }
            });
        }
    }
    
    
    $('.popitem').click(function () {
        const seqno = $(this).find('.pseq').text();
        window.location.href = '/view?seqno=' + seqno;
    });

 
    $('.allbtn').click(function () {
        filter('all');
    });

    $('.landmark').click(function () {
        filter('관광지');
    });

    $('.etc').click(function () {
        filter('기타');
    });
    
    $('.food').click(function(){
    	filter('음식점');
    })

    $(document)
        .on('click', '#tblBoard tbody tr', function () {
            document.location = '/view?seqno=' + $(this).find('td:eq(0)').text();
            return false;
        })

        .on('click', '#btnWrite', function () {
            window.location.href = "/write";
        });

    $('#btnlogin').click(function () {
    	if(confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?')){
        window.location.href = "/login";
    	}
    });
</script>

</html>
