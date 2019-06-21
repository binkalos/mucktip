<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String comment = request.getParameter("comment");
	String userid = request.getParameter("userid");
	String postid = request.getParameter("postid");
	
	java.util.Date utilDate = new java.util.Date();
	java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/mucktip?serverTimezone=UTC&useSSL=false";
	String id = "root";
	String pw = "alflarhkgkrrh1!";
	
	try {
		Class.forName(driver);
		con = DriverManager.getConnection(url, id, pw);
		
		pstmt = con.prepareStatement("insert into comments(comment, date, userid, postid) values(?,?,?,?)");
		pstmt.setString(1, comment);
		pstmt.setDate(2, sqlDate);
		pstmt.setString(3, userid);
		pstmt.setString(4, postid);
		pstmt.executeUpdate();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
<meta http-equiv="refresh" content="0; url=fullView.jsp?postid=<%=postid%>">