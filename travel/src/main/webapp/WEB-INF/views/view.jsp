<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
        }

.showview{
	margin-left:15%;
	display:flex;
	margin-top:4%;
}

hr {
	width:80%;
}

.h1title{
	text-align:center;
}
.spacer {
    margin-right: 10px; /* Adjust the margin-right as needed for your desired spacing */
}

        
    </style>
</head>
<body>


<h1 class="h1title">질문 상세보기</h1>
<hr/>



<div class="showview">
    <h2 class="titleh2">제모${bpost.title}</h2>
</div>

<div class="showview">
    <a>작성자: ${bpost.writer}</a>
    <span class="spacer"></span>
    <a>카테고리: ${bpost.category}</a>
    <span class="spacer"></span>
    <a>조회수: ${bpost.hit}</a>
    <span class="spacer"></span>
    <a>작성일: ${bpost.created}</a>
</div>


 <div class="showview">
 	<a>내용:${bpost.content}</a>
 </div>
 
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
 
</script>
</html>

