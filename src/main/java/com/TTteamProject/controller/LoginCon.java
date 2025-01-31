package com.TTteamProject.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		String user_pw = request.getParameter("USER_PW");
		
		// 3. DAO의 메서드 호출
		UserDAO dao = new UserDAO();
		UserDTO user = dao.loginCheck(user_id, user_pw);
		
		
		 // 로그인 결과에 따른 처리
        if (user != null && user.getUser_pw().equals(user_pw)) {
           // 로그인 성공 시 세션에 사용자 정보 저장
        	HttpSession session = request.getSession();
            session.setAttribute("user", user); // 로그인된 사용자 정보 세션에 저장
            
            // 쿠키 처리 (옵션: 사용자 아이디 쿠키 생성)
            Cookie userIdCookie = new Cookie("user_id", user_id); // 사용자 아이디 쿠키 생성
            userIdCookie.setMaxAge(60 * 60 * 24 * 30); // 쿠키 유효기간 30일
            response.addCookie(userIdCookie); // 쿠키를 응답에 추가
           
           // 로그인 성공 시
           response.sendRedirect("Main.jsp");
        } else {
            // 로그인 실패 시
            request.setAttribute("errorMessage", "아이디나 비밀번호가 일치하지 않습니다. 다시 로그인해주세요.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}