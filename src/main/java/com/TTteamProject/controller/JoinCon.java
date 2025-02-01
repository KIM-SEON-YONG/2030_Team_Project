package com.TTteamProject.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.Frontcontroller.Command;
import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

@WebServlet("/JoinCon")
    

	public class JoinCon extends HttpServlet {
		private static final long serialVersionUID = 1L;


		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_id = request.getParameter("USER_ID");
		String user_pw = request.getParameter("USER_PW");
		String user_name = request.getParameter("USER_NAME");
		String user_birthdate = request.getParameter("USER_BIRTHDATE");
		String user_gender = request.getParameter("USER_GENDER");
		String user_phone = request.getParameter("USER_PHONE");
		String fav_welfare = request.getParameter("FAV_WELFARE");
		String fav_region = request.getParameter("FAV_REGION");
		
		System.out.println(user_id);
		System.out.println(user_pw);
		System.out.println(user_name);
		System.out.println(user_birthdate);
		
		

		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		UserDTO dto = new UserDTO(user_id, user_pw,user_name, user_birthdate, user_gender, user_phone, fav_welfare, fav_region, 0, 0);
		
		int result = dao.joinList(dto);		
		
		// 4. 결과 처리하기
				if(result>0) {
					// 성공하면
					System.out.print("회원가입 성공!");
					response.sendRedirect("login.jsp");
					
				}else {
					// 실패시
					System.out.println("회원가입 실패");
							
				}
				
		
	}
		
		

	}

