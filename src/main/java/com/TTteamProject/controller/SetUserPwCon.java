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
public class SetUserPwCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_email = request.getParameter("USER_EMAIL");
		
		// 3. dao호출
		UserDAO dao = new UserDAO();
		UserDTO setUserPW = dao.setUserPW(user_email);
		
		 // 4. 비밀번호 찾기 결과 처리
        if (findPasswordByEmail != null) {
            // 사용자 정보가 존재하면 임시 비밀번호를 생성
            String tempPassword = PasswordUtil.generateTempPassword();
            
            // 5. 임시 비밀번호로 DB 업데이트
            boolean isUpdated = dao.updatePassword(user_email, tempPassword);
            if (isUpdated) {
                // 6. 이메일로 임시 비밀번호 전송
                EmailUtil.sendEmail(user_email, tempPassword);

                // 7. 비밀번호 찾기 성공 페이지로 이동
                request.setAttribute("USER_EMAIL", user_email);
                RequestDispatcher dispatcher = request.getRequestDispatcher("FindPwSuccess.jsp");
                dispatcher.forward(request, response);
            } else {
                // 비밀번호 업데이트 실패 처리
                response.sendRedirect("find-pw.jsp?error=update_failed");
            }
        } else {
            // 이메일에 해당하는 사용자가 없는 경우
            response.sendRedirect("find-pw.jsp?error=not_found");
        }
    }
}
