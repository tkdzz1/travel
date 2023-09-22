<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/detail.css"> <!-- CSS 파일 연결 -->
    <title>여행지 상세 정보</title>
</head>
<body>
<form action="doupdate" id="frmupdate" method="post" enctype="multipart/form-data">
    <div class="background-img">
        <div class="travel-info">
            <h1>여행지 상세 정보</h1>
            <div style="background-color:white; width:120px;height:50px;display: flex;align-items: center;justify-content: center;">
            <img src="img/t_img/${detail.ta_img }" style="width:100px;">
            </div>
            <input type="file" id="newlistimg" name="newlistimg">
            <input type="hidden" name="ta_name" id="ta_name" value="${detail.ta_name}">
            <h2 class="ta_name">여행지명:<input type="text" name="name" value="${detail.ta_name}"></h2>
            <p><strong>지역:</strong><input type="text" name="local" value="${detail.ta_local}"></p>
            <p><strong>주소:</strong><input type="text" name="address" value="${detail.ta_address}"></p>
            <p><strong>분류:</strong><input type="text" name="category" value="${detail.ta_category}"></p>
            <p><strong>위도:</strong><input type="text" name="ta_latitude" value="${detail.ta_latitude}"></p>
            <p><strong>경도:</strong><input type="text" name="ta_longitude" value="${detail.ta_longitude}"></p>
            
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
                        <label for="imageUpload">새 이미지 선택:</label>
                        <input type="file" id="imageUpload" name="newdetailimg" accept="image/*">
                        <input type="hidden" name="imgname" value="">
                    </c:when>
                    <c:otherwise>
                        <!-- 이미지 정보가 비어 있지 않을 때, 이미지 출력 -->
                        <div>
                            <img src="img/t_sub_img/${imginfo}" alt="이미지 ${status.index + 1}" style="width: 600px; height: 400px;" class="img">
                            <input style="width:400px;" type="text" name="imgname" value="${imginfo}">
                            <input type="button" class="deleteImage" data-imgname="${imginfo}" value="이미지 삭제">
                        </div>
                        <label for="imageUpload">새 이미지 선택:</label>
                        <input type="file" id="imageUpload" name="newdetailimg" accept="image/*">
                    </c:otherwise>
                </c:choose>
                <p><input type="text" name="content" value="${ta_contentParts[status.index]}"></p>
            </div>
        </c:forEach>
        <input type="button" id="addImage" value="이미지 추가">
        <input type="file" id="addimagefile">
        <input type="submit" id="update" value="저장">
    </div>
</form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
    // 이미지 추가 버튼 클릭 시
    $('#addImage').on('click', function () {
        // 선택한 이미지 파일
        var imageFile = $('#addimagefile')[0].files[0];

        if (!imageFile) {
            alert("이미지 파일을 선택하세요.");
            return;
        }

        var formData = new FormData();
        formData.append('ta_name', $('#ta_name').val());
        formData.append('newdetailimg', imageFile);

        // 이미지 추가를 서버에 요청
        $.ajax({
            url: "/addImage", // 이미지 추가를 처리하는 서버 엔드포인트 URL
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                console.log("이미지 추가 성공");
                console.log(response); // 서버 응답 메시지 로깅
                // 페이지 새로고침 또는 이미지 목록 업데이트 등 추가적인 동작을 수행할 수 있습니다.
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("이미지 추가 실패");
                console.log(jqXHR.responseText); // 오류 응답 메시지 로깅
            }
        });
    });

    // 이미지 삭제 버튼 클릭 시
    $('.deleteImage').on('click', function () {
    	$(this).closest("div").remove();
        var imageToDelete = $(this).data('imgname');
        var taName = $('#ta_name').val();

        // 이미지 삭제를 서버에 요청
        $.ajax({
            url: "/deleteImage", // 이미지 삭제를 처리하는 서버 엔드포인트 URL
            type: "POST",
            data: { ta_name: taName, imageToDelete: imageToDelete },
            success: function (response) {
                console.log("이미지 삭제 성공");
                console.log(response); // 서버 응답 메시지 로깅
                // 페이지 새로고침 또는 이미지 목록 업데이트 등 추가적인 동작을 수행할 수 있습니다.
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("이미지 삭제 실패");
                console.log(jqXHR.responseText); // 오류 응답 메시지 로깅
            }
        });
    });
});
</script>
</html>
