<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.TTteamProject.model.BoardDAO, com.TTteamProject.model.BoardDTO"%>
<%
request.setCharacterEncoding("UTF-8");
// 클라이언트에서 'b_idx' 파라미터 가져오기
String b_idxParam = request.getParameter("b_idx");
int b_idx = 0;
if (b_idxParam != null) {
	try {
		b_idx = Integer.parseInt(b_idxParam);
	} catch (NumberFormatException e) {
		out.println("<h3 style='color:red;'>잘못된 게시글 번호 형식입니다.</h3>");
		return;
	}
}
// DB에서 게시글 조회
BoardDAO dao = new BoardDAO();
BoardDTO post = dao.getBoard(b_idx);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>게시글 보기</title>
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

/* 게시글 내용 */
.post-content {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
	font-size: 16px;
	line-height: 1.6;
	color: #333;
}

/* 버튼 스타일 */
.btn-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-bottom: 20px;
}

/* 댓글 입력 스타일 */
.comment-box {
	margin-top: 20px;
	padding: 15px;
	background: #f8f9fa;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	animation: fadeIn 0.5s ease-in-out;
}

.comment-box textarea {
	width: 100%;
	height: 80px;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #ddd;
	resize: none;
	font-size: 14px;
}

.comment-box button {
	margin-top: 10px;
	display: block;
	width: 100%;
	background-color: #9d4edd;
	color: white;
	border: none;
	padding: 10px;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
	transition: 0.3s ease-in-out;
}

.comment-box button:hover {
	background-color: #6a1b9a;
}

/* 댓글 목록 */
.comment-list {
	margin-top: 20px;
}

.comment {
	background: white;
	border-radius: 10px;
	padding: 10px;
	margin-bottom: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	animation: fadeIn 0.5s ease-in-out;
}

/* 애니메이션 효과 */
@keyframes fadeIn {
	from { opacity: 0; transform: translateY(-10px); }
	to { opacity: 1; transform: translateY(0); }
}

/* 입력 오류 시 흔들리는 애니메이션 */
@keyframes shake {
	0% { transform: translateX(0); }
	25% { transform: translateX(-5px); }
	50% { transform: translateX(5px); }
	75% { transform: translateX(-5px); }
	100% { transform: translateX(0); }
}

.shake {
	animation: shake 0.3s ease-in-out;
}
</style>
</head>
<body>
	<div class="container">
		<!-- 상단 제목 -->
		<div class="header">
			<h1 id="post-title"><%=(post != null) ? post.getB_title() : "게시글을 찾을 수 없습니다."%></h1>
			<p id="post-meta"><%=(post != null) ? post.getUserId() + " | " + post.getCreate_dt() : ""%></p>
		</div>

		<!-- 게시글 내용 -->
		<div class="post-content">
			<p id="post-content"><%=(post != null) ? post.getB_content() : "해당 게시글은 존재하지 않습니다."%></p>
		</div>

		<!-- 댓글 입력 -->
		<div class="comment-box">
			<textarea id="comment-input" placeholder="댓글을 입력하세요..."></textarea>
			<button id="add-comment">댓글 작성</button>
		</div>

		<!-- 댓글 목록 -->
		<div class="comment-list" id="comment-list"></div>

	</div>

	<script>
	document.addEventListener("DOMContentLoaded", function () {
		const commentInput = document.getElementById("comment-input");
		const commentList = document.getElementById("comment-list");

		// 저장된 댓글 불러오기
		let comments = JSON.parse(localStorage.getItem("comments")) || [];

		// 댓글 화면에 표시
		function renderComments() {
			commentList.innerHTML = "";
			comments.forEach((comment, index) => {
				const commentDiv = document.createElement("div");
				commentDiv.classList.add("comment");
				commentDiv.innerHTML = `
					<p>${comment}</p>
					<button onclick="deleteComment(${index})" style="color: red; font-size: 12px; border: none; background: none; cursor: pointer;">삭제</button>
				`;
				commentList.appendChild(commentDiv);
			});
		}

		// 댓글 추가
		document.getElementById("add-comment").addEventListener("click", function () {
			const commentText = commentInput.value.trim();
			if (commentText === "") {
				commentInput.classList.add("shake");
				setTimeout(() => commentInput.classList.remove("shake"), 300);
				return;
			}

			comments.push(commentText);
			localStorage.setItem("comments", JSON.stringify(comments));
			renderComments();
			commentInput.value = "";
		});

		// 댓글 삭제
		window.deleteComment = function(index) {
			comments.splice(index, 1);
			localStorage.setItem("comments", JSON.stringify(comments));
			renderComments();
		};

		renderComments();
	});
	</script>
</body>
</html>
