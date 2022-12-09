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
<div id="mview_wrap">
	<div class="v_intro borderbt"><input type="hidden" name='m_no' value="${mview.m_no}">
		<a href="/user/profile?ID=${mview.m_ID}"><c:out value="${mview.m_NICK_NAME}"/></a>
		<div><c:out value="${mview.m_title}"/></div>
		<input name="m_no" readonly="readonly" type="hidden" value='<c:out value="${mview.m_no}"/>'>
		<fmt:formatDate value="${mview.m_date}" pattern="yyyy-MM-dd" var="formatdate"/>
		<c:choose>
			<c:when test="${formatdate eq now}">
				<fmt:formatDate value="${mview.m_date}" pattern="HH:mm" var="formatnow"/>${formatnow}
			</c:when>
			<c:otherwise>${formatdate}</c:otherwise>
		</c:choose>
	</div>
	<div class="v_intro borderbt">
		<label>성별 : </label><c:choose>
				<c:when test="${mview.m_gender == 1}">
					<span>성별무관</span>
				</c:when>
				<c:when test="${mview.m_gender == 2}">
					<span>여성밴드</span>
				</c:when>
				<c:otherwise>
					<span>남성밴드</span>
				</c:otherwise>
		</c:choose><br>
		<label>주장르 : </label><c:choose>
				<c:when test="${mview.m_sort == 1}">
					<span>팝</span>
				</c:when>
				<c:when test="${mview.m_sort == 2}">
					<span>락</span>
				</c:when>
				<c:when test="${mview.m_sort == 3}">
					<span>재즈</span>
				</c:when>
				<c:when test="${mview.m_sort == 4}">
					<span>랜선</span>
				</c:when>
		</c:choose><br>
		<label>지역 : </label><c:choose>
			<c:when test="${mview.m_sort == 4}">
				<span>지역무관</span>
			</c:when>
			<c:otherwise>
				<span>${mview.m_loc}</span>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="v_intro">
		<div>
			<PRE><c:out value='${mview.m_content}'/></PRE>
		</div>
		<a style="float:right;" class="btn" id="view_list">목록</a>
		<a style="float:right;" class="btn" id="modify_btn">수정</a>
	</div>
	<div id="comment_wrap">
		<!-- 댓글 입력창 -->
		<div class="reply_area">
			<input type="hidden" name="m_no" value="${mview.m_no}">
			<input type="hidden" name="rid" value="${sessionScope.login.ID}">
			<input type="hidden" name="nick" value="${sessionScope.login.NICK_NAME}">
			<div style="padding:0px 4px;">댓글</div>
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
	<form id="viewForm" action="/match/update" method="get">
		<input type="hidden" id="m_no" name="m_no" value="<c:out value='${mview.m_no}'/>">
		<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
		<input type="hidden" id="type" name="type" value="${cri.type}">
		<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" id="amount" name="amount" value="${cri.amount}">
	</form>
</div>
<script>
	var form = $("#viewForm");
	
	$("#view_list").on("click", function(e){
		form.find("#m_no").remove();
		form.attr("action", "/match/search");
		form.submit();
	});
	$("#modify_btn").on("click", function(e){
		form.attr("action", "/match/update");
		form.submit();
	});
$(document).ready(function(){
	var mnoval=$("input[name='m_no']").val();
	list(mnoval);
	
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
		add({'m_no':mnoval,'content':cmt,'id':id,'nick':nick});
	})
})
function add(data){
	console.log(data);
	$.ajax({
		type:"post",
		url:"/comment/newest",
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
var mno = ${mview.m_no};
function list(data){
	$.getJSON("/comment/list/"+mno+".json", function(data){
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
				str+="			<a class='upbtn' href='/comment/mupdate?m_no="+data[i].m_no+"&rno="+data[i].rno+"&keyword="+kw+"&type="+ty+"&pageNum="+pn+"&amount="+am+"'>수정</a>";
				str+="		</div>";
			}
			str+="	</div>";
			str+="</li>";
		}
		$("#commentList").html(str);
	})
}
//년+월+일 리턴
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
</body>
</html>