<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
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
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now" />
<div>
	<c:choose>
	<c:when test="${not empty profile.ID}">
	<div class="profile">
		<div>
			<div class="pro_header">
				<span class="pro_nick"><c:out value="${profile.NICK_NAME}"/></span>
			</div>
			<c:if test="${profile.INTRO != null}">
				<div class="pro_intro">
					<c:out value="${profile.INTRO}"/>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.ID == profile.ID && sessionScope.login.ID != null}">
				<a class="profile_a" href="/user/proview?ID=${sessionScope.login.ID}">회원정보/프로필 편집</a>
			</c:if>
		</div>
	</div>
	<div class="pchoice">
		<span class="mymy" id="myband">참여 내역</span>
		<span class="mymy" id="myboard">작성글 보기</span>
		<span class="mymy" id="mylike">추천 누른 글</span>
	</div>
	<div class="profileband pchoice">
		<div>
			<div>개설한 밴드</div>
				<c:choose>
					<c:when test="${sessionScope.login.ID == profile.ID && sessionScope.login.ID != null}">
						<div class='commonband registBand'>
							<a href="/match/regist" onclick="needLoc(); return;">
								+ 개설하기
							</a>
						</div>
					</c:when>
					<c:when test="${not empty bandInfo}">
						<c:forEach items="${bandInfo}" var="data">
						<c:choose>
							<c:when test="${data.band.m_ID == '' || data.band.m_ID == 'admin'}">
								<span>개설한 밴드가 없습니다.</span>
							</c:when>
						<c:otherwise>
						<fmt:formatDate value="${data.band.m_date}" pattern="yyyy-MM-dd" var="formatdate"/>
							<div class='commonband registBand'>
								<div>
									<a href="/match/mview?m_no=${data.band.m_no}">${data.band.m_title}</a>
									<c:choose>
										<c:when test="${formatdate eq now}">
											<fmt:formatDate value="${data.band.m_date}" pattern="HH:mm" var="formatnow"/>${formatnow}
										</c:when>
										<c:otherwise>${formatdate}</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${data.band.m_sort == 1}">
											<span>팝</span>
										</c:when>
										<c:when test="${data.band.m_sort == 2}">
											<span>락</span>
										</c:when>
										<c:when test="${data.band.m_sort == 3}">
											<span>재즈</span>
										</c:when>
										<c:when test="${data.band.m_sort == 4}">
											<span>랜선</span>
										</c:when>
									</c:choose>
								</div>
							</div></c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			
		</div><br>
	</div>
	<div class="profilebottom pchoice">
		<table class="tb_pro">
			<tr height="30px">
				<td width="120px">카테고리</td>
				<td width="350px">제목</td>
				<td width="100px">조회수</td>
				<td width="100px">추천 수</td>
				<td width="180px">날짜</td>
			</tr>
			<c:forEach items="${getInfo}" var="data">
				<c:choose>
					<c:when test="${data.board.bno == null || data.board.bno == ''}">
						<tr>
							<td colspan="5">작성한 글내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
				<tr height="50px">
					<fmt:formatDate value="${data.board.regdate}" pattern="yyyy-MM-dd" var="formatdate"/>
					<td><c:choose>
						<c:when test="${data.board.bgnoinsert == 1}">
							<a href="/board/list?bgno=1">자유</a>
						</c:when>
						<c:when test="${data.board.bgnoinsert == 2}">
							<a href="/board/list?bgno=2">미정</a>
						</c:when>
						<c:when test="${data.board.bgnoinsert == 4}">
							<a href="/board/list?bgno=4">공지</a>
						</c:when>
					</c:choose></td>
					<td><a class="move" href="/board/view?bno=<c:out value='${data.board.bno}'/>">
						<c:out value='${data.board.title}'/>
					</a></td>
					<td>${data.board.hit}</td>
					<td>${data.board.likehit}</td>
					<td><c:choose>
						<c:when test="${formatdate eq now}">
							<fmt:formatDate value="${data.board.regdate}" pattern="HH:mm" var="formatnow"/>${formatnow}
						</c:when>
						<c:otherwise>${formatdate}</c:otherwise>
					</c:choose></td>
				</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</table>
	</div><!-- profilebottom -->
	<div class="profilelike pchoice">
		<c:forEach items="${likeInfo}" var="data">
			<c:choose>
				<c:when test="${data.like.LIKENO == null || data.like.LIKENO == ''}">
					추천 내역이 없습니다.
				</c:when>
				<c:otherwise>
			<div class="like_area">
				<fmt:formatDate value="${data.like.LIKEDATE}" pattern="yyyy-MM-dd" var="formatdate"/>
				<c:choose>
					<c:when test="${formatdate eq now}">
						<fmt:formatDate value="${data.like.LIKEDATE}" pattern="HH:mm" var="formatnow"/>${formatnow}<span>에 </span>
					</c:when>
					<c:otherwise>${formatdate}<span>에 </span></c:otherwise>
				</c:choose>
					<c:choose>
						<c:when test="${data.board.bgnoinsert == 1}">
							<a href="/board/list?bgno=1">자유</a>
						</c:when>
						<c:when test="${data.board.bgnoinsert == 2}">
							<a href="/board/list?bgno=2">미정</a>
						</c:when>
					</c:choose><span>게시판의 </span>
				<a class="move" href="/board/view?bno=<c:out value='${data.like.BNO}'/>">
					'<c:out value='${data.board.title}'/>'
				</a><span>글을 추천하였습니다.</span>
			</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	</c:when>
	<c:otherwise>
		존재하지 않는 아이디입니다.
	</c:otherwise>
	</c:choose>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('.profilelike').hide();
	$('.profilebottom').hide();
});
$('#myband').click(function(){
	$('.profilelike').hide();
	$('.profilebottom').hide();
	$('.profileband').show();
});
$('#myboard').click(function(){
	$('.profilelike').hide();
	$('.profileband').hide();
	$('.profilebottom').show();
});
$('#mylike').click(function(){
	$('.profilebottom').hide();
	$('.profileband').hide();
	$('.profilelike').show();
});
</script>
</body>
</html>