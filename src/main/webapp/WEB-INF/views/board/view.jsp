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
<jsp:include page="../header.jsp"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now"/>
<div id="board_content">
	<c:choose>
		<c:when test="${not empty viewing}">
	<div id="modi_title">
		<input name="title" readonly="readonly" type="hidden" value='<c:out value="${viewing.title}"/>'>
		<div class="title"><c:out value="${viewing.title}"/></div><input type="hidden" name="ID" value='<c:out value="${viewing.ID}"/>'>
		<a href="/user/profile?ID=${viewing.ID}"><c:out value="${viewing.NICK_NAME}"/></a>　
		<input name="bno" readonly="readonly" type="hidden" value='<c:out value="${viewing.bno}"/>'><input name="bgnoinsert" readonly="readonly" type="hidden" value='<c:out value="${viewing.bgnoinsert}"/>'>
		👀 <c:out value="${viewing.hit}"/>　
		<fmt:formatDate value="${viewing.regdate}" pattern="yyyy-MM-dd" var="formatdate"/>
			<c:choose>
				<c:when test="${formatdate eq now}">
					<fmt:formatDate value="${viewing.regdate}" pattern="HH:mm" var="formatnow"/>${formatnow}
				</c:when>
				<c:otherwise>${formatdate}</c:otherwise>
			</c:choose>
	</div>
	<div style="padding:20px; border-bottom:1px solid gray;">
		<c:if test="${sessionScope.login.ID == viewing.ID}">
			<span style="float:right;"><a class="btn" id="view_modify">수정</a></span>
		</c:if>
		<pre><c:out value='${viewing.content}'/></pre>
	</div>
	<div>
		<div style="padding:20px; float:right;">
			<!-- 댓글 수 -->
			<a class="btn" id="view_list">목록</a>
		</div>
		<div id="like_area" style="padding:20px; float:right;">
			<c:choose>
				<c:when test="${sessionScope.login.ID ne null}">
					<span class="like_btn" onclick="updateLike(); return false;">
						❤ ${viewing.likehit}
					</span>
				</c:when>
				<c:otherwise>
					<span class="like_btn" onclick="login(); return false;">
						❤ ${viewing.likehit}
					</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div><br>
	<!-- 댓글 -->
	<c:choose>
		<c:when test="${viewing.bgnoinsert != 4}">
	<div id="comment_wrap">
		<!-- 댓글 입력창 -->
		<div class="reply_area">
			<input type="hidden" name="bno" value="${viewing.bno}">
			<input type="hidden" name="rid" value="${sessionScope.login.ID}">
			<input type="hidden" name="nick" value="${sessionScope.login.NICK_NAME}">
			<div style="padding:0px 4px;">댓글
				<c:if test="${viewing.cmthit ne 0}">
					${viewing.cmthit}개
				</c:if>
			</div>
			<div>
				<pre><textarea class="rcontent" name="content"></textarea></pre>
			</div>
			<div>
				<button type="button" class="btn" name="regist" id="regist">댓글 등록</button>
			</div>
		</div>
		<!-- 댓글창 -->
		<div id="comment_area">
			<ul id="commentList">
				
			</ul>
		</div>
		</div>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	</div>
	
		</c:when>
		<c:otherwise>
			삭제된 게시글입니다.
		</c:otherwise>
	</c:choose>
	<form id="viewForm" action="/board/modify" method="get">
		<input type="hidden" id='keyword' name="keyword" value="${cri.keyword}">
		<input type="hidden" id='type' name="type" value="${cri.type}">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${viewing.bno}"/>'>
		<input type="hidden" id='pageNum' name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
		<input type="hidden" id='amount' name="amount" value='<c:out value="${cri.amount}"/>'>
		<input type="hidden" id='bgno' name="bgno" id="bgno" value='<c:out value="${cri.bgno}"/>'>
	</form>
