<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 	request.setCharacterEncoding("UTF-8");
	 String id = request.getParameter("username");
	 String pw =  request.getParameter("password");
	 
	 Connection con = null;
	 PreparedStatement pstmt = null;
	 ResultSet rs = null;
	 String sql = null;
	 
	 try {
		 Class.forName("com.mysql.jdbc.Driver");
		 String DB_URL = "jdbc:mysql://localhost:3306/mucktip?useUnicode=true&characterEncoding=utf8&useSSL=false";
		 
		 con = DriverManager.getConnection(DB_URL,"root","alflarhkgkrrh1!");
		 
		 sql = "SELECT * FROM user WHERE id=?";
		 pstmt = con.prepareStatement(sql);
		 pstmt.setString(1, id);
		 
		 rs = pstmt.executeQuery();
		 
		 if(!rs.next()) { //중복이 없으면
			 sql = "INSERT INTO user(id,pw) VALUES(?,?)";
			 
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1,id);
			 pstmt.setString(2,pw);
			 pstmt.executeUpdate();
			 
			 rs.close();
			 pstmt.close();
			 con.close();
			 
			 out.println("<script>");
			 out.println("alert('회원가입을 성공하셨습니다.');");
			 out.println("location.href='login.jsp';");
		 	 out.println("</script>");
		 } else { //중복이면
			 rs.close();
			 pstmt.close();
			 con.close();
			 
			 out.println("<script>");
			 out.println("alert('중복된 아이디 입니다. 다시 입력해주세요.');");
			 out.println("location.href='join.jsp';");
		 	 out.println("</script>");
		 }
	 }catch(ClassNotFoundException e){
			out.println(e);		 
	 }catch(SQLException e){
		 	out.println(e);
	 }
%>
</body>
</html>