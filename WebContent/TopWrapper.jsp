<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="TopWrapperStyle.css" >
<script>
//클릭시 드롭다운
// html dom 이 다 로딩된 후 실행된다.
$(document).ready(function(){
  // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
  $(".profile-img-btn").click(function(){
      var submenu = $(this).next(".user-menu-list");

      // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
      if( submenu.is(":visible") ){
          submenu.slideUp();
      }else{
          submenu.slideDown();
      }
  });
});
</script>
<%
	//로그인 한 사람이라면 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
	String userid = null;
	if (session.getAttribute("username") != null) {
		userid = (String) session.getAttribute("username");
	}
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/mucktip?serverTimezone=UTC&useSSL=false";
	String id = "root";
	String pw = "alflarhkgkrrh1!";
%>
<!-- 맨위에 top메뉴 공간 개발 나중에 따로 빼놓을 부분-->
		<nav id="top-menu-all">
		<div id="main-menu">
			<div class="contents-wrapper">
				<div class="left-contents-wrapper">
					<div class="muktip-logo"></div>
					<a href="firstPage.jsp" class="new-tip">최신 먹팁</a>
					<a href="recommendTip.jsp" class="good">추천</a>
				</div><!-- left-contents-wrapper -->
				
				<div class="right-contents-wrapper">
					<%
						//로그인이 안된 경우
						if (userid == null) {
					%>
					<div class="login-join"> <!-- 로그인 / 가입 -->
						<a href="login.jsp">로그인</a> /
						<a href="join.jsp">가입</a> <!-- 가입 페이지 미구현 -->
					</div> <!-- login-join -->
					<%
						} else { //로그인이 된 경우
							
							try {
								Class.forName(driver);
								con = DriverManager.getConnection(url, id, pw);
								
								pstmt = con.prepareStatement("select * from user where id =?");
								pstmt.setString(1, userid);
								rs = pstmt.executeQuery();
								
								if(rs.next()) {
					%>
					<div class="user-menu" id="user-menu">
						<div class="dropdown">
						<button class="profile-img-btn"> <!-- 이미지 버튼(회원 이미지) -->
							<img class="profile-image" src="img/<%=rs.getString("profile")%>">
						</button>
						<ul class="user-menu-list"> <!-- 메뉴리스트 -->
							<li class="menu-item">
								<a class="menu-link" href="Mypage.jsp?id=<%=rs.getString("id")%>"> <!-- /유저 이름으로 -->
									<img class="menu-icon-mini" src="img/<%=rs.getString("profile")%>">
									<span class="menu-user-name"><%=userid %></span>
								</a>
							</li>
								
							<li class="menu-item">
								<a class="menu-link" href="음식바구니.jsp" rel="nofollow">
								<img class="menu-icon-myfood" src="img/foodbox.png">
								<span class="menu-text-mtfood">내 음식바구니</span>
								</a>
							</li>
																				
							<li class="menu-item">
								<a class="menu-link"  href="logoutProc.jsp" rel="nofollow">
								<img class="menu-icon-logout" src="img/logout.png">
								<span class="menu-text-logout">로그아웃</span>
								</a>
							</li>
						</ul> <!-- user-menu-list -->
						</div><!-- dropdown -->
					</div><!-- user-menu -->
					<%
								} //if				
							} catch (Exception e) {
								e.printStackTrace();
							} 
						} //else
					%>
				</div><!-- right-contents-wrapper -->
			
			
				<div class="search-wrapper">
					<form class="search-form" action="search.jsp" method="get">
						<table cellpadding=0 cellspacing=0>
						<tr>
						<td>
						<label class="input-wrapper">
							<input class="search-keyword" type="text" name="keyword" placeholder="검색" required>
						</label>
						</td>
						<td>
						<button class="search-button" type="submit">
							<a href="search.jsp"><span class="ic_search"></span></a>
						</button>
						</td>
						</tr>
						</table>
					</form>
				</div><!-- search-wrapper -->			
		</div><!-- contents-wrapper -->
		</div><!-- main-menu -->
		
		<!-- 서브메뉴 -->
		<div id="sub-menu-wrapper" class="show">
			<ul class="sub-contents-wrapper">
				<li class="sub-menu selected" data-text="인기">
					<a href="firstPage.jsp">인기</a>
				</li>
				<li class="sub-menu" data-text="최신">
					<a href="newPost.jsp">최신</a>
				</li>
				<li class="sub-menu" data-text="TV">
					<a href="whatToEat.jsp">뭐먹지?</a>
				</li>
				<li class="sub-menu" data-text="추천">
					<a href="wheater.jsp">추천</a>
				</li>
			</ul><!-- sub-contents-wrapper -->
		</div><!-- sub-menu-wrapper -->	
		
</nav><!-- top-menu-all -->	