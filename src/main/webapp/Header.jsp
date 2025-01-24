<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.TTteamProject.model.UserDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title></title>
</head>
<style>
nav {
	position: relative;
	height: 150px;
	background-color: rgb(234, 197, 245); /* 배경색 */
	display: flex;
	word-wrap: break-word;
}
/* S.P.A.R.K - 왼쪽 상단 */
.header-mini {
	font-size: 2rem;
	color: #333;
	position: absolute; /* 위치를 절대값으로 설정 */
	top: 0; /* 상단에 배치 */
	left: 0; /* 왼쪽에 배치 */
}
/* 로그인 및 회원가입 - 오른쪽 상단 */
.nav-header {
	position: absolute;
	right: 20px; /* 오른쪽에서 20px 왼쪽 */
	display: flex;
	gap: 20px; /* 각 항목 간격 */
	font-size: 14px;
	list-style: none;
	margin-right: 15px; /* 오른쪽에서 살짝 떨어지도록 설정 */
	color: black;
}
/* 환영 메시지 - 가운데 */
.welcome-message {
    position: absolute;
    left: 50%; /* 왼쪽 기준으로 50% 이동 */
    transform: translate(-20%); /* 수평, 수직 중앙 정렬 */
    display: flex;
    font-size: 18px;
    text-align: center;
}
/* 네비게이션 아이템 - 가운데 아래 */
.nav-items {
	position: absolute;
	left: 50%; /* 왼쪽 기준으로 50% 이동 */
	transform: translate(-50%,+400%);
	display: flex;
	gap: 30px; /* 각 항목 간 간격 */
	font-size: 18px;
	color: gray; /* 마우스 오버 시 색상 */
}

</style>
</head>
<body>
	<header>
		<nav class="nav">
			<a class="header-mini" href="Main.jsp">S.P.A.R.K</a>
			<div class="nav-header">
				<!-- 로그인 상태에 따라 보이거나 숨기기 -->
				<%
				Cookie[] cookies = request.getCookies();
				String user_id = null;

				/// 쿠키에서 user_id 가져오기
				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if ("user_id".equals(cookie.getName())) {
					user_id = cookie.getValue();
					break;
						}
					}
				}
				%>
				<nav>
					<%
					if (user_id == null) {
					%>
					<!-- 로그인되지 않은 상태 -->
					<a href="login.jsp">로그인</a> &nbsp;&nbsp;
					<a class="nav-join" href="join.jsp">회원가입</a>
					<%
					} else {
					%>
					<!-- 로그인된 상태  -->
					<span>환영합니다~💕<%=user_id%>님🎉🎉
					</span>
					<form action="LogOutCon" method="post" style="display: inline;">
						<button class="btn btn-link nav-logout">로그아웃</button>
						<a href="Update.jsp">개인정보수정</a>
					</form>
					<%
					}
					%>
			</div>
			<div class="nav-items">
				<a class="nav-item" href="#">취업</a> 
				<a class="nav-item" href="#">결혼</a>
				<a class="nav-item" href="#">출산</a>
				<a class="nav-item" href="BS1.html">지역혜택</a>
				<a class="nav-item" href="">커뮤니티 게시판</a>
			</div>
		</nav>
	</header>




	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		rel="stylesheet">
		
	</script>
</body>
</html>