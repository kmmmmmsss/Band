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
	<div class="find"><span>아이디 찾기</span></div>
	<form id="findIdForm" method="post" action="/user/findIdCheck">
	<div>
		<div class="sign_bot">
			<label class="text_sizing">이름</label><br>
			<input type="text" name="NAME" class="sign_box" placeholder="이름 입력">
		</div>
		<div class="sign_bot">
			<label class="text_sizing">이메일</label><br>
			<input type="text" name="EMAIL" class="sign_box" placeholder="이메일 입력">
		</div>
		<div id="modal_layer">
			<!-- 모달창 내부 -->
			<div id="modal_in">
				<span id="idValue"></span>
			</div>
			<div><button type="button" class="button modalbtn">확인</button></div>
			<!-- 모달창 배경 -->
			<div class="modalback"></div>
		</div>
		<div class="sign_wall">
			<button type="button" onclick="findId()" class="find_btn button">찾기</button>
			<span><a href="/user/findPW">임시 비밀번호 발급 받으러 가기🔒</a></span><br>
			<span><a href="/user/login">로그인 하러가기👈</a></span>
		</div>
	</div>
	</form>
</div>
<script>
$('.modalbtn').click(function(){
	//$('#modal_layer').css("display", "none");
	$('#modal_layer').fadeOut();
})
function findId(){
	var nameVal=$('input[name="NAME"]').val();
	var mailVal=$('input[name="EMAIL"]').val();
	var mailvalchk = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/
	
	if(nameVal == "" || nameVal == null){
		alert("이름을 입력해 주세요.");
		$('input[name="NAME"]').focus();
		return;
	}
	if(mailVal == "" || mailVal == null || !mailvalchk.test(mailVal)){
		alert("이메일을 양식에 맞추어 입력해 주세요.");
		$('input[name="EMAIL"]').focus();
		return;
	}
	var data = {'NAME':nameVal,'EMAIL':mailVal};
	//$('#modal_layer').css("display", "block");
	$('#modal_layer').fadeIn();
	$.ajax({
		url:"/user/findIdCheck",
		type:"post",
		data:data,
		success:function(text){
			if(text == null || text == ""){
				$('#idValue').html("해당 정보가 없습니다.");
			}else{
				$('#idValue').html(nameVal+" 님의 아이디는 "+text+"입니다.");
				$('input[name="NAME"]').val('');
				$('input[name="EMAIL"]').val('');
			}
		}
	})
}
</script>
</body>
</html>