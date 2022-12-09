<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div id="mview_wrap">
<form method="post" id="registForm" name="registForm">
	<div class="u_intro borderbt">
		<input type="text" style="width:100%;" name="m_title" placeholder="제목을 입력하세요.">
		<input type="hidden" name="m_ID" value="${sessionScope.login.ID}">
		<input type="hidden" name="m_NICK_NAME" value="${sessionScope.login.NICK_NAME}">
	</div>
	<div class="v_intro borderbt">
		<div>
			<label>성별</label>
			<select class="genderChk" id="genderChk">
				<option value="" selected>선택해 주세요</option>
				<option value="1">성별 무관</option>
				<option value="2">여성 밴드</option>
				<option value="3">남성 밴드</option>
			</select>
			<input type="hidden" name="m_gender">
		</div>
		<div>
			<label>주장르</label>
			<select class="bandChk" id="bandChk">
				<option value="" selected>주장르</option>
				<option value="1">팝</option>
				<option value="2">락</option>
				<option value="3">재즈</option>
				<option value="4">랜선</option>
			</select>
			<input type="hidden" name="m_sort">
		</div>
		<div>
			<label>지역</label>
			<input type="text" name="m_loc" placeholder="지역정보를 입력하세요.">
		</div>
	</div>
	<div class="u_intro">
		<textarea placeholder="소개를 입력하세요." name="m_content"></textarea>
	</div>
	<button type="button" class='btn' id='right' onclick="registChk();">작성</button>
</form>
</div>
<script>
	function registChk(){
		var rgForm2 = $("form[name='registForm'] .bandChk").length;
		for(var i=0;i<rgForm;i++){
			if($("#bandChk").eq(i).val() == "" || $("#bandChk").eq(i).val() == null){
				alert($(".bandChk").eq(i).attr("title"));
				return true;
			}
		}
		if($("#bandChk").val() != "" || $("#bandChk").val() != null){
			console.log($("#bandChk").val());
			$("input[name='m_sort']").attr("value", $("#bandChk").val());
		}
		var rgForm = $("form[name='registForm'] .genderChk").length;
		for(var i=0;i<rgForm;i++){
			if($("#genderChk").eq(i).val() == "" || $("#genderChk").eq(i).val() == null){
				alert($(".genderChk").eq(i).attr("title"));
				return true;
			}
		}
		if($("#genderChk").val() != "" || $("#genderChk").val() != null){
			console.log($("#genderChk").val());
			$("input[name='m_gender']").attr("value", $("#genderChk").val());
		}
		$("form[name='registForm']").attr("action", "/match/regist");
		$("form[name='registForm']").submit();
	}
</script>
</body>
</html>