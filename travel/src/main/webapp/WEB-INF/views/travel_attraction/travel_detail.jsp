<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/detail.css"> <!-- CSS 파일 연결 -->

<title>Insert title here</title>
</head>
<body>
<div class="background-img">
    <div class="travel-info">
        <h1>여행지 상세 정보</h1>
        <h2 class="ta_name">${detail.ta_name}</h2>
        <p><strong>주소:</strong> ${detail.ta_address}</p>
        <p><strong>분류:</strong> ${detail.ta_category}</p>
    </div>
</div>
    <div class="detail-info">
    <c:set var="ta_imginfoParts" value="${requestScope.ta_imginfoParts}" />
    <c:set var="ta_contentParts" value="${requestScope.ta_contentParts}" />
	<c:forEach items="${ta_imginfoParts}" var="imginfo" varStatus="status">
    <div>
		<c:choose>
		    <c:when test="${empty imginfo}">
		        <!-- 이미지 정보가 비어 있을 때, 아무것도 출력하지 않음 -->
		    </c:when>
		    <c:otherwise>
		        <!-- 이미지 정보가 비어 있지 않을 때, 이미지 출력 -->
		        <img src="img/t_sub_img/${imginfo}" alt="이미지 ${status.index + 1}" style="width: 600px; height: 400px;">
		    </c:otherwise>
		</c:choose>
        <p>${ta_contentParts[status.index]}</p>
    </div>
	</c:forEach>
	<button id="update">수정</button>
    </div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click','#update',function(){
	let ta_name = $(".ta_name").text();
	document.location="/update?ta_name=" + ta_name
})
</script>
</html>