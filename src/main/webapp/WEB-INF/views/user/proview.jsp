<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BANDo</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/mainpage.css">
<link rel="stylesheet" href="../resources/css/sign.css">
</head>
<body>
<jsp:include page="../header.jsp"/>
<form id="userupdateForm" method="post" action="/user/userUpdate">
<div class="proview">
	<div class="proview_input">
	<span class="proview_top">회원 정보 수정</span>
	<div class="input_top">
		<label>아이디</label><br>
		<input type="text" name="ID" class="sign_box" value="${profile.ID}" readonly>
		<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
		<span class="id_input_re_2">이미 사용중인 아이디입니다.</span>
		<span class="id_chk">아이디는 6~15자사이로 입력해 주세요.</span>
	</div>
	<div class="input_top">
		<label>비밀번호</label><br>
		<input type="password" name="PASSWORD" class="sign_box" value="${profile.PASSWORD}" placeholder="8~20자 사이로 입력해 주세요">
		<span class="pw_chk">비밀번호는 영대소문자, 숫자로 구성된 8자~20자 사이로 입력해 주세요.</span>
	</div>
	<div class="input_top">
		<label>이메일</label><br>
		<input type="text" name="EMAIL" class="sign_box" value="${profile.EMAIL}" readonly="readonly" placeholder="ireumkim@email.com">
		<span class="mail_chk">이메일을 입력해 주세요.</span>
	</div>
	<div class="input_top">
		<label>실명</label><br>
		<input type="text" name="NAME" class="sign_box" value="${profile.NAME}" placeholder="김이름">
		<span class="name_chk">실명을 입력해 주세요.</span>
	</div>
	<div class="input_top">
		<label>별명</label><br>
		<input type="text" name="NICK_NAME" class="sign_box" value="${profile.NICK_NAME}" placeholder="10자 이하로 입력해 주세요">
		<span class="nick_chk">별명은 10자 이내로 입력해 주세요.</span>
	</div>
	<div class="input_top">
		<label>소개</label><br>
		<input type="text" name="INTRO" class="sign_box" value="${profile.INTRO}" placeholder="100자 이내로 자신을 소개해 보세요.">
		<span class="intro_chk">소개는 100자 이내로 입력해 주세요.</span>
	</div>
	</div>
	<div>
		<button type="button" class="button" id="updatebtn">회원정보 수정 완료</button>
	</div>
	<div>
		<a href="/user/draw">회원 탈퇴</a>
	</div>
</div>
</form>
<script>
var pwChk = false;
var nameChk = false;
var mailChk = false;
var nickChk = false;
var introChk = false;

	$(document).ready(function(){
		$("#updatebtn").click(function(){
			var pw = $("input[name='PASSWORD']").val();
			var mail = $("input[name='EMAIL']").val();
			var name = $("input[name='NAME']").val();
			var nick = $("input[name='NICK_NAME']").val();
			var intro = $("input[name='INTRO']").val();
			
			var valchk = /^[A-Za-z0-9]+$/
			var namevalchk = /^[가-힣a-zA-Z]+$/
			var nickvalchk = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/
			var mailvalchk = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/
			
			/* 비밀번호 유효성 검사 */
			if(pw == "" || pw.length<8 || pw.length>20 || !valchk.test(pw)){
				$(".pw_chk").css('display', 'block');
				pwChk = false;
			}else{
				$(".pw_chk").css('display', 'none');
				pwChk = true;
			}
			/* 메일 유효성 검사 */
			if(mail == "" || !mailvalchk.test(mail) || mail.length>50){
				$(".mail_chk").css('display', 'block');
				mailChk = false;
			}else{
				$(".mail_chk").css('display', 'none');
				mailChk = true;
			}
			/* 실명 유효성 검사 */
			if(name == "" || !namevalchk.test(name) || name.length>20){
				$(".name_chk").css('display', 'block');
				nameChk = false;
			}else{
				$(".name_chk").css('display', 'none');
				nameChk = true;
			}
			/* 별명 유효성 검사 */
			if(nick == "" || nick.length>10 || !nickvalchk.test(name)){
				$(".nick_chk").css('display', 'block');
				nickChk = false;
			}else{
				$(".nick_chk").css('display', 'none');
				nickChk = true;
			}
			/* 소개 유효성 검사 */
			if(intro == "" || intro.length>100){
				$(".intro_chk").css('display', 'block');
				introChk = false;
			}else{
				$(".intro_chk").css('display', 'none');
				introChk = true;
			}
			if(pwChk&&mailChk&&nameChk&&nickChk&&introChk){
				$("#userupdateForm").attr("action","/user/userUpdate");
				$("#userupdateForm").submit();
			}
			return false;
		})
	})
$("input[name='PASSWORD']").on("propertychange change keyup paste input", function(){
	var pw = $("input[name='PASSWORD']").val();
	if(pw != ""){
		$(".pw_chk").css('display', 'none');
		return;
	}
});
$("input[name='EMAIL']").on("propertychange change keyup paste input", function(){
	var mail = $("input[name='EMAIL']").val();
	if(mail != ''){
		$(".mail_chk").css('display', 'none');
		return;
	}
});
$("input[name='NAME']").on("propertychange change keyup paste input", function(){
	var name = $("input[name='NAME']").val();
	if(name != ''){
		$(".name_chk").css('display', 'none');
		return;
	}
});
$("input[name='NICK_NAME']").on("propertychange change keyup paste input", function(){
	var nick = $("input[name='NICK_NAME']").val();
	if(nick != ""){
		$(".nick_chk").css('display', 'none');
		return;
	}
});
$("input[name='INTRO']").on("propertychange change keyup paste input", function(){
	var intro = $("input[name='INTRO']").val();
	if(intro != ""){
		$(".nick_chk").css('display', 'none');
		return;
	}
});
</script>
</body>
</html>