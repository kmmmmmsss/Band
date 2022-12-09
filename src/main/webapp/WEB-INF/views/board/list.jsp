<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BANDo</title>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/board.css">
</head>
<body>
<jsp:include page="../header.jsp"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now" />
<div id="board_content">
<div id="board_area">
	<div class='bgnoselect'>
	<div class="board_menu">
		<ul>
			<li><a href="/board/list?bgno=1">자유</a></li>
			<li><a href="/board/list?bgno=0">전체</a></li>
			<li><a href="/board/list?bgno=2">악기</a></li>
		</ul>
	</div></div>
	<div class='listmenu'>
		<c:choose>
			<c:when test="${pagemake.cri.bgno == 0}">
				<h3 class="h3 mb-2 text-gray-800">전체</h3>
			</c:when>
			<c:when test="${pagemake.cri.bgno == 1}">
				<h3 class="h3 mb-2 text-gray-800">자유</h3>
			</c:when>
			<c:when test="${pagemake.cri.bgno == 2}">
				<h3 class="h3 mb-2 text-gray-800">악기</h3>
			</c:when>
		</c:choose>
	</div>
	<c:choose>
		<c:when test="${sessionScope.login.ID ne null}">
			<div style="float:right;"><a class="btn" href="/board/write">작성하기</a></div>
		</c:when>
		<c:otherwise>
			<div style="float:right;"><a class="btn" href="/board/write" onclick="loginStatus(); return false;">작성하기</a></div>
		</c:otherwise>
	</c:choose>
	
	<div class="search_wrap">
		<div class="search_area">
			<select name="type">
				<option value="TC" <c:out value="${pagemake.cri.type eq 'TC'?'selected':''}"/>>제목+내용</option>
				<option value="T" <c:out value="${pagemake.cri.type eq 'T'?'selected':''}"/>>제목</option>
				<option value="C" <c:out value="${pagemake.cri.type eq 'C'?'selected':''}"/>>내용</option>
				<option value="N" <c:out value="${pagemake.cri.type eq 'N'?'selected':''}"/>>별명</option>
			</select>
			<input type="text" name="keyword" placeholder="검색" value="${pagemake.cri.keyword}">
			<button class="btn">검색</button>
		</div>
	</div>
<div><ul>
	<c:forEach items="${list}" var="list">
		<li>
			<div id="board_table"><!-- 댓글 수  -->
				<fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd" var="formatdate"/>
				
				${list.NICK_NAME}　
				
				<c:choose>
					<c:when test="${formatdate eq now}">
						<fmt:formatDate value="${list.regdate}" pattern="HH:mm" var="formatnow"/>${formatnow}
					</c:when>
					<c:otherwise>${formatdate}</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${list.bgnoinsert == 1}">
						<a style="float:right; color:gray;" href="/board/list?bgno=1">자유</a>
					</c:when>
					<c:when test="${list.bgnoinsert == 2}">
						<a style="float:right; color:gray;" href="/board/list?bgno=2">악기</a>
					</c:when>
					<c:when test="${list.bgnoinsert == 4}">
						<a style="float:right; color:gray;" href="/board/list?bgno=4">공지</a>
					</c:when>
				</c:choose><br>
				
				<div class="title">
				<a class="move" href="<c:out value='${list.bno}'/>">
					<c:out value='${list.title}'/>
				</a>
				</div>
				<div>
					<span>❤ <c:out value="${list.likehit}"/>　👀 <c:out value='${list.hit}'/></span>
				</div>
			</div>
		</li>
	</c:forEach>
</ul></div></div>
	
<form id="moveForm" method="get">
	<input type="hidden" name="keyword" value="${pagemake.cri.keyword}">
	<input type="hidden" name="type" value="${pagemake.cri.type}">
	<input type="hidden" name="bgno" value="${pagemake.cri.bgno}">
	<input type="hidden" name="pageNum" value="${pagemake.cri.pageNum}">
	<input type="hidden" name="amount" value="${pagemake.cri.amount}">
</form>
<!-- 페이지 -->
<div class="page_wrap">
	<div class="page_area">
		<ul id="pageInfo" class="pageInfo">
			 <c:if test="${pagemake.prev}">
                    <li class="pageInfo_btn previous"><a href="${pagemake.startPage-1}">Prev</a></li>
                </c:if>
			<c:forEach var="num" begin="${pagemake.startPage}" end="${pagemake.endPage}">
				<li class="pageInfo_btn"><a href="${num}">${num}</a></li>
			</c:forEach>
			<c:if test="${pagemake.next}">
                    <li class="pageInfo_btn next"><a href="${pagemake.endPage + 1 }">Next</a></li>
            </c:if>
		</ul>
	</div>
</div>
</div>
<script>
	var moveForm = $("#moveForm");
	
	$(".move").on("click", function(e){
		e.preventDefault();
		moveForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		moveForm.attr("action", "/board/view");
		moveForm.submit();
	});
	
	$(".pageInfo a").on("click", function(e){
		e.preventDefault();
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		moveForm.attr("action", "/board/list");
		moveForm.submit();
	});
	$(".search_area button").on("click", function(e){
		e.preventDefault();
		var type=$(".search_area select").val();
		var keyword = $(".search_area input[name='keyword']").val();
		
		if(!keyword){
			alert("키워드를 입력하세요.");
			return false;
		}
		
		moveForm.find("input[name='type']").val(type);
		moveForm.find("input[name='keyword']").val(keyword);
		moveForm.find("input[name='pageNum']").val(1);
		moveForm.submit();
	})
	function loginStatus(){
		alert("로그인 후 이용 가능한 서비스입니다.");
	}
</script>
</body>
</html>