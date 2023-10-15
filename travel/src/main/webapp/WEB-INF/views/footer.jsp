<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
 
footer {
  background-color: #3c3c3c;
  border-top: 1px solid #333;
}


footer .inner {
  padding: 40px 0 60px 0 !important;
  
}


footer .menu {
  display: flex;
  justify-content: center !important;
  list-style: none !important;
  margin-right:30px !important;
}


footer .menu li {
  position: relative;
}


footer .menu li::before {
  content: "";
  width: 3px;
  height: 3px;
  background-color: #555;
  position: absolute;
  top: 0;
  bottom: 0;
  right: -1px;
  margin: auto;
}


footer .menu li:last-child::before {
  display: none;
}


footer .menu li a {
  color: #ccc;
  font-size: 12px;
  font-weight: 700;
  padding: 15px;
  display: block;
  

}



footer .menu li a.green {
  color: #669900;
}


footer .btn-group {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  
}


footer .btn-group .btn {
  font-size: 12px;
  margin-right: 10px;
}


footer .btn-group .btn:last-child {
  margin-right: 0px;
}


footer .info {
  margin-top: 30px;
  text-align: center;
  background-color: #3c3c3c;
  border: 1px solid #3c3c3c;
}


footer .info span {
  margin-right: 20px;
  color: #999;
  font-size: 12px;
}


footer .info span:last-child {
  margin-right: 0;
}


footer .copyright {
  color: #999;
  font-size: 12px;
  text-align: center;
  margin-top: 12px;
}


footer .logo {
  margin: 30px auto 0;
}


@font-face {
    font-family: 'CookieRun-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/CookieRun-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal; 
}

@font-face {
    font-family: 'HakgyoansimWoojuR';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/HakgyoansimWoojuR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}




</style>




<body>


<div id="footer">


<footer class="forfooter">
  <div class="inner">
  
  <!-- menu1 이라는 class name을 menu로 변경 -->
   
   
    <div class="info">
      <span>사업자등록번호 213-23-12512</span>
      <span>TRAVEL JEJU</span>
      <span>TEL : 02) 2222-2222 / FAX : 02) 4242-2424</span>
      <span>개인정보 책임자 : TRAVEL JEJU</span>
    </div>

    <p class="copyright">
      &copy; <span class="this-year"></span> TRAVEL JEJU Company. All Rights Reseved.
    </p>
  

  </div>
</footer>
</div>


</body>
</html>