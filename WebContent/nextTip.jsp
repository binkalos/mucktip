<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이번주 인기음식</title>
<link rel="stylesheet" href="nextTipStyle.css" >
<script src="js/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function(){
		$(".open-fullview").click(function() {
			$("#dim-layer").css("display", "block");
		});
		
		$(".close-fullview").click(function() {
			$("#dim-layer").css("display", "none");
		});
	});

</script>
</head>
<body>
	<!-- Top -->
	<%@ include file="TopWrapper.jsp"%>
	<!-- Center -->
		<div class="center">
		<div class="toptip-wrapper"><!-- 메인 팁 담고있는  div -->
		<%   
    request.setCharacterEncoding("utf-8");
	String imgPath = null;
	
	Connection con2 = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs2 = null;
	
	String driver2 = "com.mysql.jdbc.Driver";
	String url2 = "jdbc:mysql://localhost:3306/mucktip?serverTimezone=UTC&useSSL=false";
	String id2 = "root";
	String pw2 = "alflarhkgkrrh1!";
	

	try {
		Class.forName(driver);
		con = DriverManager.getConnection(url, id, pw);
		 
		pstmt = con.prepareStatement("select * from nexttip");
		rs = pstmt.executeQuery();
	
		if(rs.next()) {
%>
			<div class="nexttip" style="background-image:url('img/<%=rs.getString("img") %>'); background-size:cover;">
				<%
		}
	%>
				<div class="nexttip-inner-wrapper" >
				
				<div class="collection-information">
					<div class="collection-title-wrapper">
						<div class="collection-title-border">
						<p class="collection-title" style="overflow-wrap:break-word;">
							"이번주 인기 음식"<br>"마라탕 TIP!"</p>
						</div><!-- collection-title-border -->
					</div><!-- collection-title-wrapper -->
					
						<p class="collection-description-wrapper" style="overflow-wrap:break-word;">
							"맛있게 먹고싶다면?"<br>
						</p><!-- collection-description-wrapper -->
					</div><!-- collection-information -->
				
				</div><!-- nexttip-inner-wrapper -->
			  	</div><!-- nexttip -->
			  	
			 <div class="nexttip-wrapper">
			 	<div class="righttip">
			 		
					
				 		<div class="collection-information-right">
				 			
						<div class="collection-title-wrapper">
						<img class="recommendedimg-sun" src="img/sun.png">
				 			<img class="recommendedimg-rain" src="img/rain.png">
							<div class="collection-title-border">
							<p class="collection-title-right" style="overflow-wrap:break-word;">
								"이번주 인기음식을 다 먹어봤다면"<br>"더 많은 추천음식 보러갈래?"<br>
								<a class="go-nextpage" href="recommendTip.jsp">
									<img class="nextIcon" src="img/nextIcon.png"><!-- 옆으로 넘기는 버튼 -->
								</a>
							</p>
							</div><!-- collection-title-border -->
						</div><!-- collection-title-wrapper -->
						
						</div><!-- collection-information -->
			 	</div><!-- nexttip -->
			 </div><!-- nexttip-wrapper -->
			 
		</div><!-- toptip-wrapper -->
		
		<div class="nexttip-feed">
		
			<div class="nexttip-contents" style="height: 1550px;"> <!-- 전체 박스 -->
			<div class="line-space"></div>
			
			<div class="top-bar">
				<p class="top-label">마라 들어간 음식보기</p>
			</div>
			
			<%	
			String hot = "마라";
			pstmt = con.prepareStatement("select distinct post.postid, postimgid, title, content, writer, date, imgname, user.id, profile from post join img on post.postid = postimgid join user on writer = user.id join goodmuck on post.postid = goodmuck.postid where title like '%마라%' or content like '%마라%' group by postid");
			pstmt.setString(1, "%"+hot+"%");
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
			<div class="line-space"></div>	
<%			}

		} //while
		} catch(Exception e) {
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
		</div> <!-- maintip-contents -->	
		</div><!-- maintip-feed -->	
		
		</div><!-- center -->
	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>