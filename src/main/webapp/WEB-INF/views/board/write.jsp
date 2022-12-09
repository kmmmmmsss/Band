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
	<form method="post" id="writeForm" name="writeForm">
		<input type="hidden" name="ID" value="${sessionScope.login.ID}">
		<input type="hidden" name="NICK_NAME" value="${sessionScope.login.NICK_NAME}">
		<input type="hidden" name="bgno" value="${cri.bgno}">
		<input type="hidden" name="bgnoinsert" value="${bgno}">
		<div id="modi_title">
			<div class="select"><select class="bgno_chk" id="bgnoinsert"  title="게시판을 선택하세요">
				<option value="" selected>게시판을 선택해 주세요</option>
				<option value="1">자유</option>
				<option value="2">악기</option>
				<c:if test="${sessionScope.login.ID == 'admin'}">
					<option value="4">공지사항</option>
				</c:if>
			</select></div>
			<input type="text" name="title" placeholder="제목을 입력하세요." style="width:100%; height:20px;">
		</div>
		<div id="modi_content">
			<textarea placeholder="내용을 입력하세요." name="content"></textarea>
		</div>
		<button type="button" class="btn select" style="float:right;" onclick="write_valchk();">등록</button>
	</form>
</div>
<script type="text/javascript">
	function write_valchk(){
		var wrForm = $("form[name='writeForm'] .bgno_chk").length;
		for(var i=0;i<wrForm;i++){
			if($("#bgnoinsert").eq(i).val() == "" || $("#bgnoinsert").eq(i).val() == null){
				alert($(".bgno_chk").eq(i).attr("title"));
				return true;
			} 
		}
		if($("#bgnoinsert").val() != "" || $("#bgnoinsert").val() != null){
			console.log($("#bgnoinsert").val());
			$("input[name='bgno']").attr("value", $("#bgnoinsert").val());
			$("input[name='bgnoinsert']").attr("value", $("#bgnoinsert").val());
		}
		if($("input[name='title']").val().trim() == ''){
			alert("제목을 입력하세요.");
			$("input[name='title']").val('');
			$("input[name='title']").focus();
			return false;
		}
		if($("textarea[name='content']").val().trim() == ''){
			alert('내용을 입력하세요');
			$("textarea[name='content']").val('');
			$("textarea[name='content']").focus();
			return false;
		}
		$("form[name='writeForm']").attr("action", "/board/write");
		$("form[name='writeForm']").submit();
	}
</script>
</body>
</html>