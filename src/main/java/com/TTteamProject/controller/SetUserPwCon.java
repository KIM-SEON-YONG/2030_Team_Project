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


@WebServlet("/FindPwCon")
public class SetUserPwCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String Session = null;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. requset객체에서 데이터 가져오기
		String user_email = request.getParameter("USER_EMAIL");
		
		// 3. 이메일로 해당 사용자 확인
        UserDAO dao = new UserDAO();
        UserDTO user = dao.findUserByEmail(user_email);

        // 4. 사용자가 존재하면 임시 비밀번호 발급
        if (user != null) {
            String tempPassword = generateTempPassword(); // 임시 비밀번호 생성
            dao.updatePassword(user_email, tempPassword); // 임시 비밀번호 DB에 저장

            // 5. 임시 비밀번호 이메일로 전송
            sendTempPasswordEmail(user_email, tempPassword);

            // 6. 결과 페이지로 리디렉션
            response.sendRedirect("password-reset-success.jsp");
        } else {
            // 이메일로 사용자가 존재하지 않으면 에러 페이지
            response.sendRedirect("find-password.jsp?error=not_found");
        }
    }
	// 임시 비밀번호 생성
    private String generateTempPassword() {
        // 간단한 임시 비밀번호 생성 로직
        return "temp1234"; // 실제로는 난수 등을 사용하여 복잡하게 생성해야 함
    }

    // 임시 비밀번호를 이메일로 전송
    private void sendTempPasswordEmail(String email, String tempPassword) {
        String subject = "임시 비밀번호 안내";
        String message = "귀하의 임시 비밀번호는 " + tempPassword + " 입니다.";

        // 예시로 JavaMail 사용 (이메일 서버 설정 필요)
        try {
            // 이메일 서버 설정
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.example.com"); // SMTP 서버 주소
            props.put("mail.smtp.port", "587"); // SMTP 포트
            props.put("mail.smtp.auth", "true"); // SMTP 인증 활성화
            props.put("mail.smtp.starttls.enable", "true"); // TLS 사용 활성화

            // SMTP 인증용 Authenticator 객체 생성
            Session mailSession = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("your-email@example.com", "your-email-password"); // 이메일 계정과 비밀번호 입력
                }
            });

            // 이메일 메시지 설정
            MimeMessage msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress("no-reply@example.com"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            msg.setSubject(subject);
            msg.setText(message);

            // 이메일 전송
            Transport.send(msg);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}