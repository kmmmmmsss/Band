<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<form id="updateForm" action="/match/update" method="post">
	<div class="u_intro borderbt">
		<div><input type="text" name="m_title" value='<c:out value="${mview.m_title}"/>' style="width:100%; height:20px;"></div>
		<input name="m_no" readonly="readonly" type="hidden" value='<c:out value="${mview.m_no}"/>'>
	</div>
	<div class="v_intro borderbt">
		<label>성별</label>
		<select class="genderChk" id="genderChk">
			<option value="" selected>선택해 주세요</option>
			<option value="1">성별 무관</option>
			<option value="2">여성 밴드</option>
			<option value="3">남성 밴드</option>
		</select>
		<input type="hidden" name="m_gender" value="${mview.m_gender}"><br>
		<label>주장르</label>
		<select class="bandChk" id="bandChk">
			<option value="" selected>주장르</option>
			<option value="1">팝</option>
			<option value="2">락</option>
			<option value="3">재즈</option>
			<option value="4">랜선</option>
		</select>
		<input type="hidden" name="m_sort" value="${mview.m_sort}"><br>
		<label>지역</label>
		<input type="text" name="m_loc" value="${mview.m_loc}" placeholder="지역정보를 입력하세요.">
	</div>
	<div class="u_intro">
		<textarea name="m_content" style="width:100%; "><c:out value='${mview.m_content}'/></textarea>
		<div>
			<a class="btn" id="view_list">목록</a>
			<button type="button" class='btn' id="modify_btn">수정 완료</button>
			<a id="modify_back" class="btn">수정 취소</a>
			<a id="delete_btn" class="btn">삭제</a>
		</div>
	</div>
	</form>
	<form id="viewForm" action="/match/update" method="get">
		<input type="hidden" id="m_no" name="m_no" value="<c:out value='${mview.m_no}'/>">
		<input type="hidden" name="keyword" value="${cri.keyword}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
	</form>
</div>
<script>
var form = $("#viewForm");
var mform = $("#updateForm");

$("#view_list").on("click", function(e){
	form.find("#m_no").remove();
	form.attr("action", "/match/search");
	form.submit();
});
$("#modify_btn").on("click", function(e){
	e.preventDefault();
	var rgForm2 = $("form[name='updateForm'] .bandChk").length;
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
	var rgForm = $("form[name='updateForm'] .genderChk").length;
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
	if($("#bandChk").val() == 4){
		$("input[name='m_loc']").attr("value", "지역무관");
	}
	if($("#genderChk").val() == '' || $("#bandChk").val() == ''){
		alert("부가정보를 입력해 주세요.");
		return false;
	}
	$("form[name='updateForm']").attr("action", "/match/search");
	mform.submit();
});
$("#modify_back").on("click", function(e){
	form.attr("action", "/match/mview");
	form.submit();
});
$("#delete_btn").on("click", function(e){
	form.attr("action", "/match/delee");
	form.attr("method", "post");
	form.submit();
});
</script>
</body>
</html>