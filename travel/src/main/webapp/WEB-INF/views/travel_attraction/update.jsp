<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/detail.css"> <!-- CSS 파일 연결 -->
    <title>여행지 상세 정보</title>
</head>
<style>
</style>
<body>
<%@ include file="../header.jsp" %>
<form action="doupdate" id="frmupdate" method="post" enctype="multipart/form-data">
	<div class="background-img" style="background-image: url('img/t_img/${detail.ta_img}');">
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
		<c:set var="maxIndex" value="${fn:length(ta_imginfoParts) > fn:length(ta_contentParts) ? fn:length(ta_imginfoParts) : fn:length(ta_contentParts)}" />
		<c:forEach begin="0" end="${maxIndex-1}" varStatus="status">
		    <div class="info">
		    <input type="button" class="divdelete" value="전체 삭제">
		        <c:choose>
		            <c:when test="${empty ta_imginfoParts[status.index]}">
		                <!-- 이미지 정보가 비어 있을 때, 아무것도 출력하지 않음 -->
		                <label for="imageUpload">새 이미지 선택:</label>
		                <input type="file" id="imageUpload" name="newdetailimg" accept="image/*">
		                <input type="hidden" name="imgname" value="">
		            </c:when>
		            <c:otherwise>
		                <!-- 이미지 정보가 비어 있지 않을 때, 이미지 출력 -->
		                <div id="updateinfo">
		                    <img src="img/t_sub_img/${ta_imginfoParts[status.index]}" alt="이미지 ${status.index + 1}" style="width: 600px; height: 400px;" class="img">
		                    <input style="width:400px;" type="text" name="imgname" value="${ta_imginfoParts[status.index]}">
		                    <input type="button" class="deleteImage" data-imgname="${ta_imginfoParts[status.index]}" value="이미지 삭제">
		                    <label for="imageUpload">새 이미지 선택:</label>
		                    <input type="file" id="imageUpload" name="newdetailimg" accept="image/*">
		                </div>
		            </c:otherwise>
		        </c:choose>
		        <div>
		            <p><input type="text" name="content" class="content" value="${status.index < fn:length(ta_contentParts) ? ta_contentParts[status.index] : ''}"></p>
		            <input type="button" class="deleteContent" value="컨텐츠 삭제">
		        </div>
		    </div>
		</c:forEach>

		<label>새 컨텐츠 추가</label><br>
		<input type="text" id="addcontent"><br>
		<input type="file" id="addimagefile"><br>
		<input type="button" id="updatedetail" value="내용 추가"><br>
		<table>
			<tr>
		        <td><input type="submit" id="update" value="저장"></td>
		        <td></td>
		        <td><input type="submit" id="cancle" value="취소"></td>
        	</tr>
        </table>
    </div>
</form>
<%@ include file="../footer.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
    // "업데이트 및 이미지 추가" 버튼 클릭 시
    $('#updatedetail').on('click', function () {
        var taName = $('#ta_name').val();
        var content = $("#addcontent").val();
        var imageFile = $('#addimagefile')[0].files[0];

        // content와 imageFile이 비어있을 경우 각각 "/"로 초기화
        if (!content) {
            content = "";
        }

        var formData = new FormData();
        formData.append('ta_name', taName);
        formData.append('content', content);

        if (imageFile) {
            formData.append('newdetailimg', imageFile);
        } else {
            // imageFile이 없을 경우도 요청은 보내지만, 서버에서 이를 처리할 수 있어야 합니다.
            formData.append('newdetailimg', null);
        }

        // 업데이트 및 이미지 추가를 서버에 요청
        $.ajax({
            url: "/updatedetail", // 업데이트 및 이미지 추가를 처리하는 서버 엔드포인트 URL
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                console.log("업데이트 및 이미지 추가 성공");
                console.log(response); // 서버 응답 메시지 로깅
                
                // 이미지 정보 업데이트
                var updateinfoDiv = $("#updateinfo");
                updateinfoDiv.empty(); // 현재 이미지 정보를 지웁니다.

                // 새로운 이미지 정보를 생성하여 추가합니다.
                var newImageInfo = `
                    <img src="img/t_sub_img/${response}" alt="이미지 ${status.index + 1}" style="width: 600px; height: 400px;" class="img">
                    <input style="width:400px;" type="text" name="imgname" value="${response}">
                    <input type="button" class="deleteImage" data-imgname="${response}" value="이미지 삭제">
                    <label for="imageUpload">새 이미지 선택:</label>
                    <input type="file" id="imageUpload" name="newdetailimg" accept="image/*">
                `;
                
                updateinfoDiv.html(newImageInfo);
                location.reload()
                // 페이지 새로고침 또는 이미지 목록 업데이트 등 추가적인 동작을 수행할 수 있습니다.
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("업데이트 및 이미지 추가 실패");
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
    $('.deleteContent').on('click', function () {
        // 컨텐츠 삭제를 서버에 요청
        var contentToDelete = $(this).closest("div").find(".content").val();
        var taName = $('#ta_name').val();

        $.ajax({
            url: "/deleteContent", // 컨텐츠 삭제를 처리하는 서버 엔드포인트 URL
            type: "POST",
            data: { ta_name: taName, contentToDelete: contentToDelete },
            success: function (response) {
            	console.log(contentToDelete)
                console.log("컨텐츠 삭제 성공");
                console.log(response); // 서버 응답 메시지 로깅

                // 페이지 새로고침 또는 컨텐츠 목록 업데이트 등 추가적인 동작을 수행할 수 있습니다.
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("컨텐츠 삭제 실패");
                console.log(jqXHR.responseText); // 오류 응답 메시지 로깅
            }
        });
    });
    $(".divdelete").on("click", function () {
        $(this).closest(".info").remove();
    });
	$("#cancle").on("click",function(){
		let taName = $('#ta_name').val();
		document.location="/travel_detail?ta_name" + taName;
	})
});

</script>
</html>
