<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div class="sign">
	<div class="sign_logo"><a href="/"><img style="width:200px;" src="../resources/image/logo-darkviolet.png"></a></div>
	<FORM id="signupForm" method="post" action="/user/signupCheck">
		<div>
			<div class='sign_bot'>
				<label class="text_sizing">아이디</label><br>
				<input type="text" name="ID" class="sign_box id_input" placeholder="6~15자 사이로 입력해 주세요">
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
				<span class="id_input_re_2">이미 사용중인 아이디입니다.</span>
				<span class="id_chk">아이디는 6~15자사이로 입력해 주세요.</span>
			</div>
			<div class='sign_bot'>
				<label class="text_sizing">비밀번호</label><br>
				<input type="password" name="PASSWORD" class="sign_box" placeholder="8~20자 사이로 입력해 주세요">
				<span class="pw_chk">비밀번호는 영대소문자, 숫자로 구성된 8자~20자 사이로 입력해 주세요.</span>
			</div>
			<div class='sign_bot'>
				<div><label class="text_sizing">이메일</label></div>
				<div><input type="text" name="EMAIL" class="sign_box" placeholder="ireumkim@email.com"></div>
				<span class="em_input_re_1">사용 가능한 이메일입니다.</span>
				<span class="em_input_re_2">이미 사용중인 이메일입니다.</span>
				<span class="mail_chk">이메일을 입력해 주세요.</span>
				<div>
					<input type="text" placeholder="인증번호 6자리 입력" class="mail_check_input emchkval" disabled="disabled" maxlength="6">
					<input type="button" id="mail_btn" disabled="disabled" value="인증번호 전송">
				</div>
				<span class="mailnum_chk">인증번호를 입력해 주세요.</span>
				<div><span class="mail_check_warn"></span></div>
			</div>
			<div class='sign_bot'>
				<label class="text_sizing">실명</label><br>
				<input type="text" name="NAME" class="sign_box" placeholder="김이름">
				<span class="name_chk">실명을 입력해 주세요.</span>
			</div>
			<div class='sign_bot'>
				<label class="text_sizing">별명</label><br>
				<input type="text" name="NICK_NAME" class="sign_box" placeholder="10자 이하로 입력해 주세요">
				<span class="nick_chk">별명을 입력해 주세요.</span>
			</div>
		</div>
		<div class="sign_wall">
			<button type="button" class="button" id="join_button">회원가입</button>
			<div>
				<span class="text_sizing">이미 회원이신가요? <a href="/user/login" class="sign_a">로그인</a></span>
			</div>
		</div>
	</FORM>
</div>
<script type="text/javascript">
var idChk = false;
var idChkol = false;
var pwChk = false;
var nameChk = false;
var mailChk = false;
var emChkol = false;
var nickChk = false;
var emnumChk = false;

