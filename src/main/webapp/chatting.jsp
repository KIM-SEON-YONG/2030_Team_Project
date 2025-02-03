<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI 챗봇</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: #f4f7f9;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.chat-container {
	width: 400px;
	background: white;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	overflow: hidden;
}

.chat-header {
	background: #4CAF50;
	color: white;
	padding: 15px;
	text-align: center;
	font-size: 18px;
	font-weight: bold;
}

.chat-box {
	padding: 15px;
	height: 350px;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
}

.chat-message {
	margin: 5px 0;
	padding: 10px;
	border-radius: 5px;
	max-width: 80%;
}

.user-message {
	background: #DCF8C6;
	align-self: flex-end;
}

.bot-message {
	background: #EAEAEA;
	align-self: flex-start;
}

.chat-input {
	display: flex;
	padding: 10px;
	border-top: 1px solid #ddd;
	background: #fff;
}

.chat-input input {
	flex: 1;
	padding: 10px;
	border: none;
	border-radius: 5px;
	font-size: 16px;
}

.chat-input button {
	margin-left: 10px;
	background: #4CAF50;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 5px;
	cursor: pointer;
}

.chat-input button:hover {
	background: #45A049;
}
</style>
</head>
<body>
	<h2>Python 챗봇과 대화하기</h2>
	<form action="ChatbotCon" method="post">
		<input type="text" name="userMessage" placeholder="질문을 입력하세요" required>
		<button type="submit">전송</button>
	</form>
	
	<div>
		<p><strong>사용자: </strong><%= request.getAttribute("userMessage") != null? request.getAttribute("userMessage"): "" %></p>
		<p><strong>챗봇: </strong><%= request.getAttribute("chatbotReply") != null? request.getAttribute("chatbotReply"): "챗봇 응답 없음" %></p>
	</div>
	<div class="chat-container">
		<div class="chat-header">💬 AI 챗봇</div>
		<div class="chat-box" id="chat-box">
			<div class="bot-message chat-message">안녕하세요! 무엇을 도와드릴까요?</div>
		</div>
		<div class="chat-input">
			<input type="text" id="userMessage" placeholder="메시지를 입력하세요..."
				onkeypress="handleKeyPress(event)">
			<button onclick="sendMessage()">전송</button>
		</div>
	</div>

	<script>
		function sendMessage() {
			var userMessage = document.getElementById("userMessage").value
					.trim();
			if (userMessage === "")
				return;

			// 사용자 메시지를 채팅창에 추가
			var chatBox = document.getElementById("chat-box");
			var userMsgElement = document.createElement("div");
			userMsgElement.classList.add("chat-message", "user-message");
			userMsgElement.innerText = userMessage;
			chatBox.appendChild(userMsgElement);

			// AJAX 요청 (Servlet과 Flask 챗봇 API 연결)
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "ChatbotCon", true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState === XMLHttpRequest.DONE) {
					if (xhr.status === 200) {
						try {
							var response = JSON.parse(xhr.responseText);
							var botMessage = document.createElement("div");
							botMessage.classList.add("chat-message",
									"bot-message");
							botMessage.innerText = response.answer;
							chatBox.appendChild(botMessage);

							// 채팅창 스크롤 자동 이동
							chatBox.scrollTop = chatBox.scrollHeight;
						} catch (error) {
							console.error("JSON 파싱 오류: ", error);
							alert("챗봇 응답을 불러오는 중 오류 발생!");
						}
					} else {
						console.error("서버 응답 오류: " + xhr.status);
						alert("서버에서 오류가 발생했습니다!");
					}
				}
			};
			xhr.send("userMessage=" + encodeURIComponent(userMessage));

			// 입력 필드 초기화
			document.getElementById("userMessage").value = "";
		}

		function handleKeyPress(event) {
			if (event.key === "Enter") {
				sendMessage();
			}
		}
	</script>

</body>
</html> --%>