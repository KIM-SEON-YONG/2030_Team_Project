<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보삭제</title>
</head>
<body>

	<%
		String USER_ID = (String) session.getAttribute("user_id");
		
		if(USER_ID == null){
				response.sendRedirect("login.jsp");
		}
	%>


	<fieldset>
		<legend> 회원정보 탈퇴하기 </legend>
		<form action="Deldte.jsp">
			<input type="hidden" name="USER_ID" value="<%=USER_ID%>">
			비밀번호 : <input type="password" name="pass"><br>
			<input type="submit" value="삭제하기">
		</form>
	
	</fieldset>
 <script type="text/javascript">
//회원탈퇴 선택
	function selectOption(option) {
		if (option === '회원 탈퇴') {
			if (confirm("정말 회원 탈퇴를 진행하시겠습니까?")) {
				alert("회원 탈퇴가 완료되었습니다.");
				window.location.href = '/delete-account';
			}
		} else if (option === '로그아웃') {
			alert("로그아웃 되었습니다.");
			window.location.href = '/logout';
			document.getElementById("powerMenu").style.display = "none";

		}
	}
 </script>
</body>
</html>