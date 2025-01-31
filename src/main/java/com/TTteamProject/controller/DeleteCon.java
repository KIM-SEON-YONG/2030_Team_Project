package com.TTteamProject.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

@WebServlet("/DeleteCon")
public class DeleteCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 요청 객체에 대한 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_id = request.getParameter("USER_ID");
		String user_pw = request.getParameter("USER_PW");
	
		
		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		int user = dao.Delete(user_id, user_pw);
		
				
//		// 결과에 따른 처리
//        if (user == -1) {
//        	%>
//        	<script type="text/javascript">
//        		alert("비밀번호 오류");
//        		history.back();
//        	</script>
//        	<%
//        }
//
}
}
