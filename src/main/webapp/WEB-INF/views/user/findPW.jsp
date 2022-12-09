<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BANDo</title>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/mainpage.css">
<link rel="stylesheet" href="../resources/css/sign.css">
</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="sign">
	<div class="find"><span>임시 비밀번호 발급</span></div>
	<form id="findPwForm" method="post" action="/user/sendMail">
	<div>
		<div class="sign_bot">
			<label class="text_sizing">아이디</label><br>
			<input type="text" name="ID" class="sign_box" placeholder="아이디 입력">
		</div>
		<div class="sign_bot">
			<label class="text_sizing">이메일</label><br>
			<input type="text" name="EMAIL" class="sign_box" placeholder="이메일 입력">
			<span id="email_warn"></span>
		</div>
		<div>
			<span id="PwValue"></span>
		</div>
		<div class="sign_wall">
			<button type="button" class="find_btn button">임시 비밀번호 발급</button>
			<span><a href="/user/findID">아이디 찾으러 가기🔓</a></span><br>
			<span><a href="/user/login">로그인 하러가기👈</a></span>
		</div>
	</div>
	</form>
</div>
<script>
$(".find_btn").click(function(){
	var ID = $('input[name="ID"]').val();
	var EMAIL = $('input[name="EMAIL"]').val();
	var mailvalchk = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/
	
	if(ID == "" || ID == null){
		alert("아이디를 입력해 주세요.");
		$('input[name="ID"]').focus();
		return;
	}
	if(EMAIL == '' || EMAIL.length>40 || EMAIL.length<7 || !mailvalchk.test(EMAIL)){
		alert("이메일을 양식에 맞추어 입력해 주세요.");
		$('input[name="EMAIL"]').focus();
		return;
	}
	var data = {'ID':ID, 'EMAIL':EMAIL};
	$.ajax({
		type:"post",
		url:"/user/findPwCheck",
		data:data,
		success:function(result){
			if(result == null || result == ""){
				alert('가입 정보를 찾을 수 없습니다.');
			}else{
				alert('임시 비밀번호가 발급되었습니다. 메일을 확인해 주세요.');
				$("#findPwForm").submit();
			}
		}
	})
})
</script>
</body>
</html>