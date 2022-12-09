<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BANDo</title>
<link rel="stylesheet" href="../resources/css/mainpage.css">
</head>
<body>
<div id="wrap">
<section>
<div id="main_container">
<header>
<div id="main_head">
	<div class="main_head_right">
		<nav>
			<ul class="ctgr">
				<li><a href="/"><img style="width:150px" src="../resources/image/logo-darkviolet.png"></a></li>
				<li class="litest"><a href="/match/search">합주모임</a></li>
				<li class="litest"><a href="/board/list">커뮤니티</a></li>
			</ul>
		</nav>
	</div>
	<div class="main_user">
		<nav>
			<ul>
				<c:choose>
					<c:when test="${sessionScope.login == null}"> <!-- 로그인 하지 않았을 경우 -->
						<li class="litest"><a href="/user/login">로그인</a></li>
						<li class="litest right"><a href="/user/signup">회원가입</a></li>
					</c:when>
					<c:when test="${sessionScope.login.ID == 'admin'}"> <!-- 로그인(관리자 아이디)일 경우 -->
						<li class="litest"><a href="/user/profile?ID=${sessionScope.login.ID}">${sessionScope.login.NICK_NAME}</a></li>
						<li class="litest right"><a href="/user/logout">로그아웃</a></li>
					</c:when>
					<c:otherwise> <!-- 로그인(일반 아이디)일 경우 -->
						<li class="litest"><a href="/user/profile?ID=${sessionScope.login.ID}">${sessionScope.login.NICK_NAME}</a></li>
						<li class="litest right"><a href="/user/logout">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>
</div>
</header>
</div></section>
</body>
</html>