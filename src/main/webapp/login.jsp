<%@ page contentType="text/html; charset=UTF-8"%>
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

.g-signin2-grid {
	display: flex;
	justify-content: center;
	gap: 25px;
	margin-top: 20px;
}

.g-signin2 {
	display: flex;
	flex-direction: column;
	align-items: center;
	cursor: pointer;
}

.g-signin2 img {
	width: 50px;
	height: 50px;
	border-radius: 10px;
	margin-bottom: 10px;
}

.g-signin2 span {
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
	<form name="loginCheck" action="LoginCon" method="post">
		<table>
			<tr>
				<td><h2>로그인</h2></td>
			</tr>
			<tr>
				<td><input type="text" required maxlength="15" placeholder="ID"
					id="id" name="USER_ID"></td>
			</tr>
			<tr>
				<td><input type="password" placeholder="PW" id="pw"
					name="USER_PW"></td>
			</tr>
			<tr>
				<td><input type="submit" value="로그인" class="loginBtn"></td>
			</tr>

			<tr>
				<td class="join"><a href="join.jsp">회원가입</a></td>
			</tr>
		</table>
	</form>
	<!-- 구글 로그인 버튼 -->
	<div class="g-signin2" data-onsuccess="onSignIn">구글로그인</div>
	
	<!-- 구글 로그인 SDK -->
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	
	<script>
	// 구글 로그인 SDK 로드 후 초기화
	 function initGoogleAuth() {
            // 'gapi' 객체가 로드된 후에 'gapi.auth2.init()'을 호출합니다.
            if (gapi && gapi.auth2) {
                gapi.auth2.init({
                    client_id: '552140088937-4e7nhjd7bhmbhgs46cl4ig4ncc9jlkhv.apps.googleusercontent.com'  // 클라이언트 ID
                }).then(function() {
                    console.log('Google SDK Initialized');
                }).catch(function(error) {
                    console.error('Google SDK initialization failed:', error);
                });
            } else {
                console.error('gapi or gapi.auth2 is not available');
            }
        }
	
	// 구글 로그인 SDK 로드 후 초기화 실행
     function onGapiLoad() {
         gapi.load('auth2', initGoogleAuth); // gapi.auth2를 로드 후 initGoogleAuth 호출
     }
	
 // 구글 로그인 성공 후 호출되는 함수
    function onSignIn(googleUser) {
        var profile = googleUser.getBasicProfile();
        console.log('로그인된 사용자 이름:', profile.getName());
        console.log('로그인된 사용자 ID:', profile.getId());

        // id_token을 서버로 보내서 인증을 받거나, 세션을 관리할 수 있습니다.
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token:", id_token);
        
     	// 서버로 id_token을 보내서 인증
		// 예시로, AJAX를 사용하여 서버에 보내는 방법을 사용할 수 있습니다.
		// 아래는 AJAX로 서버로 id_token을 보내는 예시 코드입니다.
		fetch("/your-server-endpoint", {
			method: "POST",
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify({ id_token: id_token })
		})
		.then(response => response.json())
		.then(data => {
			console.log("서버에서 응답받은 데이터:", data);
			// 서버에서 인증이 완료되면 필요한 처리를 할 수 있습니다.
		})
		.catch(error => {
			console.error("서버 요청 실패:", error);
		});
	}

		
	/* 로그인 실패시 알림창 띄우기!!! */
		<%
			String errorMessage = (String) request.getAttribute("errorMessage");
			if (errorMessage != null) {
		%>
			<script>
		      alert("<%=errorMessage%>");
		  	</script>
		<%
			}
		%>
	</script>





</body>
</html>