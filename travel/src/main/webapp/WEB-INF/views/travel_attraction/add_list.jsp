<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/add_list.css">

</head>
<body>
    <h1>여행지 추가</h1>
    <form action="/upload" method="post" enctype="multipart/form-data">
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required><br>
        <label for="image">리스트 이미지 URL:</label>
        <input type="file" id="image" name="image" required><br>
        
        <label for="region">지역명:</label>
        <input type="text" id="local" name="local" required><br>

        <!-- 디테일 이미지 및 컨텐츠 내용 -->
        <div id="detailFields">
            <!-- 초기에는 한 쌍의 입력 필드만 표시 -->
            <div class="detailField">
                <label for="detailImage">디테일 이미지 URL:</label>
                <input type="file" class="detailImage" id="" name="imageFiles"><br>
                <label for="detailInfo">컨텐츠 내용:</label>
                <textarea class="detailInfo" name="imginfo"></textarea><br>
            </div>
        </div>

        <!-- "디테일 필드 추가" 버튼 -->
        <button type="button" id="addDetailField">디테일 필드 추가</button><br>

        <label for="address">주소:</label>
        <input type="text" id="address" name="address" required><br>
        
        <label for="latitude">위도:</label>
        <input type="text" id="latitude" name="latitude" required><br>
        
        <label for="longitude">경도:</label>
        <input type="text" id="longitude" name="longitude" required><br>
        
        <label for="category">카테고리:</label>
        <select id="category" name="category" required>
            <option value="관광지">관광지</option>
            <option value="음식">음식</option>
        </select><br>

        <input type="submit" value="추가">
        <input type="button" id="btn" value="이전">
        <input type="button" id="previewImage" value="이미지 미리보기">
    </form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>.
<script>
$(document).ready(function() {
    // 디테일 필드 추가 버튼 클릭 시 동작
    $("#addDetailField").click(function() {
        const newDetailField = `
            <div class="detailField">
                <label for="detailImage">디테일 이미지 URL:</label>
                <input type="file" class="detailImage" name="imageFiles"><br>
                <label for="detailInfo">컨텐츠 내용:</label>
                <textarea class="detailInfo" name="imginfo"></textarea><br>
                <button type="button" class="removeDetailField">삭제</button>
            </div>
        `;
        $("#detailFields").append(newDetailField);
    });

    // 삭제 버튼 클릭 시 해당 필드를 제거
    $(document).on("click", ".removeDetailField", function() {
        $(this).closest(".detailField").remove();
    });
});

$(document).on("click","#btn", function(){
	document.location="/travel_list"
});
let imagePreviewPopup;

// 이미지 미리보기 버튼 클릭 시 동작

    // 이미지 미리보기 버튼 클릭 시 동작
$("#previewImage").click(function() {
    // 이미지와 텍스트를 함께 표시하는 팝업 창 열기
    imagePreviewPopup = $("<div id='imagePreviewPopup'></div>");
    const imagePreviewContent = $("<div id='imagePreviewContent'></div>");

    // 디테일 이미지 및 컨텐츠 가져오기
    const detailImageFiles = $(".detailImage");
    const imginfoElements = $(".detailInfo");
    const detailImageUrls = [];
    const imginfoTexts = [];

    detailImageFiles.each(function(index) {
        if (detailImageFiles[index].files.length > 0) {
            const detailImageUrl = URL.createObjectURL(detailImageFiles[index].files[0]);
            detailImageUrls.push(detailImageUrl);
        } else {
            // 이미지 파일이 없는 경우 빈 문자열 추가
            detailImageUrls.push("");
        }
        imginfoTexts.push(imginfoElements[index].value);
    });

    // 이미지 및 텍스트를 팝업 창에 추가
    for (let i = 0; i < detailImageUrls.length; i++) {
        const detailImageElement = $("<img src='" + detailImageUrls[i] + "' alt='디테일 이미지'>");
        const imginfoElement = $("<p>" + imginfoTexts[i] + "</p>");
        imagePreviewContent.append(detailImageElement);
        imagePreviewContent.append(imginfoElement);
    }

    // 스타일 및 팝업 창 열기
    imagePreviewPopup.append(imagePreviewContent);
    $("body").append(imagePreviewPopup);

    // 최대 높이 설정 및 스크롤 기능 추가
    const maxHeight = 800; // 팝업 창의 최대 높이 설정
    imagePreviewContent.css({
        "max-height": maxHeight + "px",
        "overflow-y": "auto", // 세로 스크롤을 표시하도록 설정
    });

    imagePreviewPopup.show();

    // 닫기 버튼 클릭 시 팝업 창 닫기
    const closePreviewButton = $("<span id='closePreviewButton'>&times;</span>");
    imagePreviewContent.append(closePreviewButton);
    closePreviewButton.click(function() {
        closeImagePreview();
    });

    // 팝업 창 외의 영역 클릭 시 팝업 창 닫기
    $(document).on("click", function(event) {
        if (event.target === imagePreviewPopup[0]) {
            closeImagePreview();
        }
    });
});

// 팝업 창 닫기 함수
function closeImagePreview() {
    if (imagePreviewPopup) {
        imagePreviewPopup.remove();
    }
}

</script>
</html>