<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

        .showview {
            margin-left: 15%;
            display: flex;
            margin-top: 4%;
        }

        .hr1 {
            width: 80%;
        }

        .h1title {
            text-align: center;
        }

        .spacer {
            margin-right: 10px;
        }

        /* 댓글 스타일 */
        .comments {
            margin-top: 20px;
        }

        .comment {
            margin-bottom: 10px;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
            position:relative;
        }
        
        .reply-form {
    margin-top: 10px;
    padding: 10px;
    background-color: #f2f2f2;
    border-radius: 5px;
    display: none; /* 초기에는 숨김 */
    
}

.reply-content {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.submitReply {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 12px;
    cursor: pointer;
    border-radius: 5px;
}
        
        
        

        /* 댓글 입력 폼 스타일 */
        .comment-form {
            margin-top: 20px;
        }

        /* 댓글 입력 폼 필드 스타일 */
        .comment-form input[type="text"],
        .comment-form textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .comment-form button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
      
      .forprev {
      	margin-left:10%;
      }  
      
      .comments{
      	width:50%;
      	margin-left:25%;
      	text-align:center;
      }
      
      .forup{
      	text-align:center;      
      	
      }
    
      .forup textarea {
    width: 20%;
    height: 40%; /* 원하는 크기로 조절하세요 */
    resize: none;
    border: 1px solid #ccc;
    border-radius: 5px;
   
}


      
      
 
    </style>
</head>
<body>
<%@include file="header.jsp"%>
<h1 class="h1title">질문 상세보기</h1>
<hr class="hr1"/>

<div class="forprev">
<input type="button" value="이전페이지" id="prevPage" name="prevPage">
</div>

<div class="showview">
    <h2 class="titleh2">제목: ${bpost.title}</h2>
</div>

<div class="showview">
    <a>작성자: ${bpost.writer}</a>
    <span class="spacer"></span>
    <a>카테고리: ${bpost.category}</a>
    <span class="spacer"></span>
    <a>조회수: ${bpost.hit}</a>
    <span class="spacer"></span>
    <a>작성일: ${bpost.created}</a>
    <span class="spacer"></span>
    <a>답변수: ${bpost.answer_count} </a>
</div>

<div class="showview">
    <a>내용:${bpost.content}</a>
</div>


<br><br><br><br><br><br><br><br><br>
<hr/>
<br><br><br><br><br><br><br><br><br>



<!-- 댓글 섹션 -->
<div class="comments">
    <h2>댓글 목록</h2>
    <c:forEach items="${comments}" var="comment">
        <div class="comment">
            <p><strong>댓글 작성자: <c:out value="${comment.commenter}" /></strong></p>
            <p><c:out value="${comment.comment_id}" /></p>
            <p><c:out value="${comment.comment_content}" /></p>
            <p><c:out value="${comment.comment_created}" /></p>
            <c:if test="${sessionScope.id == comment.commenter}">
                <button class="deleteComment" data-seqno="${comment.board_seqno}">댓글 삭제</button>
                <button class="edtcmt" data-seqno="${comment.board_seqno}">댓글 수정</button>
                <button class="showreply">답글 보기</button>
                <button class="replyComment">답글 작성</button> <!-- 대댓글 작성 버튼 추가 -->
                
            </c:if>
            <!-- 대댓글 폼 -->
           
            <div class="reply-form" style="display:none;">
    <textarea class="reply-content" placeholder="답글 내용" style="resize:none;"></textarea>
    <button class="submitReply">작성완료</button>
    <button class="cancelReply">닫기</button> <!-- 닫기 버튼 추가 -->
			</div>
			
			
        </div>
        
    </c:forEach>
</div>




      <div class="forup" style="display:none;">
    <h3>댓글 수정</h3>
    <form id="editCommentForm" method="post" action="/editComment">
    
    <input type="hidden" id="commentId" name="commentId"> 
        <textarea style="resize:none;" id="txt" name="content"></textarea>
        <input type="submit" value="수정하기" id="commentedit">
    </form>
    <button class="cmtclose">수정 닫기</button>
</div>






 <br><br><br><br><br><br><br><br>








<c:if test="${!empty sessionScope.id}">
   





<!-- 댓글 입력 폼 스타일 -->
<div class="comment-form">
    <h2>댓글 작성</h2>
    <form id="commentForm" method="post" action="/doincomment" name="commentForm">
        <input type="text" name="board_seqno" id="board_seqno" value="${bpost.seqno}" style="display: none;">
        <input type="text" name="commenter" id="commenter" value="${sessionScope.id}" readonly>
        <textarea name="comment_content" id="comment_content" placeholder="댓글 내용"></textarea>

        <button type="button" id="submitComment">댓글 작성</button>
    </form>
</div>

         </c:if>
      
      
      
      
      
      
         
<c:if test ="${empty sessionScope.id}">
	<p><strong>로그인 후 댓글을 작성할 수 있습니다.</strong>
</c:if>         


<c:if test="${sessionScope.id == bpost.writer}">
   <input type="button" value="삭제" id="del" name="del" data-seqno="${bpost.seqno}">
   <input type="button" value="수정" id="edit" name="edit">
</c:if>


<div id="editForm" style="display: none;">
    <form id="editPostForm" method="post" action="/editPost">
        <input type="hidden" name="seqno" id="seqno" value="${bpost.seqno}">
        <input type="text" name="title" id="title" value="${bpost.title}" placeholder="제목">
        <textarea name="content" id="content" placeholder="내용">${bpost.content}</textarea>
        
        <!-- 카테고리 선택 -->
        <select name="category" id="category">
            <option value="음식점" ${bpost.category == '음식점' ? 'selected' : ''}>음식점</option>
            <option value="관광" ${bpost.category == '관광' ? 'selected' : ''}>관광</option>
            <option value="기타" ${bpost.category == '기타' ? 'selected' : ''}>기타</option>
        </select>
        <button type="button" id="editcomplete">수정 완료</button>
    </form>
    <input type="button" id="editclose" name="editclose" value="닫기">
</div>







<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
    $(document).ready(function () {
    	
    	
    	$('.replyComment').click(function () {
            $(this).next('.reply-form').toggle();
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
		 
    	
    	console.log('commenter:', commenter);
    	console.log('replyContent:', replyContent);
    	console.log(commentId);
		console.log(boardseqno);
    	
    	
    	
    	$.ajax({
        	url: '/doinreply',
        	method: 'POST',
        	data: {
            	commenter: commenter,
            	replyContent: replyContent,
            	commentId: commentId,
            	boardseqno : boardseqno
        	},
        	success: function (data) {
        		if (data==""){
            	alert('답글 작성 완료');
            	window.location.reload();
        		}
        	},
        	error: function (error) {
            	alert('답글 작성에 실패했습니다.'+error);
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
    	 
    	 
    
    	 
    	 
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	$('#prevPage').click(function(){
    		window.location.href="/q&a";
    	})
    	
    	
    	
    	   $('#submitComment').click(function () {
               var boardSeqno = $('#board_seqno').val();
               var commenter = $('#commenter').val();
               var commentContent = $('#comment_content').val();

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
                       comment_content: commentContent
                   },
                   success: function (data) {
                       alert('작성완료')
                       window.location.reload();
                   },
                   error: function (error) {
                       alert('댓글 작성에 실패했습니다.');
                   }
               });
           });
    	
    	
    	
    	
    	
    	
    	$('.edtcmt').click(function () {
    	    // 클릭한 댓글의 내용 가져오기
    	    var commentContent = $(this).closest('.comment').find('p:eq(2)').text();
    	    
    	    // 클릭한 댓글의 comment_id 가져오기
    	    var commentId = $(this).closest('.comment').find('p:eq(1)').text();
    	    
    	    // 클릭한 댓글의 board_seqno 가져오기
    	
    	    
    	    // 수정 폼의 textarea에 댓글 내용 설정
    	    $('#txt').val(commentContent);
    	    
    	    // comment_id와 board_seqno를 숨겨진 입력 필드에 설정
    	    $('#commentId').val(commentId);
    	  
    	    
    	    $('.forup').show();
    	});
    	
    	
    	$('.cmtclose').click(function(){
    		$('.forup').hide();
    	})
    	
    	
    	
		
    	// 수정 폼 열림
    	$('#edit').click(function () {
            $('#editForm').show();        
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
    	
    	
    	
    	

    	
    	
    	
    	
    	
    	
    	// 삭제
    	 $('#del').click(function () {
    	        let seqno = $(this).data('seqno'); 
    	        $.ajax({
    	            url: '/deletePost',
    	            data: { seqno: seqno },
    	            type: 'post',
    	            success: function (data) {
    	                alert('게시글이 삭제되었습니다.');
    	                window.location.href="/q&a";
    	            },
    	            error: function (error) {
    	                alert('페이지 에러');
    	            }
    	        });
    	    });
    	
    	
    	
    	
    	
    	 $('.deleteComment').click(function () {
    		  
    		    if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
    		      
    		        var seqno = $(this).data('seqno');
    		        
    		        
    		        var commentId = $(this).parent().find('p:eq(1)').text().trim();
    		        
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


    	 
    	 $('#editCommentForm').submit(function (event) {
             event.preventDefault();

             // 폼에서 필요한 데이터 가져오기
             var content = $('#txt').val(); // 수정된 댓글 내용
             var boardSeqno = $('#board_seqno').val(); // 게시물 번호
             var commentId = $('#commentId').val(); // 댓글 ID
             
             console.log(content);
             console.log(boardSeqno);
             console.log(commentId);
             
             

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
