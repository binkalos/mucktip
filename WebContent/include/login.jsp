<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table width="100%" align="right" cellpadding="10" cellspacing="0">
<tr>
<td width="33%"></td>
	<td>
	<form name="search" action="#">
	<div align="center" style="margin: 10px">
		<table cellspacing="0" cellpadding="3">
			<tr>
				<td>
					<span class="search"> 
						<input type="text" class="input_text">
					</span>
				</td>
				<td><button type="submit" class="sch_smit">검색</button></td>
			</tr>
		</table>
	</div>
	</form>
	</td>

	<td width="33%">
	<form method="post" name="login" action="#">
		<table class="login">
			<tr>
				<td><input type="text" name="id" placeholder="아이디"></td>
				<td rowspan="2"><input type="submit" value="로그인" class="login_button"></td>
			</tr>
			<tr>
				<td><input type="password" name="pw" placeholder="비밀번호"></td>
			</tr>
			<tr>
				<td><a href="#">아이디</a>/<a href="#">비밀번호 찾기</a></td>
				<td><a href="#">회원가입</a></td>
			</tr>
		</table>
	</form>
	</td>
</tr>
</table>