package com.TTteamProject.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.Frontcontroller.Command;
import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

@WebServlet("/JoinCon")
public class JoinCon implements Command {
	    

	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_id = request.getParameter("user_id");
		String user_Pw = request.getParameter("user_Pw");
		String user_Name = request.getParameter("user_Name");
		String user_Birthdate = request.getParameter("user_Birthdate");
		String user_Gender = request.getParameter("user_Gender");
		String user_Phone = request.getParameter("user_Phone");
		String fav_Welfare = request.getParameter("fav_Welfare");
		String fav_Region = request.getParameter("fav_Region");
		String join_Dt = request.getParameter("join_Dt");
		int welfare_Point = Integer.parseInt(request.getParameter("welfare_Point"));
		

		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		UserDTO dto = new UserDTO(user_id, user_Pw,user_Name, user_Birthdate, user_Gender, user_Phone, fav_Welfare, fav_Region, join_Dt,welfare_Point);
		
		int result = dao.register(dto);		
		
		// 4. 결과 처리하기
				if(result>0) {
					return "redirect:/join.jsp";
				}else {
					return "redirect:/join.jsp";			
				}
				
		
	}

}
