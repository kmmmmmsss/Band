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
<link rel="stylesheet" href="../resources/css/match.css">
</head>
<body>
<jsp:include page="../header.jsp"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now" />

<div class="match_area">
	<div class="search_wrap">
		<div class="search_area">
			<select name="type">
				<option value="TC" <c:out value="${page.cri.type eq 'TC'?'selected':''}"/>>제목+내용</option>
				<option value="T" <c:out value="${page.cri.type eq 'T'?'selected':''}"/>>제목</option>
				<option value="C" <c:out value="${page.cri.type eq 'C'?'selected':''}"/>>내용</option>
			</select>
			<input type="text" name="keyword" placeholder="검색" value="${page.cri.keyword}">
			<button class="btn">검색</button>
		</div>
	</div>
	<c:forEach items="${match}" var="list">
		<div class="match_table">
			<fmt:formatDate value="${list.m_date}" pattern="yyyy-MM-dd" var="formatdate"/>
			<div class="pd_match">${list.m_NICK_NAME} <c:choose>
				<c:when test="${formatdate eq now}">
					<fmt:formatDate value="${list.m_date}" pattern="HH:mm" var="formatnow"/>${formatnow}
				</c:when>
				<c:otherwise>${formatdate}</c:otherwise>
			</c:choose></div>
			<div class="pd_match">
				<a class="move" href="<c:out value='${list.m_no}'/>">
					${list.m_title}
				</a>
			</div>
			<div class="pd_match">
			<c:choose>
				<c:when test="${list.m_gender == 1}">
					<span>#성별무관</span>
				</c:when>
				<c:when test="${list.m_gender == 2}">
					<span>#여성밴드</span>
				</c:when>
				<c:otherwise>
					<span>#남성밴드</span>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${list.m_sort == 1}">
					<span>#팝</span>
				</c:when>
				<c:when test="${list.m_sort == 2}">
					<span>#락</span>
				</c:when>
				<c:when test="${list.m_sort == 3}">
					<span>#재즈</span>
				</c:when>
				<c:when test="${list.m_sort == 4}">
					<span>#랜선</span>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${list.m_sort == 4}">
					<span>#지역무관</span>
				</c:when>
				<c:otherwise>
					<span>#${mview.m_loc}</span>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
	</c:forEach>
	<!-- 페이지 -->
<div class="page_wrap">
	<div class="page_area">
		<ul id="pageInfo" class="pageInfo">
			 <c:if test="${page.prev}">
                    <li class="pageInfo_btn previous"><a href="${page.startPage-1}">Prev</a></li>
                </c:if>
			<c:forEach var="num" begin="${page.startPage}" end="${page.endPage}">
				<li class="pageInfo_btn"><a href="${num}">${num}</a></li>
			</c:forEach>
			<c:if test="${page.next}">
                    <li class="pageInfo_btn next"><a href="${page.endPage + 1 }">Next</a></li>
            </c:if>
		</ul>
	</div>
</div>
</div>
<form id="moveForm" method="get">
	<input type="hidden" name="keyword" value="${page.cri.keyword}">
	<input type="hidden" name="type" value="${page.cri.type}">
	<input type="hidden" name="pageNum" value="${page.cri.pageNum}">
	<input type="hidden" name="amount" value="${page.cri.amount}">
</form>
<script>
	var mf = $("#moveForm");
	$(".move").on("click", function(e){
		e.preventDefault();
		mf.append("<input type='hidden' name='m_no' value='"+$(this).attr("href")+"'>");
		mf.attr("action", "/match/mview");
		mf.submit();
	});
	$(".pageInfo a").on("click", function(e){
		e.preventDefault();
		mf.find("input[name='pageNum']").val($(this).attr("href"));
		mf.attr("action", "/match/search");
		mf.submit();
	});
	$(".search_area button").on("click", function(e){
		e.preventDefault();
		var type=$(".search_area select").val();
		var keyword = $(".search_area input[name='keyword']").val();
		
		if(!keyword){
			alert("키워드를 입력하세요.");
			return false;
		}
		
		mf.find("input[name='type']").val(type);
		mf.find("input[name='keyword']").val(keyword);
		mf.find("input[name='pageNum']").val(1);
		mf.submit();
	});
</script>
</body>
</html>