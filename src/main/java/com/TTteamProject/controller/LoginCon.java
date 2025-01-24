package com.TTteamProject.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TTteamProject.Frontcontroller.Command;
import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void dopost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_id = request.getParameter("USER_ID");
		String user_pw = request.getParameter("USER_PW");
		

		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		UserDTO user = dao.login(user_id, user_pw);
		
		// 4. 결과 처리하기
		if(user != null) {
			// 로그인 성공
			 response.sendRedirect("Main.jsp");
		}else {
			response.sendRedirect("login.jsp?error=true");
		}
				
		
	}

       
    
   
}
