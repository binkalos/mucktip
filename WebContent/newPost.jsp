<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최신</title><link rel="stylesheet" href="firstPageStyle.css" >
<script src="js/jquery-3.3.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="js/jquery.fittext.js"></script>
<script src="http://code.jquery.com/jquery-1.7.js"></script>
<script>
	$(document).ready(function(){		
		//$(".content" ).fitText(1.2);
		$(".open-fullview").click(function() {
			var foodsrc = $(this).find('.showimg').attr('src');
			$("#dim-layer").find('.content').attr('src', foodsrc);
			$("#dim-layer").css("display", "block");
		});
		
		$(".close-fullview").click(function() {
			$("#dim-layer").css("display", "none");
		});
	});

	function show_fullview(post_id) {
		location.href = "readpost.jsp?postid="+post_id;
	}
	//무한 스크롤	
	$(window).on("scroll", function() {
		var scrollHeight = $(document).height();
		var scrollPosition = $(window).height() + $(window).scrollTop();
		
		if (scrollPosition > scrollHeight - 10) {  //밑에서 10px안에 들어갔을때 액션
			//todo
			setTimeout(function() { //3초 뒤 실행
				$("body").append('<div id="content"></div>');
			},1000);
		}
	});
</script>
</head>
<body>
	<%@ include file="TopWrapper.jsp"%>
	
	<div class="main-search-page">
	
	<div class="muktip-feed">
<%
		String imgPath = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pw);

%>
		
		<div class="top-bar-search">
			<p class="top-label">최신먹팁</p>
		</div>
		
		<div class="muktip-contents" style="height: 1550px;"> 	
			<div class="line-space"></div>
<%	
			pstmt = con.prepareStatement("select distinct postid, postimgid, title, content, writer, date, imgname, id, profile from post join img on postid = postimgid join user on writer = id group by postid order by date desc");
			rs = pstmt.executeQuery();
		
			int count=0;
			while(rs.next()) {
				imgPath =request.getContextPath() + "/post/" + rs.getString("imgname"); 
				count++;
%>
			<div class="mucktip-card"> <!-- 각 게시글 박스 -->
				<button class="open-fullview">
					<a href="fullView.jsp?postid=<%=rs.getString("postid")%>">
						<img class="showimg" src="<%=imgPath%>">
					</a>
				</button>
				<div class="mucktip-information">
					<a class="writer-profile-link" href="Mypage.jsp?id=<%= rs.getString("id") %>"> <!-- 마이페이지 이동 -->
						<img class="writer-profile" src="img/<%=rs.getString("profile") %>" width="30px" height="30px">
					</a>
					<div class="user-information-card">
						<div class="top-information">
							<p class="writer"><%= rs.getString("writer") %></p>
							<p class="write-date"><%= rs.getString("date") %></p>
						</div>
						<div class="bottom-card">
							<p class="title"><%= rs.getString("title") %></p>
							<p class="content"><%= rs.getString("content") %></p>
						</div>
					</div>
				</div> <!-- mucktip-information -->
			</div><!-- mucktip-card  -->
			
<%		
			if(count%4==0) {
%>
				<div class="line-space"></div>
<%			}
		}
		
	} catch (Exception e) {
		e.printStackTrace();
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
		</div> <!-- muktip-contents -->	
		</div><!-- muktip-feed -->
	</div> <!-- main-search-page  -->


<%@ include file="footer.jsp" %>
</body>
</html>