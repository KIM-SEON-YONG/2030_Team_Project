<%@page import="com.TTteamProject.model.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.TTteamProject.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<style>
/* 전체 배경 스타일 */
body {
	background-color: #f7f4fc;
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
}

/* 게시판 컨테이너 */
.container {
	background-color: #ffffff;
	border-radius: 15px;
	padding: 40px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
	margin: 50px auto;
	width: 90%;
	max-width: 1200px;
}

/* 헤더 스타일 */
.header {
	background-color: #e9d5f8;
	border-radius: 15px;
	padding: 20px 30px;
	text-align: center;
	margin-bottom: 30px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.header h1 {

	color: #5a189a;
	font-size: 28px;
	font-weight: bold;
	margin: 0;
}

.header p {
	color: #6d6875;
	font-size: 16px;
	margin: 10px 0 0;
}

/* 검색창 스타일 */
.search-bar input {
	width: 100%;
	padding: 15px;
	border: 2px solid #b4aee8;
	border-radius: 30px;
	font-size: 16px;
	color: #5a189a;
	margin-bottom: 30px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.search-bar input:focus {
	outline: none;
	border-color: #9d4edd;
	box-shadow: 0 4px 12px rgba(157, 78, 221, 0.3);
}

/* 게시판 테이블 */
.table {
	width: 100%;
	background-color: #ffffff;
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
}

.table thead {
	background-color: #d8b4e2;
	color: #ffffff;
	font-weight: bold;
	font-size: 16px;
	text-align: center;
}

.table tbody tr {
	text-align: center;
	font-size: 15px;
	color: #5a189a;
	border-bottom: 1px solid #f1e8ff;
}

.table tbody tr:hover {
	background-color: #f3e8fc;
}

/* 글쓰기 버튼 */
.btn-pink {
	background-color: #9d4edd;
	color: #ffffff;
	font-size: 16px;
	padding: 12px 30px;
	border: none;
	border-radius: 30px;
	font-weight: bold;
	transition: all 0.3s ease;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	cursor: pointer;
}

.btn-pink:hover {
	background-color: #6a1b9a;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

/* 페이지네이션 */
.pagination .page-link {
	color: #9d4edd;
	border: 1px solid #9d4edd;
	border-radius: 50%;
	font-size: 12px;
	width: 60px;
	height: 45px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 4px;
	transition: all 0.3s ease;
}

.pagination .page-link:hover {
	background-color: #9d4edd;
	color: #ffffff;
}

.pagination .active .page-link {
	background-color: #5a189a;
	color: #ffffff;
	border-color: #5a189a;
}

/* 카테고리 배지 스타일 */
.category-badge {
	background-color: #6a1b9a;
	color: white;
	padding: 5px 10px;
	border-radius: 20px;
	font-size: 14px;
}
</style>
</head>

<body>
	<%
	BoardDAO dao = new BoardDAO();
	List<BoardDTO> boardList = dao.boardList();
	%>
<div id="header"></div>
	<div class="container">
		<!-- 상단 제목 -->
		<div class="header">
			<h1>게시판</h1>
			<p>커뮤니티를 위한 공간</p>
		</div>

		<!-- 검색창 -->
		<div class="search-bar">
			<input type="text" id="search-input" placeholder="검색어를 입력하세요..." />
		</div>

		<!-- 게시판 테이블 -->
		<table class="table">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">카테고리</th>
					<!-- 카테고리 열 -->
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
				</tr>
			</thead>
			<tbody id="postList">
				<!-- 게시글 항목 -->
				<%
				for (BoardDTO board : boardList) {
				%>
				<tr onclick="location.href='getBoard.jsp?b_idx=<%= board.getB_idx() %>';">
					<td><%= board.getB_idx() %></td>
					<td><%= board.getB_category() %></td>
					<td><%= board.getB_title() %></td>
					<td><%= board.getUserId() %></td>
					<td><%= board.getCreate_dt() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
		<script>
			document.addEventListener("DOMContentLoaded", function() {
    		let rows = document.querySelectorAll(".clickable-row");
   			 rows.forEach(row => {
       		 row.addEventListener("click", function() {
           	 let url = this.getAttribute("data-href");
            	if (url) {
                window.location.href = url;
	           	 }
	        });
	    });
	});
</script>

		<!-- 페이지 네비게이션 -->
		<nav class="d-flex justify-content-center">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#">이전</a></li>
				<li class="page-item active"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">다음</a></li>

			</ul>
		</nav>

		<!-- 글쓰기 버튼 -->
		<div class="text-end mt-3">
			<button class="btn btn-pink"
				onclick="location.href='board-write.html'">글쓰기</button>
		</div>
	</div>
	<div id="footer"></div>
	<script>
		
	/* 해더 및 풋터 */
      // Header.jsp 파일을 #header div에 로드
       fetch('Header.jsp')
         .then(response => response.text())
         .then(data => {
           document.getElementById('header').innerHTML = data;
         })
         .catch(error => console.error('Error loading header:', error));
   
       // Footer.jsp 파일을 #footer div에 로드
       fetch('Footer.jsp')
         .then(response => response.text())
         .then(data => {
           document.getElementById('footer').innerHTML = data;
         })
         .catch(error => console.error('Error loading footer:', error));

	
	
		// 로컬 스토리지에서 게시글 불러오기
		document.addEventListener("DOMContentLoaded", function () {
			const posts = JSON.parse(localStorage.getItem("posts")) || [];
			const postList = document.getElementById("postList");

			// 게시글 데이터를 테이블에 추가
			posts.forEach((post, index) => {
				const row = document.createElement("tr");

				// 카테고리 표시 부분
				const categoryBadges = post.categories ? post.categories.split(", ").map(category =>
					`<span class="category-badge">${category}</span>`).join(" ") : "";

				// 각 td 태그에 클릭 이벤트 추가
				row.innerHTML = `
            <td onclick="viewPost(${index})">${index + 1}</td>
            <td>${categoryBadges}</td> <!-- 카테고리 배지 표시 -->
            <td onclick="viewPost(${index})">${post.title}</td>
            <td onclick="viewPost(${index})">${post.author}</td>
            <td onclick="viewPost(${index})">${post.date}</td>
          `;
				postList.appendChild(row);
			});
		});

		// 게시글 상세보기로 이동하는 함수
		function viewPost(index) {
			// 게시글의 인덱스를 URL에 추가하여 상세 페이지로 이동
			window.location.href = `board-post.html?index=${index}`;
		}
	</script>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
		
</body>

</html>