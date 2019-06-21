<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		request.setCharacterEncoding("utf-8");
		String postid = request.getParameter("postid");
		String userid = (String)session.getAttribute("username");
			
		String imgPath = null;
		
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
	%>
<!DOCTYPE html>
<html>
<head>
<title>먹팁</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="fullViewStyle.css" >
<script src="js/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function() {
		var img_count = $('.content').length;
		var position = 1;
		$('.prev').click(function() {
			if(position > 1) {
				$('#contents-wrapper').animate({
					left:'+=600'
				});
				position--;
			}
		});
		$('.next').click(function() {
			if(position < img_count) {
				$('#contents-wrapper').animate({
					left:'-=600'
				});
				position++;
			}
		});
	});
	
	function logincheck() {
		var login = "<%=session.getAttribute("username")%>";
		if(login == "null") {
			alert("로그인을 하셔야 이용할 수 있는 기능입니다.!");
			location.href = "login.jsp";
		}else {
			location.href = "likeAction.jsp?userid=<%=userid%>&postid=<%=postid%>";
		}
	}
	
	function enterkey() {
		if(window.event.keyCode == 13) { //엔터키가 눌렸을 때 실행
			var comment = null;
			comment = document.getElementById("comment").value;
			if(comment != "\n") {
				location.href = "commentAction.jsp?comment="+comment+"&userid=<%=userid%>&postid=<%=postid%>";
			}
			document.getElementById("comment").value = null; //값 초기화
		}
	}
	
	function delOk(id) {
		var del = confirm("댓글을 삭제하시겠습니까?");
		
		if(del){
			location.href = "commentDel.jsp?id="+id+"&postid=<%=postid%>";
		}
	}
</script>
</head>
<body>
	<jsp:include page="TopWrapper.jsp"></jsp:include>
<!-- <div id="dim-layer" class="hidden"> -->
<!-- <div class="mask"></div> -->
<!-- <div class="muktip-modal"> -->

