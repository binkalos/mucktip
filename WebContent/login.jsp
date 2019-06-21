<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="loginStyle.css" >
<script src="js/jquery-3.3.1.min.js"></script>
<script>
	function checkedUser() {
		var form = document.form;
		if(!form.username.value) {
			alert("아이디를 입력해주세요.");
			form.username.focus();
			return;
		}
		if(!form.password.value) {
			alert("비밀번호를 입력해주세요.");
			form.password.focus();
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
					<p class="field-box-name">로그인</p>
				</header><!-- field-box-header -->

			<div class="mainbox">
				<div class="mucktip-account">
					<form class="op-login" action="loginchecked.jsp" method="post" name="form">
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
								<a class="forgot-link" href="#">ID가 기억나지 않으세요?</a>
							</li>
							
							<li class="field">
								<label class="input-group" for="password">
									<p class="invaild-message"></p>
									<div class="input-wrapper">
									<input class="input" id="password" name="password"
									placeholder="비밀번호를 입력해 주세요" value type="password" tabindex="1" onkeyup="enterkey();">
									</div><!-- input-wrapper -->
								</label>
								<a class="forgot-link" href="#">비밀번호를 잊으셨나요?</a>
							</li>
							
							<li class="field">
								<button class="submit-btn" tabindex="1" type="button" onclick="checkedUser()">로그인</button>
							</li>

						</ul>
					</form>
				</div><!-- mucktip-account -->
				
				<div class="side-services">
					<div class="side-services-wrapper">
						<div class="need-an-id">ID가 없으신가요?</div>
						<button class="new-login">
							<a class="join" href="join.jsp">여기서 가입!</a>
						</button>
					</div>
				</div><!-- field-box-wrapper -->
				
			</div> <!-- mainbox -->
			
			</div><!-- field-box -->
		</div><!-- field-box-wrapper -->
	</section><!-- login-page -->
</body>
</html>