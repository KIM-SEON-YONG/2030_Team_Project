<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.TTteamProject.model.UserDTO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/common.css">
<!-- 공용 -->
<title></title>
</head>
<style>
/* rgb(234, 197, 245);#E6E6FA;  */
nav {
	position: relative;
	height: 150px;
	display: flex;
	word-wrap: break-word;
}
/* S.P.A.R.K - 왼쪽 상단 */
.header-mini {
	padding-left: 10px;
	font-size: 2rem;
	color: #333;
	position: absolute; /* 위치를 절대값으로 설정 */
	top: 0; /* 상단에 배치 */
	left: 0;
}
/* 로그인 및 회원가입 - 오른쪽 상단 */
.nav-header {
    display: flex;
    justify-content: flex-end; /* 내부 요소를 오른쪽 끝으로 정렬 */
    align-items: center;
    padding: 10px 20px; /* 여백 추가 (선택 사항) */
    width: 100%; /* 전체 너비 설정 */
}
.logout,
.button-container {
    display: flex;
    gap: 10px; /* 버튼 간격 */
}
.button {
    display: inline-block;
    padding: 12px 24px;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
    text-decoration: none;
}
.login-button, .signup-button, .nav-logout, .nav-mypage {
    background-color: white;
    color: gray;
}
.login-button:hover, .signup-button:hover, .nav-logout:hover, .nav-mypage:hover  {
    background-color: #E6E6FA;
}

/* 네비게이션 아이템 */
.nav-items {
	display: flex;
    justify-content: center; /* 가운데 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    gap: 20px; /* 네비게이션 아이템 간 간격 */
    padding: 10px 0; /* 위아래 여백 */
    width: 100%; /* 전체 너비 사용 */
}
.nav-item {
	padding: 20px;
	text-decoration: none;
	color: black;
}
.nav-item:hover {
	color: #007bff; /* 링크 hover 효과 */
}
</style>
</head>
<body>
	<header>
		<nav class="nav">
			<!-- 왼쪽 상단 "S.P.A.R.K" -->
			<a class="header-mini" href="Main.jsp">S.P.A.R.K</a>

			<div class="nav-header">
				<%
				// 세션에서 사용자 정보를 가져옵니다.
				UserDTO user = (UserDTO) session.getAttribute("user"); // 세션에서 'user' 속성 가져오기
				if (user != null) {
				%>
				<!-- 로그인된 사용자만 볼 수 있는 버튼 -->
				<div class="logout">
					<form action="LogOutCon" method="post">
						<button class="btn nav-logout">로그아웃</button>
					</form>
					<a href="Mypage.jsp" class="btn nav-mypage">마이페이지</a>
				</div>
				<%
				} else {
				// 로그인되지 않은 상태라면 로그인 버튼만 표시
				%>
				<div class="button-container">
					<a href="login.jsp" class="button login-button">로그인</a> <a
						href="join.jsp" class="button signup-button">회원가입</a>
				</div>
				<%
				}
				%>
			</div>

			<!-- 네비게이션 아이템들 -->
			<div class="nav-items">
				<a class="nav-item" href="policy_job.jsp">취업</a> <a class="nav-item"
					href="policy_wedding.jsp">결혼</a> <a class="nav-item"
					href="policy_pregnancy.jsp">출산</a> <a class="nav-item"
					href="BS1.html">지역혜택</a> <a class="nav-item" href="boarSdList.jsp">커뮤니티
					게시판</a>
			</div>
		</nav>
	</header>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>