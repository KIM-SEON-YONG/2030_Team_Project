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

@WebServlet("/LogOutCon")
public class LogOutCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		 // 세션 가져오기
        HttpSession session = request.getSession(false); // 세션이 있으면 가져옴
        
        if (session != null) {
            session.invalidate(); // 세션 무효화
        }
        
        // 로그아웃 후 메인 페이지로 리디렉션
        response.sendRedirect("Main.jsp");
    }
}
 