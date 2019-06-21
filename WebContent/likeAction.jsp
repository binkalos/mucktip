<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String userid = request.getParameter("userid");
	String postid = request.getParameter("postid");
	
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
		
		pstmt = con.prepareStatement("select * from goodmuck where userid = ? and postid = ?");
		pstmt.setString(1, userid);
		pstmt.setString(2, postid);
		rs = pstmt.executeQuery();

		if(rs.next()) { 
			int goodchk = rs.getInt("good_chk");
			if(goodchk == 1) { //좋아요가 체크되어있음
				pstmt = con.prepareStatement("update goodmuck set good_chk = 0  where userid = ? and postid = ?");
				pstmt.setString(1, userid);
				pstmt.setString(2, postid);
				pstmt.executeUpdate();
			} else {
				pstmt = con.prepareStatement("update goodmuck set good_chk = 1  where userid = ? and postid = ?");
				pstmt.setString(1, userid);
				pstmt.setString(2, postid);
				pstmt.executeUpdate();
			}
		} else { //좋아요를 누른 적이 없음
			pstmt = con.prepareStatement("insert into goodmuck(postid, userid, good_chk) values(?,?,?)");
			pstmt.setString(1, postid);
			pstmt.setString(2, userid);
			pstmt.setInt(3, 1);
			pstmt.executeUpdate();
		}
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