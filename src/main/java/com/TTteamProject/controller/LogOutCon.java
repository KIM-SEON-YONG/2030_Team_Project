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

@WebServlet("/LogOutCon")
public class LogOutCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		 // 세션 무효화
        HttpSession session = request.getSession();
        session.invalidate();  // 세션 무효화

        // 2. 쿠키 삭제 (로그인 시 쿠키를 사용한 경우)
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    cookie.setValue(null); // 값 초기화
                    cookie.setMaxAge(0); // 유효 기간 0으로 설정
                    response.addCookie(cookie); // 응답에 추가
                }
            }
        }

        // 3. 메인 페이지로 리다이렉트
        response.sendRedirect("Main.jsp");
    }
}