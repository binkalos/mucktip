<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import = "javasrc.DBUtil" %>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원여부 확인(로그인 체크)</title>
</head>
<body>
	<% 
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("username");
		String pw = request.getParameter("password");
		
		Connection conn = DBUtil.getMySQLConnection();//db연결
		
		String sql = "select * from user where id=? and pw=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,id);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
			out.println("<script>");
			out.println("alert('로그인 되었습니다! 환영합니다~!')");
			session.setAttribute("username", id); // 인증되었음 세션에 남김
			DBUtil.close();
			out.println("location.href='firstPage.jsp'");
			out.println("</script>");
			
		}else{
			out.println("<script>");
			out.println("alert('정보가 틀렸습니다.')");
			out.println("location.href='login.jsp'");
			out.println("</script>");
			DBUtil.close();
		}
	
	%>
</body>
</html>