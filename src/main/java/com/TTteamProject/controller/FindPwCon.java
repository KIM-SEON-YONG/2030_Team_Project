package com.TTteamProject.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;


@WebServlet("/FindPwCon")
public class FindPwCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_email = request.getParameter("USER_EMAIL");
		
		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		String password = dao.findPasswordByEmail(user_email);
	
		request.setAttribute("foundPassword", password);
        request.getRequestDispatcher("FindPw.jsp").forward(request, response);
    }

}
