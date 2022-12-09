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
	<FORM name="loginForm" method="post" action="/user/loginCheck">
		<div>
			<label class="text_sizing">아이디</label><br>
			<input type="text" name="ID" class="sign_box"><br>
			<label class="text_sizing">비밀번호</label><br>
			<input type="password" name="PASSWORD" class="sign_box">
		</div>
		<div class="sign_wall">
			<c:if test="${message == 'fail'}">
				<div>
					<span style="color:red;" class="text_sizing">아이디 또는 비밀번호가 일치하지 않습니다.</span>
				</div>
			</c:if>
			<button type="submit" class="button">로그인</button>
			<div>
				<span class="text_sizing">회원이 아니신가요? <a href="/user/signup" class="sign_a">회원가입</a><br>
				계정 정보를 잊으셨나요? <a href="/user/findID" class="sign_a">아이디</a> 또는 <a href="/user/findPW" class="sign_a">비밀번호</a> 찾기</span>
			</div>
		</div>
	</FORM>
</div>
</body>
</html>