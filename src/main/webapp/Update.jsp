<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="com.TTteamProject.model.UserDTO"%>
<%@ page import="com.TTteamProject.model.BoardDTO"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.util.List"%>


<%
String pwdchkMessage = (String) request.getAttribute("pwdchkMessage");
if (pwdchkMessage != null) {
%>
    <script type="text/javascript">
        alert("<%= pwdchkMessage %>");
    </script>
<%
}
String updatedUserFail = (String) request.getAttribute("updatedUserFail");
if (updatedUserFail != null) {
%>
    <script type="text/javascript">
        alert("<%= updatedUserFail %>");
    </script>
<% } %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<link rel="stylesheet" href="assets/css/common.css">
<!-- 공용 -->
<style type="text/css">
.box{

}
/* 전체 레이아웃 */
.container {
	display: flex; /* Flexbox를 사용하여 자식 요소들을 배치 */
	
}

/* 메뉴 스타일 */
.menu {
	background-color: #E6E6FA; /* 배경색 설정 */
	padding: 20px; /* 내부 여백 */
	border: 1px solid #ccc; /* 테두리 설정 */
	width: 200px; /* 메뉴 영역 너비 */
	height: 100vh; /* 화면 전체 높이 */
	display: flex; /* Flexbox를 사용하여 자식 요소들을 세로로 배치 */
	flex-direction: column; /* 세로 방향으로 배치 */
	align-items: center; /* 자식 요소들을 수평 중앙에 배치 */
}

/* 프로필 섹션 */
.profile-container {
	text-align: center; /* 텍스트 중앙 정렬 */
	margin-bottom: 20px; /* 아래쪽 여백 */
}

.profile-img {
	width: 80px; /* 프로필 이미지 너비 */
	height: 80px; /* 프로필 이미지 높이 */
	border-radius: 50%; /* 원형으로 만들기 */
	object-fit: cover; /* 이미지 비율 맞추기 */
}

.nickname {
	font-size: 16px; /* 폰트 크기 */
	color: #333; /* 글자 색 */
	font-weight: bold; /* 글자 굵기 */
}

/* 메뉴 아이템 */
.menu ul {
	list-style: none; /* 기본 목록 스타일 제거 */
	padding: 0; /* 내부 여백 제거 */
	margin: 0; /* 외부 여백 제거 */
	width: 100%; /* 메뉴 너비를 100%로 설정 */
}
.menu li {
	margin: 10px 0; /* 메뉴 항목 간 여백 */
}
.menu a {
	text-decoration: none; /* 링크의 밑줄 제거 */
	color: #333; /* 링크 색상 */
	display: block; /* 링크를 블록 요소로 만들어 클릭 영역 확장 */
	padding: 10px; /* 내부 여백 */
	text-align: center; /* 텍스트 중앙 정렬 */
	background-color: #D3CCE3; /* 배경색 설정 */
	border: 1px solid #ddd; /* 테두리 설정 */
	border-radius: 10px; /* 모서리 둥글게 처리 */
	transition: background-color 0.3s; /* 배경색 변화에 애니메이션 효과 추가 */
}
.menu a:hover {
	background-color: #C0B3DF; /* 호버 시 배경색 변화 */
}
/* 메인 콘텐츠 */
.main-content {
	flex-grow: 1; /* 남은 공간을 채우기 */
	padding: 20px; /* 내부 여백 */
	background-color: #f9f9f9; /* 배경색 설정 */
	justify-items: center;
}

/* 정보 테이블 스타일 */
.info-table {
	width: 50%; /* 테이블 너비를 100%로 설정 */
	border-collapse: collapse; /* 테두리 겹침 제거 */
	margin-top: 20px; /* 위쪽 여백 */
}

