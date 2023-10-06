<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>

<style>
  body {
    font-family: Arial, sans-serif !important;
    margin: 0 !important;
    padding: 0 !important;
  }

  h1 {
    text-align: center !important;
    color: #333 !important;
  }

  table {
    border-collapse: collapse !important;
    width: 80% !important;
    margin: 0 auto !important;
    background-color: #fff !important;
    border: 1px solid #ddd !important;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
    padding: 20px !important;
  }

  th {
    background-color: #333 !important;
    color: #fff !important;
    text-align: left !important;
    padding: 10px !important;
    border: 1px solid #ddd !important;
  }

  td {
    padding: 10px !important;
    border: 1px solid #ddd !important;
  }

  input[type="text"],
  textarea,
  select {
    width: 100% !important;
    padding: 10px !important;
    border: 1px solid #ddd !important;
    border-radius: 5px !important;
    margin-bottom: 10px !important;
  }


  a {
    text-decoration: none !important;
    color: #007bff !important;
  }

  a:hover {
    text-decoration: underline !important;
  }

 

  /* 추가한 부분: 버튼 스타일 */
  #btnSubmit, #btnPrev {
    background-color: #007bff !important;
    color: #fff !important;
    border: none !important;
    border-radius: 5px !important;
    cursor: pointer !important;
  }

  #btnSubmit:hover, #btnPrev:hover {
    background-color: #0056b3 !important;
  }
</style>

</head>
<body>
<%@include file="header.jsp"%>
<br><br><br>
  <h1>게시물 작성</h1>
  <form method="post" action="/insert" id="frmInsert" name="frmInsert">
    <table>
      <tr>
        <td>제목</td>
        <td><input type="text" name="title" id="title" size="64" maxlength="128"></td>
      </tr>
      <tr>
        <td>카테고리</td>
        <td>
          <select name="category" id="category">
            <option value="음식점">음식점</option>
            <option value="관광지">관광지</option>
            <option value="기타">기타</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>내용</td>
        <td><textarea rows="10" cols="64" name="content" id="content"></textarea></td>
      </tr>
      <tr><td></td>
        <td style="text-align:right;">
          <input type="submit" id="btnSubmit" name="btnSubmit" value="작성완료">&nbsp;&nbsp;
          <input type="button" id="btnPrev" value="이전으로">
        </td>
      </tr>
    </table>
  </form>
  <br><br><br><br>
	  <%@include file="footer.jsp"%>
</body>
  <script src="https://code.jquery.com/jquery-latest.js"></script>
  <script>
  $(document)
  .ready(function(){
	  $('#btnPrev').click(function(){
		  window.location.href="/q&a";
	  })
  })
  
  
  
  
  
    $(document).on('submit', '#frmInsert', function () {
      if ($('#title').val() === '') {
        alert('제목을 입력하세요.');
        return false;
      }

      if ($('#category').val() === '카테고리 선택') {
        alert('카테고리를 선택하세요.');
        return false;
      }

      if ($('#content').val() === '') {
        alert('게시물 내용을 입력하세요.');
        return false;
      }

      alert('작성 완료!');
      return true;
    });
  </script>
</html>