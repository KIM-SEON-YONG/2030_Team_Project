package com.TTteamProject.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
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
		
		// 3. dao호출
		UserDAO dao = new UserDAO();
		UserDTO findPasswordByEmail = dao.findPasswordByEmail(user_email);
		
		// 4. 비밀번호 찾기 결과 처리
        if (findPasswordByEmail != null) {
            // 비밀번호를 찾은 경우
            request.setAttribute("USER_EMAIL", findPasswordByEmail);
            RequestDispatcher dispatcher = request.getRequestDispatcher("FindPw.jsp");
            dispatcher.forward(request, response);
        } else {
            // 비밀번호를 찾지 못한 경우
            response.sendRedirect("find-pw.jsp?error=not_found");
        }
    }

}
