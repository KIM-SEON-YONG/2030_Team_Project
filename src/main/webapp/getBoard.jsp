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
}

/* 버튼 스타일 */
.btn-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.btn-pink {
	background-color: #9d4edd;
	color: #ffffff;
	font-size: 16px;
	padding: 10px 20px;
	border: none;
	border-radius: 30px;
	font-weight: bold;
	cursor: pointer;
}

.btn-pink:hover {
	background-color: #6a1b9a;
}

.btn-danger {
	background-color: #dc3545;
	color: #ffffff;
	font-size: 16px;
	padding: 10px 20px;
	border: none;
	border-radius: 30px;
	font-weight: bold;
	cursor: pointer;
}

.btn-danger:hover {
	background-color: #c82333;
}

.btn-secondary {
	background-color: #6c757d;
	color: #ffffff;
	font-size: 16px;
	padding: 10px 20px;
	border: none;
	border-radius: 30px;
	font-weight: bold;
	cursor: pointer;
}

.btn-secondary:hover {
	background-color: #495057;
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
		<form id="write-form">
		<!-- 게시글 내용 -->
		<div class="post-content">
			<p id="post-content"><%=(post != null) ? post.getB_content() : "해당 게시글은 존재하지 않습니다."%></p>
		</div>

		<!-- 수정 및 삭제 버튼 -->
		<%
		if (post != null) {
		%>
		<div class="btn-group mb-3">
			<button class="btn btn-pink" id="edit-post">수정</button>
			<button class="btn btn-danger" id="delete-post">삭제</button>
		</div>
		<%
		}
		%>

		<!-- 목록으로 버튼 -->
		<div class="btn-group mb-3">
			<button class="btn btn-secondary"
				onclick="location.href='boardList.jsp'">목록으로</button>
		</div>
		</form>
	</div>

	<script>
        document.addEventListener("DOMContentLoaded", function () {
            <%if (post != null) {%>
                // 수정 버튼 클릭 이벤트
                document.getElementById("edit-post").addEventListener("click", function () {
                    alert("게시글 수정 기능은 아직 구현되지 않았습니다.");
                });

                // 삭제 버튼 클릭 이벤트
                document.getElementById("delete-post").addEventListener("click", function () {
                    if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
                        window.location.href = "deleteBoard.jsp?b_idx=<%=post.getB_idx()%>
		";
												}
											});
	<%}%>
		});
	</script>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
