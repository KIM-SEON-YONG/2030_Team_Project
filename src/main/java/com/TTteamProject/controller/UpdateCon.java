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

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 요청 객체에 대한 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 요쳥 객체에서 데이터 꺼내기
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		String tel = request.getParameter("tel");
		String address = request.getParameter("address");
		
		System.out.println(email);
		System.out.println(pw);
		System.out.println(tel);
		System.out.println(address);
		
		// 3. DAO의 update메서드를 이용하여 데이터 처리하기
//		UserDAO dao = new UserDAO();
//		UserDTO dto = new UserDTO(email, pw, tel, address);
//		int result = dao.update(dto);
		
		
//		// 4. 결과처리하기
//		if(result>0) {
//			// update sql문을 실행 했을 떄, 영향 받은 행의 개수가 0보다 크다
//			System.out.println("업데이트 성공");
//			HttpSession session = request.getSession();
//			session.setAttribute("result", dto);
//			response.sendRedirect("main.jsp");
//		}else {
//			System.out.println("업데이트 성공");
//			response.sendRedirect("update.jsp");
//		}
//		
		
		
		
	}

}