.info-table th, .info-table td {
	border: 1px solid #ddd; /* 셀 테두리 설정 */
	padding: 10px; /* 셀 내부 여백 */
	text-align: left; /* 텍스트 왼쪽 정렬 */
}
.info-table th {
	background-color: #f2f2f2; /* 테이블 헤더 배경색 */
}
/* 저장 버튼 스타일 */
input[type="submit"] {
    background-color: white; /* 버튼 배경색 */
    color: black;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    width: 350px; 
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #E6E6FA; /* 호버 시 색상 변화 */
}
</style>
</head>
<body>
	<!-- 해더  -->
	<%@ include file="Header.jsp"%>
	
	<% 
		UserDTO updatedUser = (UserDTO) session.getAttribute("updatedUser"); // session에서 user 객체를 가져옴
		if (user == null) {
			// user 객체가 null인 경우 로그인 페이지로 리디렉션
			response.sendRedirect("login.jsp");
			return;
		}
	%>
	
	<!-- 회원 정보 수정 폼 -->
	<form class="box" action="UpdateCon" method="post">
		<div class="container">
			<!-- 메뉴 -->
			<div class="menu">
				<div class="profile-container">
					<!-- 프로필 이미지 -->
					<img id="profile-img" class="profile-img"
						src="https://goodpokki.kr/common/img/default_profile.png"
						alt="프로필 이미지">
					<p class="nickname"><%= user.getUser_name() %></p>
				</div>
				<div>
					<ul>
						<li><a href="Mypage.jsp">마이페이지</a></li>
						<li><a href="WelPoint.jsp">복지포인트</a></li>
					</ul>
				</div>
			</div>
			
			<!-- 메인 콘텐츠 -->
			<div class="main-content">
				<table class="info-table">
					<tr>
						<th>이름</th>
						<td><input type="text" name="USER_NAME" value="<%= user.getUser_name() %>" /></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><input type="text" name="USER_GENDER" value="<%= user.getUser_gender() %>" /></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type="text" name="USER_BIRTHDATE" value="<%= user.getUser_birthdate() %>" /></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="USER_ID" value="<%= user.getUser_id() %>" disabled /></td>
					</tr>
					<tr>
						<th>비밀번호 수정</th>

						<td><input type="password" id="password" name="USER_PW" placeholder="새 비밀번호 입력" /></td>

						<td><input type="password" id="password" name="user_pw"
							placeholder="새 비밀번호 입력"></td>

					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="USER_PHONE" value="<%= user.getUser_phone() %>" placeholder="전화번호 ex)010-1234-5678" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="text" name="USER_EMAIL" value="<%= user.getUser_email() %>" placeholder="이메일 ex)example@domain.com" /></td>
					</tr>
					<tr>
						<th>관심분야</th>
						<td><input type="text" name="FAV_WELFARE" value="<%= user.getUser_fav_welfare() %>" placeholder="관심 분야 입력" /></td>
					</tr>
					<tr>
						<th>관심지역</th>
						<td><input type="text" name="FAV_REGION" value="<%= user.getUser_fav_region() %>" placeholder="관심 지역 입력" /></td>
					</tr>
				</table>

				<!-- 저장 버튼 -->
				<input type="submit" value="저장" />
			</div>
		</div>
	</form>

	<!-- 풋터 -->
	<%@ include file="Footer.jsp"%>

	<script>
	// 비밀번호 확인
	document.getElementById("confirmPassword").addEventListener("input", function() {
	    var password = document.getElementById("password").value;
	    var confirmPassword = this.value;
	    if (password !== confirmPassword) {
	      this.setCustomValidity("비밀번호가 일치하지 않습니다.");
	    } else {
	      this.setCustomValidity(""); // 일치하면 유효성 검사를 통과
	    }
	  });
	
	// 전화번호 형식 지정
	 document.getElementById("phone").addEventListener("input", function() {
		    var phone = this.value;
		    var formattedPhone = phone.replace(/[^0-9]/g, '').replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
		    this.value = formattedPhone;
		  });
	
	</script>
</body>
</html>

