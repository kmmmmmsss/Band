<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div class="draw">
	<div class="sign_logo"><a href="/"><img style="width:200px;" src="../resources/image/logo-darkviolet.png"></a>
		<div class="sign_logo_sp"><span>회원 탈퇴</span></div>
	</div>
	<form method="post" action="/user/userdraw">
		<div>
			<label class="text_sizing">아이디</label><br>
			<input type="text" name="ID" class="sign_box" readonly="readonly" value="${sessionScope.login.ID}">
		</div>
		<div>
			<label class="text_sizing">비밀번호</label><br>
			<input type="password" class="sign_box" name="PASSWORD">
		</div>
		<div>
			<label class="text_sizing">이름</label><br>
			<input type="text" class="sign_box" name="NAME" readonly="readonly" value="${sessionScope.login.NAME}">
		</div>
		<div>
		<c:if test="${msg == false}">
			비밀번호가 일치하지 않습니다.
		</c:if>
		</div>
		<div class="draw_btn">
			<button type="submit" class="btn" id="drawsubmit">탈퇴하기</button>
			<button type="button" class="btn" id="drawback">메인 페이지로 이동하기</button>
		</div>
	</form>
</div>
<script>
var sessionpd = '${sessionScope.login.PASSWORD}';
var inputpd = $("input[name='PASSWORD']").val();
$(document).ready(function(){
	$("#drawback").on("click", function(){
		location.href="/";
	});
	$("#drawsubmit").on("click", function(){
		if($("input[name='PASSWORD']").val() == ""){
			alert("비밀번호를 입력해 주세요.")
			$("input[name='PASSWORD']").focus();
			return false;
		}
		if($("input[name='ID']").val() == '' || $('input[name="NAME"]').val() == ''){
			alert("로그인 상태를 확인해 주세요.");
			location.href="/";
			return false;
		}
	});
})
</script>
</body>
</html>