var emailRegExp =/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/;
var emailCode = "";
$(document)
.on('click','#emailCheck',function(){
	if( !emailRegExp.test($('input[name=email]').val()) ) {
		alert("이메일 형식을 확인해주세요.");
		return false;
	}
	
	$.ajax({url:'/emailConfirm', type:'post', data: { email : $('input[name=email]').val() }, dataType:'text',
		success: function(data) {
			if ( data == "1" ){
				$('#loginPassword').show();
				return false;
			} else {
				emailCode = data;
				$('#emailCode').show();
				return false;
			}
		}, error: function(e) {
			alert("error : " + e);
			return false;
		}
	})
})
.on('click','#codeCheck',function(){
	if ( emailCode == $('input[name=code]').val() ) {
		$('#password').show();
		return false;
	} else {
		alert("인증코드가 불일치합니다.");
		return false;
	}
})
.on('click','#signUp',function(){
	if( $('input[name=password]').val() == '' ) {
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	
	$.ajax({url:'/signUp', type:'post', data: { email : $('input[name=email]').val(), password : $('input[name=password]').val() }, dataType:'text',
		success: function(data) {
			$('#mail').text(data + "님 환영합니다!");
			$('#loginDIV').hide();
			$('#emailCode').hide();
			$('#password').hide();
			$('#signUpSuccess').show();
		}, error: function(){
			alert("가입 중 에러 발생 !");
		}
		
	})
})
.on('click','#login',function(){
	$.ajax({url:'/login', data:{email : $('input[name=email]').val(), pw : $('input[name=loginPassword]').val()}, type:'post', dataType:'text',
		success:function(data){
			if (data == "1") {
				document.location = "/";
				return false;
			}else {
				alert("입력하신 회원정보와 일치하는 데이터가 없습니다.");
				return false;
			}
		}, error:function(){
			
		}
	})
})
.on('click','#kakaoLogin',function(){
 	window.location.href = 'http://kauth.kakao.com/oauth/authorize?client_id=7fb612febcabd2e33c624c45cf59cfd5&redirect_uri=http://localhost:8080/oauth/kakao&response_type=code';
})