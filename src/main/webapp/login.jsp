<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    body {
        font-family: 'Noto Sans KR', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: #333;
    }
    .container {
        text-align: center;
        background: #ffffff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        max-width: 400px;
        width: 100%;
    }
    h2 {
        color: #444;
        margin-bottom: 20px;
    }
    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 16px;
    }
    .login-btns {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-top: 20px;
    }
    .login-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 12px;
        width: 100%;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
        transition: all 0.3s ease;
        font-size: 16px;
    }
    .login-btn img {
        width: 24px;
        margin-right: 10px;
    }
    .google-btn {
        background: #ffffff;
        border: 1px solid #ccc;
        color: #333;
    }
    .google-btn:hover {
        background: #f0f0f0;
    }
    .kakao-btn {
        background: #fee500;
        border: none;
        color: #3c1e1e;
    }
    .naver-btn {
        background: #03c75a;
        color: white;
        border: none;
    }
    .naver-btn:hover {
        background: #029c49;
    }
    .submit-btn {
        background: #667eea;
        color: white;
        padding: 12px;
        border: none;
        width: 100%;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 10px;
    }
    .submit-btn:hover {
        background: #5661c5;
    }
    .logout-btn {
        background: #ff4b5c;
        color: white;
        padding: 12px;
        border: none;
        width: 100%;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 10px;
    }
    .logout-btn:hover {
        background: #d93d4c;
    }
    a {
        display: block;
        margin-top: 15px;
        color: #666;
        text-decoration: none;
        font-size: 14px;
    }
    a:hover {
        color: #444;
    }
</style>
</head>
<body>

<% if (userName != null) { %>
    <div class="container">
        <h2>환영합니다, <%= userName %>님!</h2>
        <p>이메일: <%= userEmail %></p>
        <button class="logout-btn" onclick="logout()">로그아웃</button>
    </div>
    <script>
        function logout() {
            fetch("LogoutServlet", { method: "POST" })
            .then(() => {
                window.location.href = "login.jsp";
            });
        }
    </script>
<% } else { %>
    <div class="container">
        <h2>로그인</h2>
        <form name="loginCheck" action="LoginCon" method="post">
            <input type="text" required maxlength="15" placeholder="ID" name="USER_ID">
            <input type="password" placeholder="PW" name="USER_PW">
            <input type="submit" value="로그인" class="submit-btn">
        </form>
        <div class="login-btns">
            <a href="GoogleLoginServlet" class="login-btn google-btn">
                <img src="Google__G__logo.svg" alt="Google">Google 로그인
            </a>
            <a href="NaverLoginServlet" class="login-btn naver-btn">
                <img src="naver.png" alt="Naver">Naver 로그인
            </a>
            <a href="KakaoLoginServlet" class="login-btn kakao-btn">
                <img src="kakao_logo.svg" alt="Kakao">Kakao 로그인
            </a>
        </div>
        <a href="join.jsp">회원가입</a>
        <a href="FindId.jsp">아이디 찾기</a>
        <a href="FindPw.jsp">비밀번호 찾기</a>
    </div>
<% } %>

</body>
</html>
