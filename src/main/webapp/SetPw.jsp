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

</style>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
</head>
<body>
    <h2>비밀번호를 잊으셨나요?</h2>
    <form action="FindPasswordController" method="post">
        <label for="userEmail">이메일 주소:</label>
        <input type="email" id="userEmail" name="USER_EMAIL" required /><br><br>
        <input type="submit" value="임시 비밀번호 발급" />        
    </form>
    <p><a href="login.jsp">로그인 페이지로 가기</a></p>
</body>
</html>
