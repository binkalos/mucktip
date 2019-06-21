<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="MypageStyle.css" >
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
<title>먹팁</title>
</head>
<body>
<%@ include file="TopWrapper.jsp"%>
	
	<%
		request.setCharacterEncoding("utf-8");
		String u_id = request.getParameter("id");
		
		String imgPath = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pw);
			
			pstmt = con.prepareStatement("select * from user where id =?");
			pstmt.setString(1, u_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
	%>
	<section class="user-profile">
	
		<!-- 맨 위 유저 정보 들어가 있는 공간  -->
		<div class="profile-all">
			
			<div class="profile-wrapper">
				<div class="top-profile">
					<div class="profile-img">
						<img class="profile" src="img/<%=rs.getString("profile") %>" width="120px" height="120px">
					</div><!-- profile-img -->
					
					<div class="user-name">
						<div class="name-wrapper">
							<p class="nickname-mypage"><%= rs.getString("id") %></p><!-- nick-name -->
<!-- 							<p class="user-name-wrapper"> -->
<!-- 								<span class="username">dbid</span> -->
<!-- 							</p>user-name-wrapper -->
						</div><!-- name-wrapper -->
					</div><!-- user-name -->

					<div class="counts">
						<div class="count-wrapper">
							<p class="count-label">내 관심 먹팁</p>
							<p class="count">1</p> <!-- 임시 숫자 -->
						</div>
						<!-- count-wrapper -->
					</div>
					<!-- counts -->

					<div class="user-setting">
						<button class="setting-btn">
							<a class="setting-link" href="setting.jsp" rel="nofollow">설정</a>
						</button>

						<button class="write-btn">
							<a class="write-link" href="Postboard.jsp" rel="nofollow">글쓰기</a>
						</button>
					</div><!-- user-information -->
				</div><!-- top-profile -->

			</div><!-- profile-wrapper -->
		</div><!-- profile-all -->
	<%		 
			}	
	%>
		<!-- center부분에 게시글 보기 -->
		<div class="mygood-tip">
			<p class="mygood-tip-txt">먹고싶은 먹팁</p>
		</div> <!-- mygood-tip  -->
		
		<div class="want-contents"> <!-- 전체 박스(좋아요 누른것들) -->
	<%
		pstmt = con.prepareStatement("select distinct post.postid, postimgid, title, content, writer, date, imgname, user.id, profile from post join img on post.postid = postimgid join user on writer = user.id join goodmuck on post.postid = goodmuck.postid where good_chk = 1 and goodmuck.userid = ? group by postid");
		pstmt.setString(1, u_id);
		rs = pstmt.executeQuery();
	
		int max1 = 0;
		
		while(rs.next()) {
		imgPath =request.getContextPath() + "/post/" + rs.getString("imgname");
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
				max1++;
				if(max1 > 4) {
		%>
				<div class="more-view"><!-- 더보기 버튼 -->
					<a class="more-btn" href="write.jsp" rel="nofollow">
						<img src="img/more.png" width="50px" height="50px">
					</a>
				</div><!-- more-view -->
		<%			
					break;
				}
			}
		%>		
		</div><!-- want-contents -->
		
		<div class="write-tip">
			<p class="write-tip-txt">내가올린 먹팁</p>
		</div> <!-- write-tip  -->
		
		<div class="user-write-contents"> <!-- user가 올린 게시글 -->
	<%
		pstmt = con.prepareStatement("select distinct postid, postimgid, title, content, writer, date, imgname, id, profile from post join img on postid = postimgid join user on writer = id where writer = ? group by postid");
		pstmt.setString(1, u_id);
		rs = pstmt.executeQuery();
	
		int max2 = 0;
		
		while(rs.next()) {
		imgPath =request.getContextPath() + "/post/" + rs.getString("imgname");
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
			max2++;
			if(max2 > 4) {
	%>
			<div class="more-view"><!-- 더보기 버튼 -->
				<a class="more-btn" href=".jsp" rel="nofollow">
					<img src="img/more.png" width="50px" height="50px">
				</a>
			</div><!-- more-view -->
	<%			
				break;
			}
		}
	%>
			
		</div><!-- user-write-contents -->
		
	</section><!-- user-profile -->	
	<%
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
			
<%-- 	<%@ include file="fullView.jsp" %>	 --%>
	
	<%@ include file="footer.jsp" %>	
</body>
</html>