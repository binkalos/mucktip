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
<title>먹팁</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="firstPageStyle.css" >
<script src="js/jquery-3.3.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="js/jquery.fittext.js"></script>
<script src="http://code.jquery.com/jquery-1.7.js"></script>
<script>
	$(document).ready(function(){		
		
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
	
	<section class="main-page">
		<!-- 업로드 할 수 있는 아이콘 삽입하기  -->
		<% if(userid != null) { %>
		<div class="upload">
			<a href="Postboard.jsp">
				<img src="img/upimg.png" width="80px" height="80px;">
			</a>
		</div><!-- upload -->
		<% } %>
		<div class="up">
			<a href="#top">
				<img src="img/upbtn.png" width="40px" height="40px;">
			</a>
		</div>
		<div class="top-tip-fid">		
			 <div class="top-tip-in">	 
		<%   	
			String imgPath = null;
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, id, pw);
		
				pstmt = con.prepareStatement("select * from hotfid");
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
		%>
			 	<!-- 첫번째 hot-tip -->
				<div class="hot-tip" style="background-image:url('img/<%=rs.getString("img") %>');background-size:cover;" id="top">
		<%		} %>
				<a class="hot" href="Hotfid.jsp" target="_blank">
				<div class="hottip-inner-wrapper" >
				
				<div class="collection-information">
					<div class="collection-title-wrapper">
						<div class="collection-title-border">
						<p class="collection-title" style="overflow-wrap:break-word;">
							"<6월의 인기 음식>"<br>"BEST 유행 음식"</p>
						</div><!-- collection-title-border -->
					</div><!-- collection-title-wrapper -->
					
						<p class="collection-description-wrapper" style="overflow-wrap:break-word;">
							"핵인싸가 되고 싶다면..."<br>
						</p>
					</div><!-- collection-information -->
				
				</div><!-- hottip-inner-wrapper -->
			    </a><!-- hot -->
			  	</div><!-- hot-tip -->
		 <%
				pstmt = con.prepareStatement("select * from nexttip");
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
		 %>
				<!-- 두번째 hot-tip --> 
				<div class="hot-tip-second" style="background-image:url('img/<%=rs.getString("img") %>');background-size:cover;">
		<%		} %>		
				<a class="hot2" href="nextTip.jsp" target="_blank">
					<div class="hottip-inner-wrapper2" >
					
					<div class="collection-information2">
						<div class="collection-title-wrapper2">
							<div class="collection-title-border2"> <!-- 줄 -->
							<p class="collection-title2" style="overflow-wrap:break-word;">
								"<이번주 인기 음식>" <br> "중국당면 TIP!" </p>
							</div><!-- collection-title-border2 -->
						</div><!-- collection-title-wrapper2 -->
						
						<p class="collection-description-wrapper2" style="overflow-wrap:break-word;">
							"맛있게 먹고 싶다면?"<br>
						</p>
					</div><!-- collection-information -->
					
					</div><!-- hottip-inner-wrapper2-->
				</a><!-- hot2 -->
				</div><!-- hot-tip-second -->
							  	  
			</div><!-- top-tip-in -->
			
		<div class="muktip-feed">
		
		<div class="top-bar">
			<p class="top-label">인기음식</p>
		</div>
		
		<div class="muktip-contents" style="height: 1550px;"> 	
			<div class="line-space">
<%	
		pstmt = con.prepareStatement("select distinct post.postid, postimgid, title, content, writer, date, imgname, user.id, profile from post join img on post.postid = postimgid join user on writer = user.id join goodmuck on post.postid = goodmuck.postid where good_chk = 1 group by postid");
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
			</div>
			
<%		
			if(count%4==0) {
%>
				<div class="line-space">	
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
	
		</div><!-- top-tip-fid -->
	</section><!-- main-page -->
	
<%-- 	<jsp:include page="fullView.jsp" flush="false"></jsp:include>	 --%>
	<%@ include file="footer.jsp" %>
	
</body>
</html>