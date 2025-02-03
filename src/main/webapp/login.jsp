<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 세션에서 로그인된 사용자 정보를 가져오기
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
/* 기존 스타일 유지 */
</style>
</head>
<body>

<% if (userName != null) { %>
    <!-- 로그인된 사용자라면 환영 메시지 표시 -->
    <div class="container">
        <h2>환영합니다, <%= userName %>님!</h2>
        <p>이메일: <%= userEmail %></p>
        <button onclick="logout()">로그아웃</button>
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
    <!-- 로그인되지 않은 사용자라면 로그인 폼 표시 -->
    <form name="loginCheck" action="LoginCon" method="post">
        <table>
            <tr>
                <td><h2>로그인</h2></td>
            </tr>
            <tr>
                <td><input type="text" required maxlength="15" placeholder="ID" id="id" name="USER_ID"></td>
            </tr>
            <tr>
                <td><input type="password" placeholder="PW" id="pw" name="USER_PW"></td>
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
<!-- 구글 로그인 버튼 -->
<div class="g-signin2-grid">
    <a href="GoogleLoginServlet" class="g-signin2 custom-google-btn">
        <img src="Google__G__logo.svg" alt="Google 로그인">
        <span>Google 로그인</span>
    </a>
</div>



<% } %>

</body>
</html>
