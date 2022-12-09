<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div id="board_content">
	<form id="modifyForm" action="/board/modify" method="post">
	<div id="modi_title">
		<input name="title" style="width:100%; height:20px;" value='<c:out value="${viewing.title}"/>'>
		<input name="bno" readonly="readonly" type="hidden" value='<c:out value="${viewing.bno}"/>'>
	</div>
	<div id="modi_content">
		<textarea name="content"><c:out value='${viewing.content}'/></textarea>
	</div>
	<c:if test="${sessionScope.login.ID == viewing.ID}">
		<div style="padding:20px; float:right;">
			<a id="view_list" class="btn" onclick="needLogin();">목록</a>
			<a id="view_modify" class="btn">수정 완료</a>
			<a id="view_back" class="btn">수정 취소</a>
			<a id="delete_btn" class="btn">삭제</a>
		</div>
	</c:if>
	</form>
</div>
	<form id="viewForm" action="/board/modify" method="get">
		<input type="hidden" name="keyword" value="${cri.keyword}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${viewing.bno}"/>'>
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
		<input type="hidden" name="bgno" value='<c:out value="${cri.bgno}"/>'>
	</form>
<script>
	var viewto = $("#viewForm"); // 페이지 이동
	var viewmodify = $("#modifyForm"); // 페이지 데이터 수정
	var bgno = $("input[name='bgno']");
	
	$("#view_list").on("click", function(e){
		viewto.find("#bno").remove();
		viewto.attr("action","/board/list");
		viewto.submit();
	});
	$("#view_modify").on("click", function(e){
		viewmodify.submit();
	});
	$("#view_back").on("click", function(e){
		viewto.attr("action","/board/view");
		viewto.submit();
	})
	$("#delete_btn").on("click", function(e){
		viewto.attr("action", "/board/delete");
		viewto.attr("method", "post");
		viewto.submit();
	})
</script>
</body>
</html>