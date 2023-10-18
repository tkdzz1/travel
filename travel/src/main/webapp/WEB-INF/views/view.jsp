<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/3.0.1/js.cookie.min.js"></script>
    <title>게시물 보기</title>
    
    <style>
       body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}


.h1title {
	font-family: 'GmarketSansMedium';
    text-align: left;
    font-size: 30px;
    margin-top: 20px;
    margin-left: 11%;
}


.hr1 {
    width: 80% !important;
    margin: 0 auto !important;
    border: 1px solid black !important;
}


.forprev {
    text-align: left;
    margin-left: 15%;

}

a {
	text-decoration:none !important;
}

#prevPage {
    background-color: #007bff;
    color: white;
    border: none;
  
    cursor: pointer;
    border-radius: 5px;
    font-size: 12px;
}

#prevPage:hover {
    background-color: #0056b3;
}


.showview {
    margin-left: 15%;
    margin-top: 1%;
    padding: 40px 40px 20px;
}

@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}


.showview a {
font-family: 'SUITE-Regular';
   font-size: 17px;
    color: #535353;
    margin-bottom : 10px;
}


.comments {
    width: 1290px;
    margin: 0 auto;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
 
}




.comments h2 {
    font-size: 24px;
    margin-bottom: 10px;
    text-align: center;
}


.comment {
    margin-bottom: 20px;
    padding: 15px;
    background-color: #f9f9f9;
    border-radius: 5px;
    position: relative;
    border:1px solid #d8d8d8;;
    
     padding-left: 20px;
     padding: 85px;
}






.reply-icon {
    position: relative;
    left: 0;
    transform: translateY(-50%);
    width: 10px;
    height: 10px;
    background-color: #007bff;
    clip-path: polygon(100% 50%, 0 0, 0 100%);
    margin-left: -10px;
    content: "";
    display: inline-block;
}

.comment .reply-content {
    text-align: left;
    margin-left: 15px;
    padding-left: 0;
    border-left: none;
	width: 1070px;
   
}

.comment .reply-button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin-right: 10px;
    margin-top: 5px;
}


.comment .reply-button:hover {
    background-color: #0056b3;
}



.reply-list ul {
    list-style-type: none;
    padding: 0;
}

.reply-list li {
    margin: 10px 0;
    padding: 10px;
    background-color: #f2f2f2;
    border-radius: 5px;
    text-align: left;
}


.reply-form textarea {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    resize: none;
}


.reply-list button:hover {
    background-color: #0056b3;
}



.reply-list button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 6px 10px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 12px;
    margin-right: 5px;
}



.reply-list p {
    font-size: 14px;
    margin-bottom: 6px;
}


.reply-form {
    margin-top: 10px;
    padding: 10px;
    background-color: #f2f2f2;
    border-radius: 5px;
    display: none;
}

.reply-content {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

.submitReply {
    background-color: #8a8b8b;
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
 	margin-left:518px;
 	margin-top:30px;
}

.submitReply:hover {
    background-color: grey;
}

/* 댓글 입력 폼 스타일 */
.comment-form {
    margin: 0 auto; /* 가운데 정렬을 위한 스타일 추가 */
    width: 70%; /* 원하는 가로 너비로 조정 */
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.comment-form h2 {
    font-size: 18px;
    margin-bottom: 10px;
    text-align: center;
}

.comment-form input[type="text"],
.comment-form textarea {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

.comment-form button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    width: 10%;
    
}

#editclose {
	background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
	}
	
	#editclose:hover {
    background-color: #0056b3;
}



#edit {
	background-color: #007bff;
    color: white;
    border: none;
    
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin-right: 10px;
}

#del {

	background-color: #8a8b8b;
    color: black;
    border: none;
    
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin-right: 10px;

}

#edit:hover {
    background-color: #0056b3;
}

#del:hover {
	background-color: #ccc;
}



.comment-form button:hover {
    background-color: #0056b3;
}

      
#editForm {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    display: none; /* 기본적으로 숨김 */
}

#editForm h3 {
    font-size: 20px;
    margin-bottom: 10px;
}

#editForm input[type="text"],
#editForm textarea,
#editForm select {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

#editForm button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 16px;
}

#editForm button:hover {
    background-color: #0056b3;
}
      
      
      
.forup {
    display: none;
    margin-top: 20px;
    padding: 20px;
    background-color: #f2f2f2;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.forup h3 {
    font-size: 20px;
    margin-bottom: 10px;
    text-align: center;
}

.forup textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}

.forup input[type="submit"] {
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    font-size: 16px;
    margin-right: 10px;
}

.forup .cmtclose {
    background-color: #ccc;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 16px;
}

.forup input[type="submit"]:hover {
    background-color: #0056b3;
}

.forup .cmtclose:hover {
    background-color: #999;
}      
      
.cateSpan {
	position:relative;
	bottom:40px;
	border:1px solid #FA8258;
	background-color: #FA8258;
	width:70px;
	text-align:center;
	border-radius:5px;
}      



@font-face {
    font-family: 'RIDIBatang';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

.fortitleh2 {
	font-family: 'RIDIBatang';
	margin-left:5%;
	font-size:25px;
}      

.revbtn {
	display: block;
    margin: 240px auto 0;
    font-size: 18px;
    width: 200px;
    line-height: 5px;
    text-align: center;
    border: 1px solid #ce5e00;
    color: black;
    font-weight: 600;
    padding-left: 30px;
    background-color:#ef6d00;
    cursor:pointer;
}

@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}


