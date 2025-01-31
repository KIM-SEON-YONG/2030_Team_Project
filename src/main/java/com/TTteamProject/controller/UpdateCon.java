package com.TTteamProject.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;



@WebServlet("/UpdateCon")
public class UpdateCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// 1. 요청 객체에 대한 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 요쳥 객체에서 데이터 꺼내기
		String user_id = request.getParameter("user_id");
		
		System.out.println(user_id);
		
		
		// 3. DAO의 update메서드를 이용하여 데이터 처리하기
		UserDAO dao = new UserDAO();
		UserDTO dto = new UserDTO();		
		
		
		// 4. 결과처리하기
		request.setAttribute("dto", dto);
		request.getRequestDispatcher("Update.jsp").forward(request, response);
		
		
		
	}

}
