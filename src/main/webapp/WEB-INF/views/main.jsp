<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BANDo</title>
<link rel="stylesheet" href="resources/css/mainpage.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
</head>
<body>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now" />
<div id="wrap">
<section>
<div id="main_container">
<header>
<div id="main_head">
	<div class="main_head_right">
		<nav>
			<ul class="ctgr">
				<li><a href="/"><img style="width:150px" src="resources/image/logo-darkviolet.png"></a></li>
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
<div id="main_main">
	<div id="main_image">
		<div class="slider" style="width:800px;">
		    <div><img src="resources/image/violet-banner.png"></div>
		    <div><img src="resources/image/blue-banner.png"></div>
		</div>
	</div>
	<div id="main_comu">
		<div id="main_2">
			<a href="/match/search" style='text-align:center;'><span class="find_band">모임찾기 🔍</span></a>
		</div>
		<div id="main_3">
			<div><span>3일 이내 커뮤니티 인기 게시글</span><span style='float:right;'><a href="/board/list">+ 커뮤니티 가기</a></span></div>
			<c:choose>
			<c:when test="${not empty bestlist}">
			<c:forEach items="${bestlist}" var="data" begin="0" end="5">
			<fmt:formatDate value="${data.board.regdate}" pattern="yyyy-MM-dd" var="formatdate"/>
				<div style="padding:5px;">
				<div>
				<span>${data.board.NICK_NAME}</span> 
				<c:choose>
					<c:when test="${formatdate eq now}">
						<fmt:formatDate value="${data.board.regdate}" pattern="HH:mm" var="formatnow"/>${formatnow}
					</c:when>
					<c:otherwise>${formatdate}</c:otherwise>
				</c:choose></div>
				<div style="padding:3px;"><a href='/board/view?bno=${data.board.bno}&bgno=${data.board.bgnoinsert}'>
					<span>${data.board.title}</span>
				</a></div>
				<div style='text-align:right;'><span>❤ ${data.board.likehit}</span>
				<span>💬 ${data.board.cmthit}</span></div>
				</div>
			</c:forEach>
			</c:when>
			<c:otherwise>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
</div></section>
	<footer>
		<p><a href='/board/list?bgno=4'>공지사항</a></p>
		<p><a href="git">Github</a></p>
		<p><a href="https://mmmyom2.tistory.com/">Blog</a></p>
		<p>제작 : 김민서</p>
		<p>이메일 : minseo20807@gmail.com</p>
	</footer>
</div>

<script>
    $(document).ready(function(){
      $('.slider').bxSlider({
    	  slideWidth:800,
    	  autoHover:true,
    	  auto:true,
    	  autoControls:false,
    	  controls:false,
    	  pager:false,
    	  mode:'horizontal',
    	  speed:500
      });
    });
</script>
</body>
</html>