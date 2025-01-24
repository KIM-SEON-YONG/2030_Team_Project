package com.TTteamProject.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

@WebServlet("/LoginCon")
public class LoginCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
	
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_id = request.getParameter("USER_ID");
		System.out.println(user_id);
		String user_pw = request.getParameter("USER_PW");
		System.out.println(user_pw);
		
		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		UserDTO user = dao.loginCheck(user_id, user_pw);
		System.out.println(user);
		
		/// 로그인 결과에 따른 처리
        if (user != null && user.getUser_pw().equals(user_pw)) {
            // 로그인 성공 시
        	request.setAttribute("successMessage", "로그인에성공하였습니다..");
        	request.getRequestDispatcher("Main.html").forward(request, response);
        } else {
            // 로그인 실패 시
            request.setAttribute("errorMessage", "아이디나 비밀번호가 일치하지 않습니다. 다시 로그인해주세요.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}