<!-- 	<div class="tip-position"> -->
<!-- 	<div class="middle"> -->
<!-- 	<div class="tip-frame"> -->
<!-- 	<div class="tip-body"> -->
<!-- 	<div class="top-upper-body"> -->
<!-- 		<div class="close"><a class="close-fullview" href="#stay">X</a></div>   -->
	<section class="fullview">
				<div class="fullview-inner-wrapper">
				
					<div class="pictures-wrapper">
					
						<div class="pictures" data-contents-count="DB count">
							
						<div class="conveyer-belt" data-picture-ids="DB picture ID">
							<figure id="contents-wrapper" class="img-contents-wrapper" style="width:1800px; height: 600px;">
	<%		
			pstmt = con.prepareStatement("select * from img where postimgid = ?");
			pstmt.setString(1, postid);
			rs = pstmt.executeQuery();
	
			while(rs.next()) {    
				imgPath =request.getContextPath() + "/post/" + rs.getString("imgname");
	%>
								<img class="content" src="<%= imgPath %>" data-mobile-src="address" width="600" height="600"
									data-latio="1.0" data-picture-id="DB id">
	<%		
			}
	%>
							</ul>
							</figure>								
						</div><!-- conveyer-belt -->
										
						<button class="prev">
							<span class="sprit arrow-left"><img src="img/prev.png" width=50px height=50px></span>
						</button><!-- prev -->
											
						<button class="next">
							<span class="sprit arrow-right"><img src="img/next.png" width=50px height=50px></span>		
						</button><!-- next -->		
															
					</div><!-- pictures -->
										
					<div class="sumnails-wrapper">
						<div class="sumnails">
	<%
			pstmt = con.prepareStatement("select * from img where postimgid = ?");
			pstmt.setString(1, postid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {   
				imgPath =request.getContextPath() + "/post/" + rs.getString("imgname");
	%>
							<figure class="sumnail-border">
								<img class="sumnail" src="<%= imgPath %>" width="50" height="50">
							</figure>
	<%
			}
	%>
						</div><!-- sumnails -->
					</div><!-- sumnails-wrapper -->
									
				</div><!-- pictures-wrapper -->
						
	<%
			pstmt = con.prepareStatement("select distinct postid, postimgid, title, content, writer, date, imgname, id, profile from post join img on postid = postimgid join user on writer = id where postid=? group by postid;");
			pstmt.setString(1, postid);
			rs = pstmt.executeQuery();
	%>					
						
				<div class="side-position" id="error_solve">
					<div class="information-wrapper">
						<div class="information">
							<div class="user-card" data-following-status-url="게시자 링크">
	<%		
			if(rs.next()) {
	%>
							<div class="profile-picture">
								<a hrf="Mypage.jsp?id=<%=rs.getString("id")%>" target="_blank">

								<img class="user-profile" src="img/<%=rs.getString("profile") %>" width="40px" height="40px"> <!-- img(user) in DB -->
								</a>
							</div><!-- profile-picture -->
									
							<div class="user-information">
								<div class="clearfix">
									<a class="nickname" href="유저 아이디" target="_blank">
										<p class="name-bold"><%=rs.getString("writer")%></p>
									</a>
								</div><!-- clearfix -->
							</div><!-- user-information -->			
								
							</div><!-- user-card -->
								
							<div class="scroll-bar-component">
								<div class="description-wrapper">
									<div class="description">
										<p class="title-wrapper"><%=rs.getString("title") %></p>
										<p class="content-wrapper"><%=rs.getString("content") %></p>
									</div>
								</div><!-- discription-wrapper -->
									
								<div class="scroll-bar-rail">
									<div class="bar" style="margin-top:0px; height: 120px;"></div><!-- bar -->
								</div><!-- scroll-bar-rail -->
	<%			
			}
	%>														
							</div><!-- scroll-bar-component -->
							
						</div><!-- information -->
						<div class="action">
						
						<button class="like-btn" onclick="logincheck()">
	<%
			pstmt = con.prepareStatement("select * from goodmuck where userid=? and postid=?");
			pstmt.setString(1, userid);
			pstmt.setString(2, postid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int goodchk = rs.getInt("good_chk");
				if(goodchk == 1) {
					out.println("<img class='like-img' src='img/spoon2.png'>");
				} else {
					out.println("<img class='like-img' src='img/spoon1.png'>");
				}
			} else {
				out.println("<img class='like-img' src='img/spoon1.png'>");
			} 
			
			pstmt = con.prepareStatement("select count(*) from goodmuck where postid=? and good_chk=?");
			pstmt.setString(1, postid);
			pstmt.setInt(2, 1);
			rs = pstmt.executeQuery();
			
			int likecount = 0;
			if(rs.next()) {
				likecount = rs.getInt(1);			
			}
	%>
						</button>
						
						<div class="like-count"><%= likecount %></div>				
						</div><!-- action -->
					
					</div><!-- information-position -->
			
					<div class="comment-wrapper" data-comments-url="디비주소" data-comments-count="DB comments count">
	<%
			pstmt = con.prepareStatement("select * from comments where postid=?");
			pstmt.setString(1, postid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pstmt = con.prepareStatement("select count(*) from comments where postid=?");
				pstmt.setString(1, postid);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
	%>					
						<div class="clear-fix">
							<p class="comments-count">댓글
								<span class="op-count">(<%=rs.getInt(1)%>)</span>
							</p>
						</div><!-- clear-fix -->
						
						<div class="comments">
						<div class="comments-inner-wrapper">
							<ul class="op-comments">
	<%
				}
				
				pstmt = con.prepareStatement("select commentsid, comment, date, id, profile from comments join user on userid = id where postid=?");
				pstmt.setString(1, postid);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
	%>
<!-- 							<button class="load-comments" data-next-url="(디비에 있는 주소)">더 보기 -->				
								<li class="comment" data-id="id" data-autor-id="id"
													data-author-bio data-author-nickname="댓글 단 user닉네임"
													data-author-profile-picture-url="사진 누르면 댓글단 user페이지로">
								
								<div class="commenter-picture">
									<a href="Mypage.jsp?id=<%=rs.getString("id")%>" target="_blank">
										<img src="img/<%=rs.getString("profile") %>" width="30" height="30">
									</a>
								</div><!-- commenter-picture-left -->
								
								<div class="delete-button-wrapper"></div>
								
								<div class="remaining-width">
									<p class="comment-body-wrapper remaining-width">
										<a class="commenter" href="Mypage.jsp?id=<%=rs.getString("id")%>" target="_blank"><%=rs.getString("id") %></a>
										<span class="comment-body"><%=rs.getString("comment") %></span>
									</p>
									<time datetime="댓글단 날짜" title="댓글쓴날짜"><%=rs.getDate("date") %></time>
								</div><!-- remaining-width -->
	<%
					if(userid.equals(rs.getString("id"))) { //내가 쓴 댓글만 삭제 가능
	%>
								<div class="del-button-wrapper">
									<button class="del-button" onclick="delOk(<%=rs.getInt("commentsid")%>)">X</button>
								</div>
								
								</li><!-- comment -->
	<%		
					}
				}
	%>
							</ul><!-- op-comments -->
					</div><!-- comments-inner-wrapper -->
	<%
			} else { 
	%>
						<div class="clear-fix">
							<p class="comments-count">댓글
								<span class="op-count">(0)</span>
							</p>
						</div><!-- clear-fix -->	
	<%
			}
			
			if(userid != null) {
	%>			
						<div class="comment-input-field">
							<ul class="mentionable-users"></ul>
							<label class="input-group">
								<div class="side-input-wrapper">
									<textarea type="text" class="input" id="comment" placeholder="댓글을 남기세요,,," tabindex="1" onkeyup="enterkey();"></textarea>
								</div><!-- input-wrapper -->
							</label>
						</div><!-- comment-input-field -->
	<%
			}
	%>
					</div><!-- comment-wrapper -->
				</div><!-- side-position -->		
							
			</div><!-- fullview-inner-wrapper -->
		</section><!-- fillview -->
		
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
		<jsp:include page="footer.jsp"></jsp:include>
					
<!-- 	</div>top-upper-body -->
<!-- 	</div>tip-body -->
<!-- 	</div>tip-frame -->
<!-- 	</div>middle -->
<!-- 	</div>tip-position -->

<!-- </div>dim-layer  -->
<!-- </div>muktip-modal -->
</body>
</html>