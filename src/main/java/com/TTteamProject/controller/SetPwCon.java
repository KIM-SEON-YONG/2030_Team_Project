package com.TTteamProject.controller;

import java.io.IOException;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;


@WebServlet("/SetPwCon")
public class SetPwCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_email = request.setPassword("USER_EMAIL");
		
		// 3. 이메일로 해당 사용자 확인
        UserDAO dao = new UserDAO();
        UserDTO user = dao.findUserByEmail(user_email);

     // 4. 사용자가 존재하면 생년월일을 비밀번호로 설정
        if (user != null) {
            String birthDate = user.getBirthDate(); // 생년월일 가져오기 (YYYYMMDD 형식)
            dao.updatePassword(user_email, birthDate); // 생년월일로 비밀번호 업데이트

            // 5. 비밀번호 초기화 완료 후 결과 페이지로 리디렉션
            response.sendRedirect("password-reset-success.jsp");
        } else {
            // 이메일로 사용자가 존재하지 않으면 에러 페이지
            response.sendRedirect("find-password.jsp?error=not_found");
        }
    }
}