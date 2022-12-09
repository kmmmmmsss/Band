/**
 * 
 */
$(document).ready(function(){
	/* 회원가입 유효성 검사 */


	/* 로그인(아이디, 비밀번호) 유효성 검사 */
	$("#loginbtn").on("click", function(){
		var uid=$("input[name='ID']");
		var pwd=$("input[name='PASSWORD']");
		
		if(uid == '' || uid == null){
			alert("아이디를 다시 확인해 주세요.");
			uid.focus();
		}
		if(pwd == '' || pwd == null){
			alert("비밀번호 정보가")
		}
		
	})
	
	
	/* 내 정보(비밀번호) 유효성 검사 */
	
	
})