<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 400px;
	margin: 50px auto;
	text-align: center;
	padding: 20px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.title {
	font-size: 1.5em;
	margin-bottom: 20px;
}

table {
	width: 280px;
	margin: auto;
	font-size: 15px;
}

input[type="text"], input[type="password"] {
	width: 250px;
	height: 32px;
	font-size: 15px;
	border: 0;
	border-radius: 15px;
	outline: none;
	padding-left: 10px;
	background-color: rgb(233, 233, 233);
}

.btn {
	width: 263px;
	height: 32px;
	font-size: 15px;
	border: 0;
	border-radius: 15px;
	outline: none;
	padding-left: 10px;
	background-color: rgb(164, 199, 255);
}

.btn:active {
	background-color: rgb(61, 135, 255);
}

.icons-grid {
	display: flex;
	justify-content: center;
	gap: 25px;
	margin-top: 20px;
}

.icon {
	display: flex;
	flex-direction: column;
	align-items: center;
	cursor: pointer;
}

.icon img {
	width: 50px;
	height: 50px;
	border-radius: 10px;
	margin-bottom: 10px;
}

.icon span {
	font-size: 0.9em;
	color: #333;
}

a {
	font-size: 12px;
	color: darkgray;
	text-decoration-line: none;
}

.join {
	text-align: center;
}
</style>
<body>
	<%@ page contentType="text/html; charset=UTF-8"%>
	<form name="login" action="LoginCon" method="post">
		<table>
			<tr>
				<td><h2>로그인</h2></td>
			</tr>
			<tr>
				<td><input type="text" required maxlength="15" placeholder="ID" id="id" name="USER_ID" ></td>
			</tr>
			<tr>
				<td><input type="password" placeholder="PW" id="pw" name="USER_PW"></td>
			</tr>

			<tr>
				<td><input type="checkbox"> 로그인 정보 저장</td>
			</tr>
			<tr>
				<td><input type="submit" value="로그인" class="loginBtn"></td>
			</tr>
			<tr>
				<td class="join"><a href="join.jsp">회원가입</a></td>
			</tr>
		</table>
	</form>

	<!-- 카카오톡 -->
	<div class="icons-grid">
		<a href="https://accounts.kakao.com/" target="_blank">
			<div class="icon">
				<img
					src="https://test.codemshop.com/wp-content/plugins/mshop-mcommerce-premium-s2/lib/mshop-members-s2/assets/images/social/icon_1/Kakao.png"
					alt="카카오톡"> <span>카카오톡</span>
			</div>
		</a>

		<!-- 구글 -->
		<a href="https://accounts.google.com/signin" target="_blank">
			<div class="icon">
				<img
					src="https://test.codemshop.com/wp-content/plugins/mshop-mcommerce-premium-s2/lib/mshop-members-s2/assets/images/social/logo/Google.png"
					alt="구글"> <span>구글</span>
			</div>
		</a>

		<!-- 네이버 -->
		<a href="https://nid.naver.com/nidlogin.login" target="_blank">
			<div class="icon">
				<img
					src="https://test.codemshop.com/wp-content/plugins/mshop-mcommerce-premium-s2/lib/mshop-members-s2/assets/images/social/icon_1/Naver.png"
					alt="네이버"> <span>네이버</span>
			</div>
		</a>
	</div>
	<script>

		function login() {
			let id = document.querySelector('#id');
			let pw = document.querySelector('#pw');
			
			if(id.value == "" || pw.value == ""){
				alert("로그인을 할 수 없습니다.")
			}else{
				location.href = 'Main.html';
			}
		}
		
		
		


	
	
	
	
	</script>





</body>
</html>