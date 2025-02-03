<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link rel="stylesheet" href="assets/css/chatting.css"> <!-- 챗봇 css -->
<title>Insert title here</title>
</head>
<style>
body {
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* 화면의 최소 높이를 100vh로 설정 */
}

/* footer를 제일 하단으로 내리기 위해 콘텐츠를 감싸고 있는 div에 설정 */
.main-content, .container  {
    flex-grow: 1; /* 본문 콘텐츠가 남는 공간을 채우도록 설정 */
}


footer {
	position: relative; /* 페이지 하단에 고정 */
    background-color: #D3D3D3;
    color: black;
    height: 150px; /* 푸터 높이 설정 */
    width: 100%; /* 푸터 너비 100% 설정 */
    display: flex;
    justify-content: center;
    align-items: center;
    bottom: 0; /* 항상 하단에 고정 */
}

.footer-content {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-align: center;
	height: 100%;
}

.footer-content h3 {
	font-size: 2rem;
	text-transform: capitalize;
	line-height: 2rem;
	margin: 0;
}

.footer-content p {
	font-size: 14px;
	color: black;
	margin: 10px 0;
}

/* SNS 링크 스타일 */
.socials {
	list-style: none;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 10px 0;
	
}
.social-icon{
	width: 25px;
	height: 25px;
}
.socials li {
    margin-right: 30px;  /* 오른쪽에 15px 여백을 추가 */
}


</style>
</head>
<body>
	<!-- 챗봇 아이콘 -->
    <div id="chatbot-icon" onclick="toggleChat()"></div>

    <!-- 챗봇 대화창 -->
    <div class="chat-container" id="chat-container">
        <div class="chat-header">💬 SPARK 챗봇</div>
        <div class="chat-box" id="chat-box">
            <div class="bot-message chat-message">안녕하세요. SPARK 챗봇입니다. 어떤 복지 정책이 궁금하신가요?</div>
        </div>
        <div class="chat-input">
            <input type="text" id="userMessage" placeholder="메시지를 입력하세요..." onkeypress="handleKeyPress(event)">
            <button onclick="sendMessage()">전송</button>
        </div>
    </div>
    
    <!-- footer 영역 -->
	<footer>
		<div class="footer-content">
			<h3>S.P.A.R.K</h3>
			<p>Support.Prepare.Achieve.Reach.Keep.</p>

			<ul class="socials">
				<li>Tel:000-000-0000</li>
				<li class="email">Email:skapk@smhrd.kr</li>
	            <li>
	                <a href="https://www.facebook.com/profile.php?id=61572616747676">
	                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png" alt="Facebook" class="social-icon">
	                </a>
	            </li>
	            <li>
	                <a href="https://x.com/team_2030_">
	                    <img src="https://cdn2.iconfinder.com/data/icons/threads-by-instagram/24/x-logo-twitter-new-brand-512.png" alt="Twitter" class="social-icon"> 
	                </a>
	            </li>
	            <li>
	                <a href="https://www.instagram.com/team_2030_/?hl=ko">
	                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2048px-Instagram_logo_2016.svg.png" alt="Instagram" class="social-icon"> 
	                </a>
	            </li><br>
			<p>S.P.A.R.K &copy;2025</p>
			</ul>
		</div>
	</footer>
	<script src="assets/js/chatting.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
		rel="stylesheet">
		
	</script>
</body>
</html>