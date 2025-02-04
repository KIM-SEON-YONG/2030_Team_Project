package com.TTteamProject.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

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
		
		// 3. 입력값 검증 (user_name, user_phone이 null이나 빈 문자열이면 에러 처리)
        if (user_name == null || user_name.trim().isEmpty() || user_phone == null || user_phone.trim().isEmpty()) {
            response.sendRedirect("find-id.jsp?error=empty_input");
            return;
        }

        // 4. DAO 호출
        UserDAO dao = new UserDAO();
        UserDTO findEmailByNameAndPhone = dao.findEmailByNameAndPhone(user_name, user_phone);

        // 5. 결과 처리
        if (findEmailByNameAndPhone != null) {
            // 이메일을 찾은 경우, 결과를 페이지로 전달
            request.setAttribute("USER_EMAIL", findEmailByNameAndPhone.getUser_email());
            RequestDispatcher dispatcher = request.getRequestDispatcher("FindId.jsp");
            dispatcher.forward(request, response);
        } else {
            // 이메일을 찾지 못한 경우
            response.sendRedirect("FindId.jsp?error=not_found");
        }
    }
}