$(document).ready(function(){
	$("#join_button").click(function(){
		var id = $("input[name='ID']").val();
		var pw = $("input[name='PASSWORD']").val();
		var mail = $("input[name='EMAIL']").val();
		var name = $("input[name='NAME']").val();
		var nick = $("input[name='NICK_NAME']").val();
		var emchk = $(".emchkval").val();
		
		var valchk = /^[A-Za-z0-9]+$/
		var namevalchk = /^[가-힣a-zA-Z]+$/
		var nickvalchk = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/
		var mailvalchk = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/
		/* 아이디 유효성 검사 */
		if(id == "" || id.length<6 || id.length>15 || !valchk.test(id)){
			$(".id_chk").css('display', 'block');
			idChk = false;
		}else{
			$(".id_chk").css('display', 'none');
			idChk = true;
		}
		/* 비밀번호 유효성 검사 */
		if(pw == "" || pw.length<8 || pw.length>20 || !valchk.test(pw)){
			$(".pw_chk").css('display', 'block');
			pwChk = false;
		}else{
			$(".pw_chk").css('display', 'none');
			pwChk = true;
		}
		/* 메일 유효성 검사 */
		if(mail == "" || !mailvalchk.test(mail)){
			$(".mail_chk").css('display', 'block');
			mailChk = false;
		}else{
			$(".mail_chk").css('display', 'none');
			mailChk = true;
		}
		/* 실명 유효성 검사 */
		if(name == "" || !namevalchk.test(name)){
			$(".name_chk").css('display', 'block');
			nameChk = false;
		}else{
			$(".name_chk").css('display', 'none');
			nameChk = true;
		}
		/* 별명 유효성 검사 */
		if(nick == "" || !nickvalchk.test(nick)){
			$(".nick_chk").css('display', 'block');
			nickChk = false;
		}else{
			$(".nick_chk").css('display', 'none');
			nickChk = true;
		}
		if(emnumChk == false){
			alert("메일 인증이 완료되지 않았습니다.");
			$('.mailnum_chk').css('display', 'block');
			emnumChk = false;
		}else{
			$('.mailnum_chk').css('display', 'none');
			emnumChk = true;
		}
		/* 최종 유효성 검사 */
		if(idChk&&idChkol&&pwChk&&mailChk&&nameChk&&nickChk&&emnumChk){
			$("#signupForm").attr("action", "/user/signupCheck");
			$("#signupForm").submit();
		}
		return false;
	});
});
$(".id_input").on("propertychange change keyup paste input", function(){
	var ID = $(".id_input").val();
	var data = {ID:ID}
	var valchk = /^[A-Za-z0-9]+$/
	if(ID == '' || ID.length<6 || ID.length>15 || !valchk.test(ID)){
		//문구가 지워지도록
		$('.id_input_re_1').css("display", "none");
		$('.id_input_re_2').css("display", "none");
		return;
	}else{ 
		$(".id_chk").css('display', 'none');
	}
	$.ajax({
		type:"post",
		url:"/user/userIdChk",
		data:data,
		success:function(result){
			// console.log("성공 여부"+result);
			if(result != 'fail'){
				$('.id_input_re_1').css("display", "inline-block");
				$('.id_input_re_2').css("display", "none");
				$('#mail_btn').attr('disabled',false);
				idChkol = true;
			}else{
				$('.id_input_re_2').css("display", "inline-block");
				$('.id_input_re_1').css("display", "none");
				idChkol = false;
			}
		}
	});
});
$("input[name='PASSWORD']").on("propertychange change keyup paste input", function(){
	var pw = $("input[name='PASSWORD']").val();
	if(pw != ""){
		$(".pw_chk").css('display', 'none');
		return;
	}
});
$("input[name='EMAIL']").on("propertychange change keyup paste input", function(){
	var EMAIL = $("input[name='EMAIL']").val();
	var data = {EMAIL:EMAIL}
	var mailvalchk = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/
	if(EMAIL == '' || EMAIL.length>40 || EMAIL.length<7 || !mailvalchk.test(EMAIL)){
		$('.em_input_re_1').css("display", "none");
		$('.em_input_re_2').css("display", "none");
		return;
	}else{
		$(".mail_chk").css('display', 'none');
	}
	$.ajax({
		type:"post",
		url:"/user/userEmChk",
		data:data,
		success:function(result){
			console.log("성공여부"+result);
			if(result != 'fail'){
				$('.em_input_re_1').css("display", "inline-block");
				$('.em_input_re_2').css("display", "none");
				$('#mail_btn').attr('disabled',false);
				emChkol = true;
			}else{
				$('.em_input_re_2').css("display", "inline-block");
				$('.em_input_re_1').css("display", "none");
				$('#mail_btn').attr('disabled',true);
				emChkol = false;
			}
		}
	})
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
$('#mail_btn').click(function(){
	var EMAIL = $("input[name='EMAIL']").val();
	console.log('이메일 주소'+EMAIL);
	var checkinput = $('.mail_check_input');
	
	$.ajax({
		type:'get',
		url:'/user/mailCheck?EMAIL='+EMAIL,
		success:function(data){
			// console.log("data : "+data)
			checkinput.attr('disabled',false);
			code = data;
			alert("인증번호가 전송되었습니다.")
		}
	});
});
// 인증번호 비교
$('.mail_check_input').blur(function(){
	var input = $('.mail_check_input').val();
	var resultMsg = $('.mail_check_warn');
	
	if(input === code){
		$('.mailnum_chk').css('display', 'none');
		resultMsg.html('인증번호가 일치합니다.');
		resultMsg.css('color','green');
		$('#mail_btn').attr('disabled',true);
		$("input[name='EMAIL']").attr('readonly',true);
		emnumChk = true;
	}else{
		$('.mailnum_chk').css('display', 'none');
		resultMsg.html('인증번호를 다시 확인해 주세요.');
		resultMsg.css('color','red');
		emnumChk = false;
	}
})
</script>
</body>
</html>