.writereview{
	position:relative;
	bottom:24px;
	right:33px;
	color:white;
	font-family: 'Pretendard-Regular';
}


.revbtn img {
	position:relative;
	right:30px;
	
}      

.hr2 {
	width: 80% !important;
    margin: 0 auto !important;
    border: 1px solid #E0F8F7;
}
 
.b2 {
	display: inline-block;
    font-size: 14px;
    color: #8a8b8b;
} 
 
.showview span {
	display: inline-block;
 
    font-size: 11px;
    
    font-weight:bold;
    margin-left: 3%;
     font-family: 'GmarketSansMedium';
} 
 
.deleteComment,
.edtcmt {
	background: #8a8b8b;
    border: 1px solid #272727;
    font-size: 16px;
    color: #fff;
    border-radius: 6px;
    margin-left: 10px;
    padding: 0 20px;
    height: 34px;
} 
 
.buttons {
	margin-top:10%;
    text-align: center;
} 

@font-face {
    font-family: 'GowunBatang-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
 

.cmter {
font-family: 'GowunBatang-Regular';
	 color: #535353;
	display: inline-block;
    font-size: 14px !important;
    margin-bottom: 5% !important;

} 
 
 @font-face {
    font-family: 'GongGothicMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
 

.cmtnt {
	font-family: 'GongGothicMedium';
    font-size: 20px !important;
	margin-bottom: 3% !important;
}
 
 
.cmtct {
	display:none;
} 

.commentcreated{
	font-family: 'GowunBatang-Regular';
	 color: #535353;
	display: inline-block;
    font-size: 14px !important;
}

.noreply {
	margin-top:30px;
}

.forpos {
	margin-top: 5%;
	margin-left: 35%;
}

@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

.emptycomments {
	font-size:18px;
	font-family: 'Pretendard-Regular';
	text-align:center;
}


.logincomment{
	text-align:center;
	margin-top:5%;
}

.retxt {
        width: 100%; /* 원하는 너비로 조절하세요 */
        height: 80px; /* 원하는 높이로 조절하세요 */
        padding: 5px;
        margin-bottom: 10px;
    }
    
    .subrp {
        background-color: #007BFF !important; /* 버튼 배경색 지정 */
        color: #fff !important; /* 버튼 텍스트 색상 지정 */
        border: none !important;
        cursor: pointer !important;
        border-radius :10px !important;
        
    }
    
    
    .modal {
    display: none;
    position: fixed;
    z-index: 999; /* 모달의 z-index 값을 높게 설정 */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    position: relative;
}
    

.goback {
	text-align:center;
}

.goprev {
font-family: 'Pretendard-Regular';
	height:40px;
	width:50px;
}

.goprev:hover {
	background-color: grey !important;
}




.editReply {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
    margin-right: 5px;
}

.editReply:hover {
    background-color: #0056b3;
}

/* 삭제 버튼 */
.deleteReply {
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
    margin-right: 5px;
}

.deleteReply:hover {
    background-color: #c82333;
}

/* 수정할 댓글 텍스트 영역 */
.retxt {
    width: 100%;
    max-width: 300px; /* 최대 너비 설정 */
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-bottom: 5px;
}

/* 확인 버튼 */
.subrp {
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    font-family: 'SUITE-Regular';
}

.subrp:hover {
    background-color: #218838;
}

@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}


.repcommenter , .repcomment, .repday {
	font-family: 'SUITE-Regular';
}

.onlywriter {
	display:none;
}

.noshowwriter, .onlyshowtowriter {
	font-family: 'GmarketSansMedium';
	color: #848484;
}

.hidecommenter, .showtoowner {
	font-family: 'GmarketSansMedium';
}

.emotional {
	float:right;
	display:flex;
	
}


@font-face {
    font-family: 'BMJUA';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.emotional li {
	    display: inline-block;
    text-align: center;
    width: 80px;
    font-size: 14px;
    color: #535353;
    padding: 50px 0 0;
   font-family: 'BMJUA';
}

.fli {
	background: url(https://www.visitjeju.net/image/knowledge/icon-evaluation1.svg) no-repeat top/36px auto;
}

.sli {
	background: url(https://www.visitjeju.net/image/knowledge/icon-evaluation2.svg) no-repeat top/36px auto;
}  

.tli {
	background: url(https://www.visitjeju.net/image/knowledge/icon-evaluation3.svg) no-repeat top/36px auto;
}

.fifli {
	background:url(https://www.visitjeju.net/image/knowledge/icon-evaluation4.svg) no-repeat top/36px auto;
}

.sili {
	background:url(https://www.visitjeju.net/image/knowledge/icon-evaluation5.svg) no-repeat top/36px auto;
}



 
    </style>
</head>
<body>
<%@include file="header.jsp"%>
<br><br>
<h1 class="h1title">질문 상세보기</h1>
<br>

<hr class="hr1"/>
<br>

<div class="forprev">

<img src="data:image/svg+xml;charset=utf-8,%3Csvg data-name='그룹 3165' xmlns='http://www.w3.org/2000/svg' width='65.746' height='76.39' viewBox='0 0 65.746 76.39'%3E%3Cdefs%3E%3CclipPath id='a'%3E%3Cpath data-name='사각형 117' fill='%23757575' d='M0 0h65.746v76.39H0z'/%3E%3C/clipPath%3E%3C/defs%3E%3Cg data-name='그룹 3164' clip-path='url(%23a)'%3E%3Cpath data-name='패스 21917' d='M37.433 76.39a2.68 2.68 0 0 1-1.5-.458c-.661-.445-16.2-10.917-18.183-12.443l-.2-.151a49.339 49.339 0 0 1-9.755-9.208A32.876 32.876 0 0 1 32.653 0h.223a32.954 32.954 0 0 1 32.87 32.654c0 21.494-18.045 28.466-24.065 30.192l-1.59 11.236a2.684 2.684 0 0 1-2.658 2.309M32.876 5.37h-.187a27.5 27.5 0 0 0-20.8 45.284 44.223 44.223 0 0 0 8.936 8.423l.2.152c1.221.938 8.976 6.207 14.353 9.846l1.241-8.768a2.684 2.684 0 0 1 2.18-2.266c.876-.163 21.58-4.252 21.58-25.371a27.566 27.566 0 0 0-27.5-27.3' fill='%23f3f3f3'/%3E%3Cpath data-name='패스 21918' d='M45.375 45.762L42.649 49l-3.7-3.688a11.906 11.906 0 0 1-6.422 1.8c-7 0-12.529-5.489-12.529-15.32s5.529-15.32 12.533-15.32 12.53 5.489 12.53 15.321a17.58 17.58 0 0 1-3.034 10.61zm-12.141-6.148l2.761-3.276 2.764 2.787a13.962 13.962 0 0 0 1.708-7.332c0-6.76-3-10.9-7.94-10.9s-7.939 4.138-7.939 10.9 3 10.9 7.939 10.9a6.961 6.961 0 0 0 3.113-.655z' fill='%23ef6d00'/%3E%3C/g%3E%3C/svg%3E" />
&nbsp;&nbsp;
<span class="cateSpan">${bpost.category}</span>
<div class="fortitleh2">
<h2 class="thtileh2">${bpost.title}</h2>
</div>
</div>



<div class="showview">
    <span>작성자: 
        <c:choose>
            <c:when test="${bpost.isprivate == 1 && sessionScope.id != bpost.writer}">비공개</c:when>
            <c:otherwise>${bpost.writer}</c:otherwise>
        </c:choose>
    </span>
    <p class="onlywriter">${bpost.writer}</p>
    <span class="b2">작성일: ${bpost.created}</span> 
    <span class="b2">조회수: ${bpost.hit}</span> 
    <br>
</div>
<br><br>
<hr class="hr2"/>
<br>
<div class="showview">
    <a>${bpost.content}</a>
</div>



<div class="revbtn">
<img src="data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='79' height='57' viewBox='0 0 79 57'%3E%3Cdefs%3E%3CclipPath id='a'%3E%3Cpath data-name='사각형 158' transform='translate(.214)' fill='none' d='M0 0h79v57H0z'/%3E%3C/clipPath%3E%3CclipPath id='b'%3E%3Cpath data-name='사각형 151' transform='translate(-.409 .197)' fill='none' d='M0 0h47v48H0z'/%3E%3C/clipPath%3E%3Cpattern id='c' preserveAspectRatio='none' width='100%25' height='100%25' viewBox='0 0 97 101'%3E%3Cimage width='97' height='101' xlink:href='data:image/png;base64,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'/%3E%3C/pattern%3E%3CclipPath id='d'%3E%3Cpath data-name='패스 21929' d='M55.5 26.5l-17.977 4.608a1.477 1.477 0 0 0 0 2.861L55.5 38.577a8.148 8.148 0 0 0 4.051 0l17.973-4.607a1.477 1.477 0 0 0 0-2.861L59.546 26.5a8.159 8.159 0 0 0-4.051 0' transform='translate(-36.413 -26.245)' fill='none'/%3E%3C/clipPath%3E%3CclipPath id='e'%3E%3Cpath data-name='사각형 154' transform='translate(.214)' fill='none' d='M0 0h76v43H0z'/%3E%3C/clipPath%3E%3Cpattern id='f' preserveAspectRatio='none' width='100%25' height='100%25' viewBox='0 0 162 89'%3E%3Cimage width='162' height='89' xlink:href='data:image/png;base64,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'/%3E%3C/pattern%3E%3CclipPath id='g'%3E%3Cpath data-name='사각형 157' transform='translate(-.163 .049)' fill='none' d='M0 0h42v42H0z'/%3E%3C/clipPath%3E%3C/defs%3E%3Cg data-name='그룹 3189'%3E%3Cg data-name='그룹 3188' transform='translate(-.214)' clip-path='url(%23a)'%3E%3Cg data-name='그룹 3173'%3E%3Cg data-name='그룹 3172' clip-path='url(%23a)'%3E%3Cpath data-name='패스 21927' d='M48.924 18.977c0-1.13-4.7-2.045-10.5-2.045s-10.5.916-10.5 2.045l-1.9 10.64a1.676 1.676 0 0 0 1.65 1.97h1.824a9.314 9.314 0 0 1 6.586 2.728l1.145 1.146a1.677 1.677 0 0 0 2.371 0l1.146-1.146a9.314 9.314 0 0 1 6.586-2.728h1.824a1.676 1.676 0 0 0 1.65-1.97z' fill='%23875b52'/%3E%3C/g%3E%3C/g%3E%3Cg data-name='그룹 3177'%3E%3Cg data-name='그룹 3176' transform='translate(19.624 2.803)' clip-path='url(%23b)'%3E%3Cg data-name='그룹 3175'%3E%3Cg data-name='그룹 3174' clip-path='url(%23b)'%3E%3Cpath data-name='사각형 149' transform='translate(-.409 .197)' fill='url(%23c)' d='M0 0h47v48H0z'/%3E%3C/g%3E%3C/g%3E%3C/g%3E%3C/g%3E%3Cg data-name='그룹 3179'%3E%3Cg data-name='그룹 3178' clip-path='url(%23a)'%3E%3Cpath data-name='패스 21928' d='M58.425 20.409l-17.973 4.607a8.148 8.148 0 0 1-4.051 0l-17.972-4.607a1.477 1.477 0 0 1 0-2.861l17.977-4.609a8.148 8.148 0 0 1 4.051 0l17.973 4.607a1.477 1.477 0 0 1 0 2.861' fill='%23875b52'/%3E%3C/g%3E%3C/g%3E%3Cg data-name='그룹 3183'%3E%3Cg data-name='그룹 3182' clip-path='url(%23d)' transform='translate(17.319 12.684)'%3E%3Cg data-name='그룹 3181'%3E%3Cg data-name='그룹 3180' transform='translate(-17.319 -12.684)' clip-path='url(%23e)'%3E%3Cpath data-name='사각형 153' transform='translate(.214)' fill='url(%23f)' d='M0 0h76v42H0z'/%3E%3C/g%3E%3C/g%3E%3C/g%3E%3C/g%3E%3Cg data-name='그룹 3185'%3E%3Cg data-name='그룹 3184' clip-path='url(%23a)'%3E%3Cpath data-name='패스 21930' d='M40.955 17.622c0 .49-1.132.888-2.528.888s-2.528-.4-2.528-.888a2.728 2.728 0 0 1 5.057 0' fill='%23fddf7b'/%3E%3Cpath data-name='패스 21931' d='M38.426 17.215l11.151 2.755a3.552 3.552 0 0 1 2.693 3.134c.276 3.171 1.283 8.6 4.884 11.658' fill='none' stroke='%23fddf7b' stroke-miterlimit='10' stroke-width='3.082'/%3E%3Cpath data-name='패스 21932' d='M62.298 36.768l-3.106-2.651a1.772 1.772 0 0 0-1.605-.52 1.726 1.726 0 0 0 .05-.4 1.8 1.8 0 1 0-1.459 1.744 1.77 1.77 0 0 0 .442 1.628l2.5 3.229a1.773 1.773 0 0 0 2.626.2l.625-.6a1.774 1.774 0 0 0-.071-2.633' fill='%23fddf7b'/%3E%3C/g%3E%3C/g%3E%3Cg data-name='그룹 3187'%3E%3Cg data-name='그룹 3186' transform='translate(37.377 14.951)' clip-path='url(%23g)'%3E%3Cimage data-name='사각형 156' width='42' height='42' transform='translate(-.163 .049)' xlink:href='data:image/png;base64,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'/%3E%3C/g%3E%3C/g%3E%3C/g%3E%3C/g%3E%3C/svg%3E"/>
<a class="writereview" id="writereview">댓글 작성</a>
</div>

         
<c:if test ="${empty sessionScope.id}">
	<p class="logincomment"><strong>로그인 후 댓글을 작성할 수 있습니다.</strong>
</c:if>         






<br><br>


<c:if test="${!empty sessionScope.id}">
<!-- 댓글 입력 폼 스타일 -->
<div class="comment-form" style="text-align: center; display:none;">
    <form id="commentForm" method="post" action="/doincomment" name="commentForm">
        <input type="text" name="board_seqno" id="board_seqno" value="${bpost.seqno}" style="display: none;">
        <input type="text" name="commenter" id="commenter" value="${sessionScope.id}" readonly>
        <textarea name="comment_content" id="comment_content" placeholder="댓글 내용"></textarea>
        <button type="button" id="submitComment">완료</button><br>
        <a class="noshowwriter">작성자 비공개</a><input type="checkbox" id="checkprivate"><br>
        <a class="onlyshowtowriter">질문 작성자에게만 공개</a> <input type="checkbox" id="privateComment">
    </form>
    <br>
</div>
   </c:if>











<br><br><br><br>

<br><br><br><br>





<!-- 댓글 섹션 -->
<div class="comments">
    <c:choose>
        <c:when test="${empty comments}">
            <h1 class="emptycomments">등록된 댓글이 없습니다.</h1>
        </c:when>
        <c:otherwise>
            <c:forEach items="${comments}" var="comment">
                <div class="comment">
                    <p class="cmter">
                        <c:choose>
                            <c:when test="${comment.isprivate == 1 && sessionScope.id != comment.commenter}">
                                댓글 작성자: 비공개
                            </c:when>
                            <c:otherwise>
                                <strong>댓글 작성자: <c:out value="${comment.commenter}" /></strong>
                            </c:otherwise>
                        </c:choose>
                        &nbsp;&nbsp; 작성일: <c:out value="${comment.comment_created}" />
                    </p>
                    <p style="display:none;" id="ckcmtid"><c:out value="${comment.comment_id}" /></p>
                    <p style="display:none;"><c:out value="${comment.commenter}" /></p>
                    <p class="cmtnt">
                        <c:choose>
                            <c:when test="${comment.isprivatecomment == 1 && sessionScope.id != comment.commenter && sessionScope.id != bpost.writer}">
                                <strong>작성자에게만 보이는 댓글입니다.</strong>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${comment.comment_content}" />
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p class="cmtct">작성일: <c:out value="${comment.comment_created}" /></p>
                    <p style="display:none;"><c:out value="${comment.board_seqno}" /></p>
                    
                    <c:if test="${sessionScope.id == comment.commenter}">
                        <br><br>
                        <div class="buttons">
                            <button class="deleteComment" data-seqno="${comment.board_seqno}">삭제</button>
                            <button class="edtcmt">수정</button>

                        </div>
                    </c:if>
                    
                    
                    <c:choose>
                    <c:when test="${!empty sessionScope.id }" >
                     <button class="showreply">답글 보기</button>
                        <div class="reply-list" style="display: none;"> </div>
                        <button class="replyComment">답글 작성</button>
                        
                            <ul class="emotional">
                            <li class="fli"><strong>좋아요</strong><p>0</p></li>
                            <li class="sli">유익해요<p>0</p></li>
                            <li class="tli">재밌어요<p>0</p></li>
                            <li class="fifli">동의못해요<p>0</p></li>
                            <li class="sili">광고같아요<p>0</p></li>
                            
                            </ul>
                        
                   </c:when>
                   <c:otherwise>
                    <p style="font-size:13px;">로그인 후 답글 작성 가능합니다.</p>
             		</c:otherwise>
             		</c:choose>
             
             
             
                    <!-- 대댓글 폼 -->
                    <div class="reply-form" style="display:none;">
                        <textarea class="reply-content" placeholder="답글 내용" style="resize:none;"></textarea>
                        <button class="submitReply">작성완료</button><br>
                        <a class="hidecommenter">작성자 비공개</a> <input type="checkbox" id="privatebox"><br>
                        <a class="showtoowner">작성자에게만 보이기</a><input type="checkbox" id="showtowriter">
                    </div>
                    <div class="forup" style="display:none;">
                        <h3>댓글 수정</h3>
                        <form id="editCommentForm" method="post" action="/editComment">
                            <input type="text" id="commentId" name="commentId" style="display:none;">
                            <p style="display:none;" id="bsq"><c:out value="${comment.board_seqno}" /></p>
                            <p style="display:none;" id="cmtid"><c:out value="${comment.comment_id}" /></p>
                            <textarea style="resize:none;" id="txt" name="content"></textarea>
                            <input type="submit" value="수정하기" id="commentedit">
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>






    











      
      
      
      
      
      


<br><br>
<div class="goback">
	<input type="button" value="목록" id="goprev" class="goprev">
</div>
<c:if test="${sessionScope.id == bpost.writer}">
<div class="forpos">
   <input type="button" value="게시글 삭제" id="del" name="del" data-seqno="${bpost.seqno}" style="margin-left:15%;">
   <input type="button" value="게시글 수정" id="edit" name="edit">
   </div>
</c:if>

<br><br><br><br><br><br>

<div id="editModal" class="modal">
<div id="editForm" class="modal-content" style="display: none;">
    <form id="editPostForm" method="post" action="/editPost">
        <input type="hidden" name="seqno" id="seqno" value="${bpost.seqno}">
        <input type="text" name="title" id="title" value="${bpost.title}" placeholder="제목">
        <textarea name="content" id="content" placeholder="내용">${bpost.content}</textarea>
        
        <!-- 카테고리 선택 -->
        <select name="category" id="category" style="width:15%;"> 
            <option value="음식점" ${bpost.category == '음식점' ? 'selected' : ''}>음식점</option>
            <option value="관광" ${bpost.category == '관광' ? 'selected' : ''}>관광</option>
            <option value="숙박" ${bpost.category == '숙박' ? 'selected' : ''}>숙박</option>
            <option value="기타" ${bpost.category == '기타' ? 'selected' : ''}>기타</option>
        </select>
        &nbsp;&nbsp;&nbsp;<button type="button" id="editcomplete">수정 완료</button>
    </form>
  </div>
</div>

<br><br><br><br>


<div id="sessionData" style="display: none;" data-id="${sessionScope.id}">
    
    
</div>





<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function () {
    	
    	
    	var board_seqno = $('#board_seqno').val();
    	var userId = $('#user_id').val(); 
    	console.log("seqno: " + board_seqno);

    	if (board_seqno !== null) {
    	    document.querySelectorAll('.emotional li').forEach(function(li, index) {
    	        li.addEventListener('click', function() {
    	            var commentId = $(this).closest('.comment').find('p:eq(1)').text().trim();
    	            console.log("cmtid: " + commentId); // 각 댓글 고유 번호
    	            
    	            // 쿠키를 통해 이미 표현한 감정인지 확인
    	            var expressed = Cookies.get('expressed_emotion_' + board_seqno + '_' + commentId + '_' + userId);
    	            if (expressed) {
    	                alert('이미 감정을 표현하셨습니다.');
    	            } else {
    	                if (confirm('감정 표현 하시겠습니까?')) {
    	                    var p = li.querySelector('p');
    	                    var currentCount = parseInt(p.textContent);
    	                    p.textContent = currentCount + 1;

    	                  	// 10년간 저장
    	                    Cookies.set('expressed_emotion_' + board_seqno + '_' + commentId + '_' + userId, true, { 
    	                        expires: 3650, // 10년 (365일 * 10)
    	                        path: ''
    	                    });

    	                    // 각 페이지별로 다른 쿠키 이름을 생성
    	                    Cookies.set('count_' + board_seqno + '_' + index, currentCount + 1, { path: '' });
    	                    alert('Success');
    	                }
    	            }
    	        });
    	    });

    	    // 페이지가 로드될 때 쿠키에서 숫자를 가져와 각 li에 설정
    	    document.querySelectorAll('.emotional li').forEach(function(li, index) {
    	        var count = Cookies.get('count_' + board_seqno + '_' + index);
    	        if (count !== undefined) {
    	            li.querySelector('p').textContent = count;
    	        }
    	    });
    	}

    	
    	
        
        
        
        
        
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	var isModalOpen = false; // 모달 상태를 저장하는 변수

    	$('#edit').click(function () {
    	    isModalOpen = true;
    	    $('#editModal').css("display", "block");
    	});

    	$('#editcomplete').click(function () {
    	    isModalOpen = false;
    	    $('#editModal').css("display", "none");
    	});

    	$(window).click(function(event) {
    	    if (isModalOpen && event.target == document.getElementById("editModal")) {
    	        $('#editModal').css("display", "none");
    	        isModalOpen = false;
    	    }
    	});



    	 
    	        
    	  
    	
    	
    	
    	
    	
    	$('.goprev').click(function(){
    		window.location.href="/q&a";
    	})
    	
    	
    	$('.revbtn').click(function(){
    		

    		$('.comment-form').toggle();
    	})
    	
    		
    	
    	 var userId = $('#sessionData').data('id');   	    
    	    if (userId) {    	   
    	        console.log('사용자 ID: ' + userId);
    	    }
    	
    	    
    	    
    	    
    	    if(!userId) {
    	    	$('.revbtn').click(function(){
    	    		if(confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?')){
    	    			window.location.href="/login";
    	    		}
    	    		
    	    	})
    	    }
    	    
    	    
    	    
    	    

    	    $('.showreply').click(function () {
    	        var replyList = $(this).next('.reply-list');
    	        var commentId = $(this).closest('.comment').find('p:eq(1)').text().trim(); // 댓글 ID

    	        
    	        var commenter123 = $(this).closest('.comment').find('p:eq(2)').text().trim();
    	        
    	        console.log('댓글 작성자:' + commenter123);
    	        console.log('현재 아이디:'+userId);
    	        // 대댓글 목록을 토글(보이기/숨기기)합니다.
    	        replyList.toggle();

    	        // 대댓글 목록이 숨겨져 있으면 AJAX 요청을 보내지 않습니다.
    	        if (!replyList.is(':visible')) {
    	            return;
    	        }

    	        
    	        $.ajax({
    	            url: '/getReplies',
    	            method: 'POST',
    	            data: {
    	                commentId: commentId
    	            },
    	            success: function (replies) {
    	                if (replies.length > 0) {
    	                    // 대댓글이 있는 경우
    	                    var replyHtml = '<ul>';
    	                    for (var i = 0; i < replies.length; i++) {
    	                        replyHtml += '<br><hr/>';
    	                        replyHtml += '<span class="reply-icon"> </span>';
    	                        replyHtml += '<li>';
    	                        replyHtml += '<p class="repcommenter">';

    	                        // 대댓글이 비공개이고 작성자와 현재 사용자가 다른 경우
    	                        // 본인의 댓글은 비공개로 설정해도 본인에게는 닉네임이 보입니다.
    	                        if (replies[i].isprivate === 1 || (replies[i].isprivate === 3 && userId !== replies[i].commenter)) {
    	                            replyHtml += '작성자: 비공개';
    	                        } else {
    	                            replyHtml += '작성자: ' + replies[i].commenter;
    	                        }

    	                        replyHtml += '</p>';
    	                        replyHtml += '<p class="repcommenter" style="font-weight:bold;">';

    	                        if (replies[i].isprivate === 3) {
    	                            if (userId !== replies[i].commenter && userId !== commenter123) {
    	                                replyHtml += '비밀글';
    	                            } else {
    	                                replyHtml += '내용: ' + replies[i].reply_content;
    	                            }
    	                        } else {
    	                            replyHtml += '내용: ' + replies[i].reply_content;
    	                        }
    	                        replyHtml += '</p>';
    	                        // reply_created에서 월과 일만 추출
    	                        var replyDate = new Date(replies[i].reply_created);
    	                        var month = (replyDate.getMonth() + 1).toString().padStart(2, '0'); // 월
    	                        var day = replyDate.getDate().toString().padStart(2, '0'); // 일

    	                        replyHtml += '<p class="repday">일자: ' + month + '/' + day + '</p>';
    	                        replyHtml += '<p class="rplid" style="display:none;">번호: ' + replies[i].reply_id + '</p>';

    	                        if (userId === replies[i].commenter) {
    	                            replyHtml += '<button class="editReply" data-replyId="' + replies[i].reply_id + '">수정</button>';
    	                            replyHtml += '<button class="deleteReply" data-replyId="' + replies[i].reply_id + '">삭제</button>' + "<br>";
    	                            replyHtml += '<textarea class="retxt" placeholder="수정 내용" style="display:none;" data-replyId="' + replies[i].reply_id + '"></textarea>' + "<br>";
    	                            replyHtml += '<input type="button" class="subrp" value="확인" style="display:none;">';
    	                        }
    	                        replyHtml += '</li>';
    	                    }
    	                    replyHtml += '</ul>';
    	                    replyList.html(replyHtml);
    	                    
    	                   

    	         
    	                    $('.editReply').click(function (event) {
    	                        var textarea = $(this).siblings('.retxt');
    	                        var subrpButton = $(this).siblings('.subrp');

    	                        textarea.toggle();
    	                        subrpButton.toggle();
    	                    });


						 $('.subrp').click(function () {
						    var replyIdText = $(this).closest('li').find('.rplid').text().trim(); // 대댓글 번호 가져오기
						    var replyId = replyIdText.split(': ')[1]; // "번호: 38"에서 숫자 부분만 추출
						    var reply_content = $(this).siblings('.retxt').val();
						
						    console.log(replyId);
						    console.log(reply_content);
						
						    $.ajax({
						        url: '/edtrply',
						        method: 'POST',
						        data: {
						            reply_id: replyId,
						            reply_content: reply_content
						        },
						        success: function (response) {
						            if (response === "1") {
						                alert('수정이 완료되었습니다.');
						          
						                window.location.reload();
						            } else {
						                alert('수정 중 오류가 발생했습니다.');
						            }
						        },
						        error: function () {
						            alert('수정 중 오류가 발생했습니다.');
						        }
						    });
						});
    	                    

						    	                    $('.deleteReply').click(function () {
						    	                        var replyIdText = $(this).closest('li').find('.rplid').text().trim(); // 대댓글 번호 가져오기
						    						    var replyId = replyIdText.split(': ')[1]; // "번호: 38"에서 숫자 부분만 추출

						    	                        console.log(replyId);

						    	                        $.ajax({
						    	                            url: '/delrply',
						    	                            method: 'POST',
						    	                            data: {
						    	                                reply_id: replyId
						    	                            },
						    	                            success: function (response) {
						    	                            	if (response ==="1"){
						    	                            		
						    	                                alert('삭제 완료');
						    	                                window.location.reload();
						    	                            	}
						    	                            },
						    	                            error: function () {
						    	                                alert('삭제 중 오류가 발생했습니다.');
						    	                            }
						    	                        });
						    	                    });
    	                    
    	                    

    	                } else {
    
    	                    replyList.html('<p class="noreply">작성된 답글이 없습니다.</p>');
    	                }
    	            },
    	            error: function () {
    	                alert('대댓글을 불러오는데 실패했습니다.');
    	            }
    	        });
    	    });




    	
    	$('.replyComment').click(function () {
            $(this).siblings('.reply-form').toggle();
        });

        // 닫기 버튼 클릭 시 대댓글 폼 닫기
        $('.cancelReply').click(function () {
            $(this).closest('.reply-form').hide();
        });
    
    	  
    	    
		// 대댓글..		
    $('.submitReply').click(function () {
    var commenter = $('#commenter').val();
    var replyContent = $(this).siblings('.reply-content').val();
    var commentId = $(this).closest('.comment').find('p:eq(1)').text();
    var boardseqno = $('#board_seqno').val();
    var isprivate = $('#privatebox').is(':checked') ? 1 : 0; 
    if($('#showtowriter').is(':checked')) {
    	isprivate = 2
    }
    if($('#showtowriter').is(':checked')&&$('#privatebox').is(':checked')) {
    	isprivate = 3
    }

    console.log('commenter:', commenter);
    console.log('replyContent:', replyContent);
    console.log('commentId:', commentId);
    console.log('boardseqno:', boardseqno);

    if (replyContent == '') {
        alert("내용을 입력하세요..");
        return false;
    }

    $.ajax({
        url: '/doinreply',
        method: 'POST',
        data: {
            commenter: commenter,
            replyContent: replyContent,
            commentId: commentId,
            boardseqno: boardseqno,
            isprivate: isprivate 
        },
        success: function (data) {
            if (data == "") {
                alert('답글 작성 완료');
                window.location.reload();
            }
        },
        error: function (error) {
            alert('답글 작성에 실패했습니다.' + error);
        }
    });
});
        
    	    
    	   
 	
    	console.log($('#txt').val());
    	
    	let commentCount = $('.comments .comment').length;
    	let seqno = $('#board_seqno').val();
    	
    	 console.log('페이지:'+seqno);
    	 console.log('댓글 개수: ' + commentCount);
    	
    	 
    	 
    	 $.ajax({
    		    url: '/saveCommentCount', 
    		    type: 'POST', 
    		    data: { commentCount: commentCount,
    		    		seqno:seqno
    		    	  }, 
    		    success: function(response) {
    		      
    		    },
    		    error: function(error) {
    		     
    		    }
    		});
    	 
    	 

  
    	
    	
    	
    	   $('#submitComment').click(function () {
               var boardSeqno = $('#board_seqno').val();
               var commenter = $('#commenter').val();
               var commentContent = $('#comment_content').val();
               var isPrivate = $('#checkprivate').is(':checked') ? 1 : 0;
               var isprivatecomment = $('#privateComment').is(':checked') ? 1 : 0;
               
               
               if (commenter == '') {
                   alert('로그인하세요...');
                   window.location.href = "/login";
                   return false;
               }

               if (commentContent == '') {
                   alert('댓글 내용을 입력하세요.');
                   return false;
               }

               
               
               
               
               // 댓글 데이터를 서버로 전송
               $.ajax({
            	    url: '/doincomment',
            	    method: 'POST',
            	    data: {
            	        board_seqno: boardSeqno,
            	        commenter: commenter,
            	        comment_content: commentContent,
            	        isprivate : isPrivate,
            	        isprivatecomment : isprivatecomment
            	    },
            	    success: function (data) {
            	        alert('작성완료');

            	        window.location.reload();
            	    },
            	    error: function (error) {
            	        alert('댓글 작성에 실패했습니다.');
            	    }
            	});
           });
    	
 	
    	$('.edtcmt').click(function (event) {
    	    var commentDiv = $(this).closest('.comment');
    	    var commentForm = commentDiv.find('.forup');
    	    commentForm.toggle();
    	    
    	    var commentContent = ""; // 빈 값으로 대체
    	    commentForm.find('#txt').val(commentContent);
    	});
    	
    	
    	

    	$('.cmtclose').click(function () {
    	    $(this).closest('.forup').hide();
    	});

    	
    	
    	
		
    	// 수정 폼 열림
    	$('#edit').click(function () {
            $('#editForm').toggle();        
        });
    	
    	$('#editclose').click(function(){
    		$('#editForm').hide();
    	});
    	
    	
    	
    	
    	// 수정진행
    $('#editcomplete').click(function () {
    let seqno = $('#seqno').val();
    let title = $('#title').val();
    let content = $('#content').val();
    let category = $('#category').val();

    $.ajax({
    	
        url: '/editPost',
        data: { seqno: seqno, title: title, content: content, category: category },
        type: 'post',
        success: function (data) {
            alert('수정완료');
            window.location.reload();
        },
        error: function (error) {
            alert('수정에 실패했습니다.');
        }
    });
});
    	
    	
    	
    	
    $('#del').click(function () {
        Swal.fire({
            title: '정말로 게시글을 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
        }).then((result) => {
            if (result.isConfirmed) {
                let seqno = $(this).data('seqno');
                $.ajax({
                    url: '/deletePost',
                    data: { seqno: seqno },
                    type: 'post',
                    success: function (data) {
                        Swal.fire('게시글이 삭제되었습니다.', '', 'success');
                        alert('게시글이 삭제되었습니다.'); // Display an additional alert
                        window.location.href = "/q&a";
                    },
                    error: function (error) {
                        Swal.fire('페이지 에러', '', 'error');
                    }
                });
            }
        });
    });



    	
    	
    	
    	
    	
    	 $('.deleteComment').click(function () {
    		  
    		  console.log($(this).parent().find('p:eq(1)').text().trim());
    		  console.log($(this).data('seqno'));
    		  
    		    if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
    		      
    		        var seqno = $(this).data('seqno');
    		        
    		        
    		        var commentId = $(this).closest('.comment').find('p:eq(1)').text().trim();
    		        
    		        console.log(commentId);

    		     
    		        $.ajax({
    		            url: '/deleteComment',
    		            method: 'POST',
    		            data: { seqno: seqno, commentId: commentId },
    		            success: function () {
    		                alert('댓글이 삭제되었습니다.');
    		                window.location.reload();
    		            },
    		            error: function () {
    		                alert('댓글 삭제 중 오류가 발생했습니다.');
    		            }
    		        });
    		    }
    		});


    	 
    	 $('.forup form').submit(function (event) {
    		    event.preventDefault();
    		    

    		    // 폼에서 필요한 데이터 가져오기
    		    var content = $(this).find('#txt').val(); // 수정된 댓글 내용
    		    var boardSeqno = $(this).find('#bsq').text().trim();
    		    var commentId = $(this).closest('.forup').find('p#cmtid').text().trim();

    		    console.log("content: " + content);
    		    console.log("boardseq: " + boardSeqno);
    		    console.log("commentId: " + commentId);

    		    // AJAX 요청 보내기
    		    $.ajax({
    		        url: '/editComment',
    		        method: 'POST',
    		        data: {
    		            content: content,
    		            board_seqno: boardSeqno,
    		            commentId: commentId
    		        },
    		        success: function (data) {
    		            alert('댓글 수정 완료');
    		            window.location.reload();
    		        },
    		        error: function () {
    		            alert('댓글 수정에 실패했습니다.');
    		        }
    		    });
    		});


    });
</script>
<%@include file="footer.jsp"%>
</body>
</html>
