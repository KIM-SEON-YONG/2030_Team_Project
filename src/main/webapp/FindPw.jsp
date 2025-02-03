<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="common.css">
<link rel="stylesheet" href="signup.css">
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
#find-password-button {
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
	<div class="container">
		<div class="signup-box">
			<h2>비밀번호 찾기</h2>
			<br>
			<form id="find-password-form" action="FindPwCon" method="POST">
				<div class="form-group">
					<input type="email" id="email" name="email" required placeholder="이메일 입력">
					<br>
				</div>
				<button type="submit" id="find-password-button">비밀번호 찾기</button>
				<p id="find-password-message" class="message"></p>
			</form>
		</div>
	</div>

	<!-- 모달 창 -->
	<%
	String foundPassword = (String) request.getAttribute("foundPassword");
	%>
	<%
	if (foundPassword != null) {
	%>
	<div id="password-modal" class="modal" style="display: flex;">
		<div class="modal-content">
			<h2>비밀번호 찾기 결과</h2>
			<p id="found-password">
				비밀번호:
				<%=foundPassword%></p>
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
