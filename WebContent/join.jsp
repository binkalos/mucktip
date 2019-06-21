<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="joinStyle.css" >
<script src="js/jquery-3.3.1.min.js"></script>
<script>
	function checkedUser() {
		var form = document.form;
		if(!form.username.value) {
			alert("아이디를 입력해주세요.");
			form.username.focus();
			return;
		}
		for(var i = 0; i<form.username.value.length;i++){
			ch = form.username.value.charAt(i);
			if(!(ch >= '0' && ch<='9')&&!(ch>='a' && ch<='z')&&!(ch>='A'&&ch<='Z')){
				alert("아이디는 영문 대소문자,숫자만 입력가능합니다.");
				form.username.focus();
				form.username.select();
				return;
			}
		}
		if(form.username.value.indexOf(" ")>=0){
			alert("아이디에는 공백을 사용 할 수 없습니다.");
			form.username.focus();
			form.username.select();
			return;
		}
		if(!form.password.value) {
			alert("비밀번호를 입력해주세요.");
			form.password.focus();
			return;
		}
		if(!form.pwConfirm.value) {
			alert("비밀번호확인란을 입력해주세요.");
			form.pwConfirm.focus();
			return;
		}
		if(form.password.value.length<6) {
			alert("비밀번호를 6자 이상 입력해주세요.");
			form.pwConfirm.focus();
			return;
		}
		if(!(form.password.value == form.pwConfirm.value)) {
			alert("입력하신 비밀번호가 일치하지 않습니다.\n다시 확인하시고 넣어주십시오!");
			form.pwConfirm.focus();
			form.pwConfirm.select();
			return;
		}
		form.submit();
	}
	
	function enterkey() {
		if(window.event.keyCode == 13) { //엔터키가 눌렸을 때 실행
			form.submit();
		}
	}
</script>
</head>
<body>
	<section class="login-page">
		<div class="page-background"> <!-- 배경사진 -->
			<div class="background-blur"></div>
		</div><!-- page-background -->
		
		<div class="field-box-wrapper">
			<div class="field-box">
				<header class="field-box-header">
					<figure class="logo">
						<img src="img/imoticon.png" width="100px" height="100px">
					</figure> 
					<p class="field-box-name">회원가입</p>
				</header><!-- field-box-header -->

			<div class="mainbox">
				<div class="mucktip-account">
					<form class="op-login" name="form" action="joinProc.jsp" method="post" onsubmit = "return checkedUser(this)">
						<input type="hidden" name="return_url" value="firstPage.jsp"> <!-- 폼이 전송될 때 돌려줘야하는 값 -->
						
						<ul class="fieldset">
				
							<li class="field">
								<label class="input-group" for="username">
									<p class="invalid-message"></p>
									<div class="input-wrapper">
										<input class="input" id="username" name="username" 
										placeholder="ID입력" value type="text" tabindex="1">
									</div><!-- input-wrapper -->
								</label>
								
							</li>
							
							<li class="field">
								<label class="input-group" for="password">
									<p class="invaild-message"></p>
									<div class="input-wrapper">
									<input class="input" id="password" name="password"
									placeholder="비밀번호(최소 6자)" value type="password" tabindex="1">
									</div><!-- input-wrapper -->
								</label>
								
								<label class="input-group" for="password">
									<div class="input-wrapper">
									<input class="input" id="pwConfirm" name="pwConfirm"
									placeholder="비밀번호 확인" value type="password" tabindex="1" onkeyup="enterkey();">
									</div><!-- input-wrapper -->
								</label>	
								
								
							</li>
								
							<li class="field">
								<button class="submit-btn" tabindex="1" type="button" onclick="checkedUser()">가입</button>
							</li>

						</ul>
					</form>
				</div><!-- mucktip-account -->
				
				<div class="side-services">
					<div class="side-services-wrapper">
						<div class="need-an-id">이미 계정이 있나요?</div>
						<button class="new-login">
							<a class="login" href="login.jsp">여기서 로그인!</a>
						</button>
					</div>
				</div><!-- field-box-wrapper -->
				
			</div> <!-- mainbox -->
			
			</div><!-- field-box -->
		</div><!-- field-box-wrapper -->
	</section><!-- login-page -->
</body>
</html>