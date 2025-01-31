<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 페이지</title>
<style type="text/css">
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
	background-color: #f24c59; /* 로그아웃 버튼 배경색 */
	color: white; /* 버튼 글자색 */
	border: none; /* 테두리 제거 */
	padding: 10px 20px; /* 내부 여백 */
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer; /* 커서가 포인터로 변경 */
	font-size: 16px; /* 폰트 크기 */
	margin-top: 20px; /* 위쪽 여백 */
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
				<!-- 사용자 닉네임 -->
			</div>
			<ul>
				<!-- 메뉴 항목들 -->
				<li><a href="Update.jsp">회원정보수정</a></li>
				<li><a href="WelPoint.jsp">복지포인트</a></li>
			</ul>
			<!-- 로그아웃 버튼 -->
			<button class="logout-btn" onclick="logout()">로그아웃</button>
		</div>

		<!-- 메인 콘텐츠 -->
		<div class="main-content">
			<h2>----님 마이페이지</h2>
			<table class="info-table">
				<!-- 사용자 정보 테이블 -->
				<tr>
					<th>보유포인트</th>
					<td>711점</td>
					<th>내가쓴글</th>
					<td>3 (원글: 2, 코멘트: 1)</td>
				</tr>
				<tr>
					<th>최종접속일시</th>
					<td>2016-01-25 15:42:23</td>
					<th>회원가입일시</th>
					<td>2016-01-11 13:52:33</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>미등록</td>
				</tr>
			</table>
			<!-- 게시글 목록 테이블 -->
			<table class="info-table">
				<thead>
					<tr>
						<h3>내가 작성한 게시판 글 확인하기</h3>
						<th><input type="checkbox"></th>
						<!-- 체크박스 -->
						<th>분야</th>
						<th>제목</th>
						<th>작성일시</th>
					</tr>
				</thead>
				<tbody>
					<!-- 게시글 항목들 -->
					<tr>
						<td><input type="checkbox"></td>
						<td>취업</td>
						<td>취업복지에관해서..</td>
						<td></td>
					</tr>
					<tr>
						<td><input type="checkbox"></td>
						<td>결혼</td>
						<td>결혼복지 추천!!</td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>



	<script>
		
	</script>
</body>
</html>