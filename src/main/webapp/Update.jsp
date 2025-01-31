<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 페이지</title>
<style type="text/css">

/* 공통 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
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
	height: 96vh; /* 화면 전체 높이 */
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
	margin-top: 10px; /* 위쪽 여백 */
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

.logout-btn {
	background-color: #d1d1ff; /* 로그아웃 버튼 배경색 */
	color: white; /* 버튼 글자색 */
	border: none; /* 테두리 제거 */
	padding: 10px 20px; /* 내부 여백 */
	border-radius: 30px; /* 모서리 둥글게 */
	cursor: pointer; /* 커서가 포인터로 변경 */
	font-size: 13px; /* 폰트 크기 */
	margin-top: 478px; /* 위쪽 여백 */
	transition: background-color 0.3s; /* 배경색 변화에 애니메이션 효과 추가 */
}

.logout-btn:hover {
	background-color: #e03e50; /* 호버 시 배경색 변화 */
}

/* 메인 콘텐츠 */
.main-content {
	flex-grow: 1; /* 남은 공간을 채우기 */
	padding: 20px; /* 내부 여백 */
	background-color: #f9f9f9; /* 배경색 설정 */
}

/* 정보 테이블 스타일 */
.info-table {
	width: 100%; /* 테이블 너비를 100%로 설정 */
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
/* 전원 메뉴 버튼 및 스타일 */
.power-button {
	font-size: 24px;
	padding: 10px 20px;
	cursor: pointer;
	border: none;
	background-color: #e000;
	border-radius: 10px;
	position: fixed;
	top: 903px;
	right: 1654px;
}

.menu-popup {
	display: none;
	position: absolute;
	top: 830px;
	right: 1563px;
	background: white;
	border: 1px solid #ccc;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
	padding: 10px;
	border-radius: 5px;
}

.menu-popup div {
	padding: 10px;
	cursor: pointer;
}

.menu-popup div:hover {
	background: #f0f0f0;
	element
	.style{
	width
	:
	20%
}
}
</style>
</head>

<body>
	<div class="container">
		<!-- 메뉴 -->
		<div class="menu">
			<div class="profile-container">
				<!-- 프로필 이미지 -->
				<img id="profile-img" class="profile-img"
					src="https://goodpokki.kr/common/img/default_profile.png"
					alt="프로필 이미지">
				<p class="nickname">사용자 닉네임</p>
			</div>

			<!-- 메뉴 항목들 -->
			<ul>
				<li><a href="#">복지포인트</a></li>
			</ul>
			<ul>
				<li><a href="MbrInfo.jsp">회원정보</a></li>
			</ul>

		</div>
		<!-- 메인 콘텐츠 -->
		<div class="main-content">
			<!-- 로그인 정보 가지고 오기!! -->
			<%
			    String user_id = request.getParameter("user_id");
			    String user_pw = request.getParameter("user_pw");
			    String user_name = request.getParameter("user_name");
			    String user_birthdate = request.getParameter("user_birthdate");
			    String user_gender = request.getParameter("user_gender");
			    String user_phone = request.getParameter("user_phone");
			    String fav_welfare = request.getParameter("fav_welfare");
			    String fav_region = request.getParameter("fav_region");
			%>
			<form>
				<table class="info-table">
					<!-- 사용자 정보 테이블 -->
					<tr>
						<th>이름</th>
						<td></td>
					</tr>
					<tr>
						<th>성별</th>
						<td></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td></td>
					</tr>
					<tr>
						<th>비밀번호 수정</th>
						<td><input type="password" id="password" placeholder="새 비밀번호 입력"></td>
					</tr>
					<tr>
						<th>비밀번호 재확인</th>
						<td><input type="password" id="confirmPassword"	placeholder="비밀번호 확인"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td></td>
					</tr>
					<tr>
						<th>관심분야</th>
						<td><input type="text" id="interest" placeholder="관심 분야 입력">
						</td>
					</tr>
					<tr>
						<th>관심지역</th>
						<td><input type="text" id="region" placeholder="관심 지역 입력">
						</td>
					</tr>
				</table>
				<!-- 저장 버튼 -->
				<div style="margin-top: 20px;">
					<input type="submit" value="저장">
				</div>


			</form>
			</table>
		</div>
	</div>

	<!-- 전원 메뉴 버튼 -->
	<button class="power-button" onclick="toggleMenu()">⏻</button>
	<div class="menu-popup" id="powerMenu">

		<div onclick="selectOption('회원 탈퇴')">회원 탈퇴</div>
		<div onclick="selectOption('로그아웃')">로그아웃</div>
	</div>

	<script>
		// 전원 메뉴 토글
		function toggleMenu() {
			var menu = document.getElementById("powerMenu");
			menu.style.display = menu.style.display === "block" ? "none"
					: "block";
		}

		// 전원 메뉴 선택
		function selectOption(option) {
			if (option === '회원 탈퇴') {
				if (confirm("정말 회원 탈퇴를 진행하시겠습니까?")) {
					alert("회원 탈퇴가 완료되었습니다.");
					window.location.href = '/delete-account';
				}
			} else if (option === '로그아웃') {
				alert("로그아웃 되었습니다.");
				window.location.href = '/logout';
				document.getElementById("powerMenu").style.display = "none";

			}
		}
		// 화면 클릭 시 메뉴 닫기
		document.addEventListener("click", function(event) {
			var menu = document.getElementById("powerMenu");
			var button = document.querySelector(".power-button");
			if (event.target !== menu && event.target !== button) {
				menu.style.display = "none";
			}
		});
	</script>