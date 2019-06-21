<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>먹팁</title>
<link rel="stylesheet" href="../style.css" >
<script src="../js/jquery-3.3.1.min.js"></script>
</head>
<body>
<!-- 시작 페이지는 구현되지 않은 상태임 -->
	<%@ include file="../include/topMenu.jsp" %>
	<%@ include file="../include/login.jsp" %>
	<div class="content">
		<form name="sortForm" action="#" >
			자유게시판
			
			<select name="sort" style="margin-left: 10px;">
				<option value="new" selected>최신순</option>
				<option value="look">조회순</option>
				<option value="like">추천순</option>
			</select> 
			<input type="submit" value="조회">
			
			<table width="100%" height="80%" cellspacing="0" cellpadding="6" style="padding:0px 22px 10px 10px;">
			<tr>
				<td valign="top" width="80%">
				<table id="newtable" align="center" width="100%" cellspacing="0" cellpadding="6" style="border: 1px solid black;">
					<thead>
					<tr>
						<td align="center" width="8%">번호</td>
						<td align="center" width="45%">제목</td>
						<td align="center" width="14%">작성자</td>
						<td align="center" width="7%">날짜</td>
						<td align="center" width="5%">조회</td>
						<td align="center" width="5%">댓글</td>
						<td align="center" width="5%">추천</td>
					</tr>
					</thead>
					<tbody>
						<tr>
							<td>0</td>
							<td>제목없음</td>
							<td>미상</td>
							<td>00/00/00</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
						</tr>
					</tbody>
				</table>
				</td>
				<td></td>
					
				<td rowspan="3" align="right" valign="top" width="260px">
					<%@ include file="../include/right_menu.jsp" %>
				</td>
			</tr>
			
			<tr>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
			</tr>		
			</table>
		</form>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>