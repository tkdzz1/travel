<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>

<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    margin: 0;
    padding: 0;
  }

  h1 {
    text-align: center;
    color: #333;
  }

  table {
    border-collapse: collapse;
    width: 75%;
    margin: 0 auto;
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  th {
    background-color: #333;
    color: #fff;
    text-align: left;
    padding: 10px;
    border: 1px solid #ddd;
  }

  td {
    padding: 10px;
    border: 1px solid #ddd;
  }

  input[type="text"],
  textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
  }

  input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
  }

  a {
    text-decoration: none;
    color: #007bff;
  }

  a:hover {
    text-decoration: underline;
  }
  
   select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
  }
  
  
</style>

</head>
<body>
<%@include file="header.jsp"%>
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
      <tr>
        <td><a href="/q&a">목록으로</a></td>
        <td style="text-align:right;">
          <input type="submit" id="btnSubmit" name="btnSubmit" value="작성완료">&nbsp;&nbsp;
        </td>
      </tr>
    </table>
  </form>
	  <%@include file="footer.jsp"%>
</body>
  <script src="https://code.jquery.com/jquery-latest.js"></script>
  <script>
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