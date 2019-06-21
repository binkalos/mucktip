<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = (String) session.getAttribute("username");
	
	Date date = new Date();
	Long time = date.getTime();
	String dpostid = userid + "_" + time;

	java.util.Date utilDate = new java.util.Date();
	java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

	MultipartRequest multi = null;
	String savePath = request.getSession().getServletContext().getRealPath("post");
	int sizeLimit = 10 * 1024 * 1024;
	multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	
	String title = multi.getParameter("title");
	String content = multi.getParameter("content");
	
 	Enumeration fileNames = multi.getFileNames();

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;

	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/mucktip?serverTimezone=UTC&useSSL=false";
	String id = "root";
	String pw = "alflarhkgkrrh1!";

	try {
		Class.forName(driver);
		con = DriverManager.getConnection(url, id, pw);

		pstmt = con.prepareStatement("insert into post (postid, title, content, writer, date, cheked) values(?, ?, ?, ?, ?, ?)");
		pstmt.setString(1, dpostid);
		pstmt.setString(2, title);
		pstmt.setString(3, content);
		pstmt.setString(4, userid);
		pstmt.setDate(5, sqlDate);
		pstmt.setInt(6, 0);
		pstmt.executeUpdate();

		while (fileNames.hasMoreElements()) {
			String param = (String) fileNames.nextElement();
			String fileName = multi.getFilesystemName(param);

			if (fileName == null) continue;
			
			pstmt = con.prepareStatement("insert into img (postimgid, imgname) values(?, ?)");
			pstmt.setString(1, dpostid);
			pstmt.setString(2, fileName);
			pstmt.executeUpdate();
		}
	} catch (ClassNotFoundException e) {
		out.println(e);
	} finally {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
<meta http-equiv="refresh" content="0; url=firstPage.jsp">