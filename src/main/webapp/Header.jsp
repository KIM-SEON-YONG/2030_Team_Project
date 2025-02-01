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
	font-size : 2rem;
	color: #333;
	position: absolute; /* 위치를 절대값으로 설정 */
	top: 0; /* 상단에 배치 */
	left: 0;
}
/* 로그인 및 회원가입 - 오른쪽 상단 */
.nav-header {
	position: absolute;
	right: 20px; /* 오른쪽에서 20px 왼쪽 */
	display: flex;
	gap: 10px; /* 각 항목 간격 */
	font-size: 16px;
	color: black;
	white-space: pre-line;
	align-items: center; /* 수직 중앙 정렬 */
}
/* 로그아웃 버튼과 마이페이지 링크 스타일 */
.logout {
    display: flex;
    gap: 10px; /* 버튼과 링크 사이에 간격 추가 */
    align-items: end; 
}
/* 마이페이지 링크 스타일 */
.nav-mypage,.nav-logout {
    text-decoration: none; /* 링크 밑줄 제거 */
    color: black; /* 링크 색상 */
    padding: 6px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f8f9fa; /* 버튼 배경색 */
    font-size: 16px;
    display: inline-block; /* 버튼처럼 보이도록 */
}
.nav-mypage:hover,.nav-logout:hover {
    background-color: #007bff;
    color: white; /* hover 시 배경색 변경 */
}

.nav-items {
	padding-left: 480px;
	padding-top: 50px;
	display: flex;
	justify-content: center;
	align-items: center;
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
					out.print("<a href='login.jsp'>로그인</a>");
					out.print("<a href='join.jsp'>회원가입</a>");
					}
				%>
			</div>
			
			<!-- 네비게이션 아이템들 -->
			<div class="nav-items">
				<a class="nav-item" href="policy_job.jsp">취업</a> 
				<a class="nav-item" href="policy_wedding.jsp">결혼</a> 
				<a class="nav-item" href="policy_pregnancy.jsp">출산</a>
				<a class="nav-item" href="BS1.html">지역혜택</a>
				<a class="nav-item" href="boarSdList.jsp">커뮤니티 게시판</a>
			</div>
		</nav>
	</header>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>