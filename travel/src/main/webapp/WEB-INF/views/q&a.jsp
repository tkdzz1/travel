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

  h1 {
    text-align: center;
    background-color: #333;
    color: #fff;
    padding: 20px 0;
    margin: 0;
    font-family: 'Verdana', sans-serif;
  }

  table {
    width: 100%;
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
font-family: 'TheJamsil5Bold';
}


  th, td {
   
    padding: 12px;
    text-align: center;
    
 
    border: none; /* 세로 줄 없애기 */
    border-bottom: 1px solid #ddd; /* 가로 줄만 남기기 */
 

    
    
    
  }

  th {
    background-color: transparent;
    border-bottom: 1px solid grey;
    border-top:2px solid black;
    color: black;
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

  button#btnWrite:hover {
    background-color: #A4A4A4;
  }

  .pdiv {
    text-align: left;
    margin-top: 10px;
  }

  .wDiv {
    text-align: right;
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
    background-color: #ddd;
  }
  
  #tblBoard {
  	margin-top:20%;
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
            top: 50%; /* 상단 여백을 50%로 설정하여 세로 중앙 정렬 */
            left: 50%; /* 왼쪽 여백을 50%로 설정하여 가로 중앙 정렬 */
            transform: translate(-50%, -400%); /* 50% 만큼 이동하여 가운데 정렬 */
        
            padding: 10px; /* 텍스트 주위에 여백 추가 (선택 사항) */
            text-align:center;
        }

        .imga a {
            font-size: 20px;
            font-weight: 400;
            line-height: 32px;
            color: white;
            text-decoration: none;
           
        }
        
        .popular {
        	text-align:center;
        }
        
        
</style>
</head>
<body>


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


<!-- 추가로 만들 예정 
<div class="popular">
	<h3>인기 Q&A</h3>
	
	<div class="popularContent">

	
	
	</div>
	
	
</div>

-->



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
            <td class="tdtitle">${bpost.title}</td>
            <td>${bpost.category}</td>
            <td>${bpost.answer_count}</td>
            <td>${bpost.created}</td>
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
        
        <!-- 로그인 되어있을때, userid는 임시로 넣었습니다.  -->
        <c:if test="${not empty sessionScope.userid}">
            <div class="wDiv">
                <button id="btnWrite" class="btnWrite">글쓰기</button>
            </div>    
        </c:if>
        <button id="btnWrite" class="btnWrite">글쓰기</button>
        
        <!-- 로그인 되어있지 않을때. userid는 임시로 넣었습니다. -->
        <c:if test="${empty sessionScope.userid}"> 
            <p>로그인하세요</p>
        </c:if>
        
    </td>
</tr>
</table>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
    $(document)
    .on('click','#tblBoard tbody tr',function(){
        document.location='/view?seqno='+$(this).find('td:eq(0)').text();
        return false;
    })

    .on('click','#btnWrite',function(){
        window.location.href = "/write";
    })

    .on('click','#btnPrev',function(){
        document.location='/manager';
    });
    
</script>
</html>
