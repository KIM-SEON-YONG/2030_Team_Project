<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="common.css">
<style>
.container {
	justify-items: center;
	align-content: center;
	height: 428px;
	width: 220px;
}
h2{
	text-align: center;
}
input {
  display: block;
  
}

/* 모달 스타일 중앙 정렬 */
.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: flex;
	align-items: center;
	justify-content: center;
}

.modal-content {
	background: white;
	padding: 20px;
	border-radius: 10px;
	text-align: center;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	width: 300px;
}

#close-modal {
	margin-top: 10px;
	padding: 10px 20px;
	border: none;
	background-color: #4a90e2;
	color: white;
	border-radius: 5px;
	cursor: pointer;
}

#close-modal:hover {
	background-color: #357ab7;
}

#find-id-button {
	width: 100%;
	padding: 10px;
	background-color: #4a90e2;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}
</style>
</head>
<body>
	<!-- 해더  -->
	<%@ include file="Header.jsp"%>

	<!-- 메인 컨텐츠 -->
	<section class="container">
			<div class="signup-box">
				<h2>아이디 찾기</h2><br>
				<form id="find-id-form" action="FindIdCon" method="POST">
					<div class="form-group">
						<input type="text" id="name" name="name" required placeholder="이름 입력">
						<br>
						<input type="tel" id="phone" name="phone" required placeholder="전화번호 입력">
						<br>
					</div>
					<button type="submit" id="find-id-button">아이디 찾기</button>
					<p id="find-id-message" class="message"></p>
				</form>
			</div>
	</section>
	<!-- 모달 창 -->
	<%
	String foundEmail = (String) request.getAttribute("foundEmail");
	%>
	<%
	if (foundEmail != null) {
	%>
	<div id="id-modal" class="modal" style="display: flex;">
		<div class="modal-content">
			<h2>아이디 찾기 결과</h2>
			<p id="found-email"><%=foundEmail%></p>
			<button id="close-modal">확인</button>
		</div>
	</div>
	<%
	}
	%>
	<!-- 풋터 -->
	<%@ include file="Footer.jsp"%>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const closeModal = document.getElementById("close-modal");
			if (closeModal) {
				closeModal.addEventListener("click", function() {
					window.location.href = "login.jsp";
				});
			}
		});
	</script>

</body>
</html>