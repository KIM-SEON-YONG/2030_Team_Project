<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.TTteamProject.model.UserDTO"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/common.css">
<!-- 공용 -->
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
.nav-items{
 	display: block; /* 각 항목을 블록 요소로 만들어 줄바꿈을 자동으로 처리 */
    margin-bottom: 10px; /* 항목 간의 여백 추가 */
}

</style>
</head>
<body>
	<header>
		<nav class="nav">
			<a class="header-mini" href="Main.jsp">S.P.A.R.K</a>
			<div class="nav-header">
				<%
					// 세션에서 사용자 정보를 가져옵니다.
					UserDTO user = (UserDTO) session.getAttribute("user"); // 세션에서 'user' 속성 가져오기
					if (user != null) {
						// 로그인된 상태라면 환영 메시지와 로그아웃/마이페이지 버튼 표시
						out.print("환영합니다~💕 " + user.getUser_name() + "님🎉🎉");
				%>
					<br> <!-- "환영합니다" 후 줄바꿈 추가 -->
					<!-- 로그인된 사용자만 볼 수 있는 버튼 -->
					<form action="LogOutCon" method="post">
						<button class="btn btn-link nav-logout">로그아웃</button>
						<a href="Mypage.jsp">마이페이지</a><br>
					</form>
				<%
					} else {
						// 로그인되지 않은 상태라면 로그인 버튼만 표시
						out.print("<a href='login.jsp'>로그인</a><br>");
						out.print("<a href='join.jsp'>회원가입</a>");
					}
				%>
				<br> <!-- 로그인 상태와 로그인되지 않은 상태 사이에 줄바꿈 추가 -->
				
				<!-- 네비게이션 아이템들 -->
				<div class="nav-items">
					<a class="nav-item" href="policy_job.jsp">취업</a> 
					<a class="nav-item"	href="policy_wedding.jsp">결혼</a> 
					<a class="nav-item"	href="policy_pregnancy.jsp">출산</a>
					<a class="nav-item"	href="BS1.html">지역혜택</a> 
					<a class="nav-item" href="boarSdList.jsp">커뮤니티 게시판</a>
				</div>
			</div>
		</nav>
	</header>

</body>
</html>