</div>
<script>
var viewto = $("#viewForm");
$("#view_list").on("click", function(e){
	viewto.find("#bno").remove();
	viewto.attr("action","/board/list");
	viewto.submit();
});
$("#view_modify").on("click", function(e){
	viewto.attr("action", "/board/modify");
	viewto.submit();
});
var bno = ${viewing.bno};
var ID = '${sessionScope.login.ID}';
var NICK_NAME = '${viewing.NICK_NAME}';

function updateLike(){
	$.ajax({
		type:"POST",
		url:"/board/updateLike",
		dataType:"json",
		data:{'bno':bno, 'ID':ID, 'NICK_NAME':NICK_NAME},
		error:function(){
			alert("통신 에러");
		},
		success:function(likeCheck){
			//var like_img = '';
			if(likeCheck == 0){
				alert("추천 완료");
				//like_img = "../resources/image/heart.png";
			}else if(likeCheck == 1){
				alert("추천 취소");
				//like_img = "../resources/image/heartfull.png";
			}
			$("#like_area").load(location.href+" #like_area>*","");
			//$('#like_img').attr('src', like_img);
		}
	});
}
function login(){
	alert("로그인 후 이용 가능한 서비스입니다.");
}
$(document).ready(function(){
	var bnoval=$("input[name='bno']").val();
	
	list(bnoval);
	
	$("#regist").on("click", function(){
		var cmt = $(".rcontent").val();
		var id = $("input[name='rid']").val();
		var nick = $("input[name='nick']").val();
		if(id == null || id == ''){
			alert("로그인 후 이용 가능한 서비스입니다.");
			return;
		}
		if(cmt == ''){
			alert("내용을 입력하세요.")
			return;
		}
		add({'bno':bnoval,'content':cmt,'id':id,'nick':nick});
	})
})
function add(data){
	console.log(data);
	$.ajax({
		type:"post",
		url:"/comment/new",
		data:JSON.stringify(data),
		contentType:"application/json; charset=utf-8",
		success:function(result){
			if(result=="success"){
				location.reload();
			}
		}
	})
}
var kw = $('#keyword').val();
var ty = $('#type').val();
var bg = $('#bgno').val();
var pn = $('#pageNum').val();
var am = $('#amount').val();

function list(bno){
	$.getJSON("/comment/"+bno+".json", function(data){
		var str = "";
		for(var i = 0; i < data.length; i++){
			var date = new Date(data[i].regdate); // db저장된 시간
			var today = new Date(); // 현재 시간
			str+="<li>";
			str+="	<div class='cmt-area'>";
			str+="		<div>";
			str+="			<div><a href='/user/profile?ID="+data[i].id+"'>"+data[i].nick+"</a>　";
			if(dateYMD(today) == dateYMD(date)){
				str+=dateHM(date);	
			}else{
				str+=dateYMD(date);
			}
			str+="			</div>";
			str+="			<div class='cmt_cts'>"+data[i].content+"</div>";
			str+="		</div>";
			if($("input[name='rid']").val() == data[i].id){
				str+="		<div class='upbtn_div'>";
				str+="			<a class='upbtn' href='/comment/cmtupdate?bno="+data[i].bno+"&rno="+data[i].rno+"&keyword="+kw+"&type="+ty+"&bgno="+bg+"&pageNum="+pn+"&amount="+am+"'>수정</a>";
				str+="		</div>";
			}
			str+="	</div>";
			str+="</li>";
		}
		$("#commentList").html(str);
	})
}
// 년+월+일 리턴
function dateYMD(date){
	var month = date.getMonth() + 1;
    var day = date.getDate();
    var hour = date.getHours();
    var minute = date.getMinutes();
    var second = date.getSeconds();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;
    second = second >= 10 ? second : '0' + second;
    return date.getFullYear() + '-' + month + '-' + day;
}
// 시+분 리턴
function dateHM(date){
	var month = date.getMonth() + 1;
    var day = date.getDate();
    var hour = date.getHours();
    var minute = date.getMinutes();
    var second = date.getSeconds();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;
    second = second >= 10 ? second : '0' + second;
    return hour + ':' + minute;
}
</script>
<%-- <jsp:include page="../footer.jsp"/> --%>
</body>
</html>