<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TRAVEL JEJU - 정보 수정</title>
<link rel="stylesheet" href="css/login.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>
<style>
.maindiv {
    text-align: center; /* 가로 가운데 정렬 */
    display: flex;
    justify-content: center; /* 가로 가운데 정렬 (추가) */
    align-items: center; /* 세로 가운데 정렬 */
    height: 100vh; /* 화면 높이의 100%로 설정하여 수직 가운데 정렬 (화면 중앙에 맞게 설정) */
}
</style>
<%@ include file="/WEB-INF/views/header.jsp"%>
<body>
<div class=maindiv>
<div>
<h3>회원탈퇴</h3>
<br>
<div>
<ol>
<li>1. 회원탈퇴 시 회원님의 개인정보는 모두 삭제 처리 됩니다.</li>
<li>2. 회원탈퇴는 즉시 처리 됩니다.</li>
<li>3. 회원탈퇴 시 회원님이 등록하신 일정, 게시글 등<br>모두 삭제되며, 재가입을 하더라도 복구되지 않습니다.</li>
</ol>
<br>
</div>
<div>
<div>
<button type="button" class="w-btn w-btn-black" id=secession>회원탈퇴</button>
<a href="/"><button type="button" class="w-btn w-btn-red">취소</button></a>
</div>
</div>
</div>
</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp"%>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click','#secession',function(){
	Swal.fire({
		   title: '정말로 회원을 탈퇴하시겠어요?',
		   text: '확인을 누르시면 탈퇴가 진행됩니다.',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '예', // confirm 버튼 텍스트 지정
		   cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
		   
		   reverseButtons: false, // 버튼 순서 거꾸로
	   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
		   
		      document.location = "/secession";
		      
		   }
		});
})
</script>
</html>