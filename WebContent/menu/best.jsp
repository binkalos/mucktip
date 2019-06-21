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
	<%@ include file="../include/topMenu.jsp" %>
	<%@ include file="../include/login.jsp" %>
	<div class="content">
		베스트
		<table width="100%" height="80%" cellspacing="0" cellpadding="6" style="padding:0px 22px 10px 10px;">
		<tr>
			<td valign="top" width="80%">
			<table id="besttable" align="center" width="100%" cellspacing="0" cellpadding="6" style="border: 1px solid black;">
			<thead>
				<tr>
					<td align="center" width="8%">순위</td>
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
	</div>
	
	<%@ include file="../include/footer.jsp" %>
		
		
		
		
</body>
</html>