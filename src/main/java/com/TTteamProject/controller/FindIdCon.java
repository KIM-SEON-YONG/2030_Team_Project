package com.TTteamProject.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;


@WebServlet("/FindIdCon")
public class FindIdCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
	
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_name = request.getParameter("USER_NAME");
		String user_phone = request.getParameter("USER_PHONE");
		
		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		UserDTO user = dao.findEmailByNameAndPhone(user_name, user_phone);
		
		// 4. 결과 처리
		if (user != null) {
		    // 이메일 찾은 경우
		    String userEmail = user.getUser_email();  // UserDTO에서 이메일 가져오기
		    request.setAttribute("userEmail", userEmail);  // 이메일을 request에 저장 (jsp로 전달)
		    response.sendRedirect("FindId.jsp");  // 이메일이 찾았을 경우 처리할 JSP로 리디렉션
		} else {
		    // 이메일을 찾지 못한 경우
		    request.setAttribute("error", "해당 사용자 정보를 찾을 수 없습니다.");
		    response.sendRedirect("FindId.jsp");  // 오류 페이지로 리디렉션
		}
	}
}