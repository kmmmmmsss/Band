<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
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
<div><jsp:include page="../header.jsp"/></div>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now"/>
<div id="board_content">
	<!-- 댓글 -->
	<div id="comment_wrap">
		<!-- 댓글 입력창 -->
		<form method="post" name="insert" action="/comment/cmtupdate">
		<div class="reply_area">
			<input type="hidden" name="bno" value="${comment.bno}">
			<input type="hidden" name="rno" value="${comment.rno}">
			<input type="hidden" name="id" value="${comment.id}">
			<input type="hidden" name="nick" value="${comment.nick}">
			<div style="padding:0px 4px;">댓글 수정</div>
			<div>
				<textarea class="RCONTENT" name="content">${comment.content}</textarea>
			</div>
			<div style='text-align:right;'>
				<a class='cmt_md btn'>수정 완료</a>
				<a class='btn' id="cmt_back">수정 취소</a>
				<a class='btn' id="cmtdeleteBtn">삭제</a>
			</div>
		</div>
		<input type="hidden" name="keyword" value="${cri.keyword}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${comment.bno}"/>'>
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
		<input type="hidden" name="bgno" value='<c:out value="${cri.bgno}"/>'>
		</form>
	</div>
</div>
	<form id="viewForm" action="/comment/cmtupdate" method="get">
		<input type="hidden" name="keyword" value="${cri.keyword}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${comment.bno}"/>'>
		<input type="hidden" name="rno" value='<c:out value="${comment.rno}"/>'>
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
		<input type="hidden" name="bgno" value='<c:out value="${cri.bgno}"/>'>
	</form>
<script>
var viewto = $("#viewForm");
var viewmodify = $("form[name='insert']");

$("#cmt_back").on("click", function(e){
	viewto.attr("action","/board/view");
	viewto.submit();
})
var rno = $("input[name='rno']").val();
$("#cmtdeleteBtn").on("click", function(){
	var result=confirm("삭제 후엔 복구할 수 없습니다. 정말 삭제하시겠습니까?");
	if(result){
		viewto.attr("action", "/comment/remove/"+rno);
		viewto.attr("method", "post");
		viewto.submit();
	}
})
$(".cmt_md").on('click', function(e){
	var cmt = $(".RCONTENT").val();
	if(cmt == ''){
		alert("내용을 입력하세요.")
		return;
	}
	viewmodify.attr("action", "/comment/cmtupdate");
	viewmodify.attr("method", "post");
	viewmodify.submit();
})
</script>
<%-- <jsp:include page="../footer.jsp"/> --%>
</body>
</html>