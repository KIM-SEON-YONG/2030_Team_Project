package com.TTteamProject.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

@WebServlet("/UpdateCon")
public class UpdateCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

<<<<<<< HEAD
		
		// 수정할 사용자 정보 받기
        String user_id = loggedInUser.getUser_id(); // 세션에서 가져온 사용자 ID
        String user_pw = request.getParameter("USER_PW");
        String user_pw_chk = request.getParameter("USER_PW_CHK");  // 비밀번호 확인 입력 받기
        String user_name = loggedInUser.getUser_name(); // 세션에서 가져온 사용자 이름
        String user_birthdate = loggedInUser.getUser_birthdate(); // 세션에서 가져온 생일
        String user_gender = loggedInUser.getUser_gender();; // 세션에서 가져온 성별
        String user_phone = request.getParameter("USER_PHONE");
        String user_email = loggedInUser.getUser_email();; 
        String fav_welfare = request.getParameter("FAV_WELFARE");
        String fav_region = request.getParameter("FAV_REGION");
		
        // 비밀번호 확인이 일치하지 않으면 포워딩
        if (user_pw != null && !user_pw.isEmpty() && !user_pw.equals(user_pw_chk)) {
            request.setAttribute("message", "비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("Update.jsp").forward(request, response);
            return;  // 수정 작업을 진행하지 않음
        }
        
		 // 수정된 정보를 UserDTO 객체에 담기
        UserDTO updatedUser = new UserDTO();
        updatedUser.setUser_id(user_id); // 기존 사용자 ID는 수정하지 않음
        updatedUser.setUser_name(user_name); // 기존 사용자 이름은 수정하지 않음
        updatedUser.setUser_birthdate(user_birthdate); // 기존 생일은 수정하지 않음
        updatedUser.setUser_gender(user_gender); // 기존 성별은 수정하지 않음
        updatedUser.setUser_phone(user_phone); // 새로운 전화번호
        updatedUser.setUser_email(user_email); 
        updatedUser.setFav_welfare(fav_welfare); // 새로운 선호 복지
        updatedUser.setFav_region(fav_region); // 새로운 선호 지역

        
        // 비밀번호가 변경되었으면 암호화 처리하기 (예: BCrypt)
        if (user_pw != null && !user_pw.isEmpty()) {
            String encryptedPw = BCrypt.hashpw(user_pw, BCrypt.gensalt());
            updatedUser.setUser_pw(encryptedPw);  // 암호화된 비밀번호 저장
        }else {
            // 비밀번호가 변경되지 않으면 기존 비밀번호를 그대로 사용
            updatedUser.setUser_pw(loggedInUser.getUser_pw()); 
        }
=======
		// 요청 객체에 대한 인코딩
		request.setCharacterEncoding("UTF-8");

		// 세션에서 로그인한 사용자 정보를 가져오기 (예시로 사용)
		HttpSession httpSession = request.getSession(false); // 기존 세션을 가져옴

		if (httpSession == null || httpSession.getAttribute("user") == null) {
			// 세션에 로그인한 사용자 정보가 없으면 로그인 페이지로 리디렉션
			response.sendRedirect("login.jsp");
			return;
		}

		UserDTO loggedInUser = (UserDTO) httpSession.getAttribute("user"); // 로그인한 사용자 정보

		// 세션에서 가져온 정보들
		String user_id = loggedInUser.getUser_id(); // 세션에서 가져온 사용자 ID
		String user_name = loggedInUser.getUser_name(); // 세션에서 가져온 사용자 이름
		String user_birthdate = loggedInUser.getUser_birthdate(); // 세션에서 가져온 생일
		String user_gender = loggedInUser.getUser_gender(); // 세션에서 가져온 성별

		// 수정된 사용자 정보(변경된 값만 가져옴)
		String user_pw = request.getParameter("user_pw");
		String user_pw_chk = request.getParameter("user_pw_chk"); // 비밀번호 확인 입력 받기
		String user_phone = request.getParameter("user_phone");
		String fav_welfare = request.getParameter("fav_welfare");
		String fav_region = request.getParameter("fav_region");

		// 비밀번호 확인 처리 - 비밀번호 다를 시 alert창 띄우기
		if (user_pw != null && !user_pw.isEmpty() && !user_pw.equals(user_pw_chk)) {
			request.setAttribute("pwdchkMessage", "비밀번호가 일치하지 않습니다.");
			request.getRequestDispatcher("Update.jsp").forward(request, response); // Update.jsp로 포워딩
			/*
			 * request.getRequestDispatcher("UpdateResult.jsp").forward(request, response);
			 */
			return; // 비밀번호가 일치하지 않으면 수정 작업을 진행하지 않음
		}
>>>>>>> branch 'master' of https://github.com/KIM-SEON-YONG/2030_Team_Project.git


		// 기존의 값들은 그대로 두고, 변경된 값만 업데이트
		UserDTO updatedUser = new UserDTO();
		
		updatedUser.setUser_id(user_id); // 기존 사용자 ID는 수정하지 않음
		updatedUser.setUser_name(user_name); // 기존 사용자 이름은 수정하지 않음
		updatedUser.setUser_birthdate(user_birthdate); // 기존 생일은 수정하지 않음
		updatedUser.setUser_gender(user_gender); // 기존 성별은 수정하지 않음
		
		// 전화번호, 관심분야, 지역은 수정된 값이므로 setter로 업데이트
		updatedUser.setUser_phone(user_phone); // 새로운 전화번호
		updatedUser.setFav_welfare(fav_welfare); // 새로운 선호 복지
		updatedUser.setFav_region(fav_region); // 새로운 선호 지역
		
		// 비밀번호가 수정되었을 때 암호화하여 설정
		if (user_pw != null && !user_pw.isEmpty()) {
		    String encryptedPw = BCrypt.hashpw(user_pw_chk, BCrypt.gensalt()); // 비밀번호 암호화
		    updatedUser.setUser_pw(encryptedPw);  // 암호화된 비밀번호 저장
		} else {
		    // 비밀번호가 변경되지 않으면 기존 비밀번호를 그대로 설정
		    updatedUser.setUser_pw(loggedInUser.getUser_pw()); // 기존 비밀번호 유지
		}
		
		
		/*
		 * // 비밀번호가 변경되었으면 암호화 처리하기 (예: BCrypt) if (user_pw != null &&
		 * !user_pw.isEmpty()) { String encryptedPw = BCrypt.hashpw(user_pw,
		 * BCrypt.gensalt()); updatedUser.setUser_pw(encryptedPw); // 암호화된 비밀번호 저장 }else
		 * { // 비밀번호가 변경되지 않으면 기존 비밀번호를 그대로 사용
		 * updatedUser.setUser_pw(loggedInUser.getUser_pw()); }
		 */

		// 사용자 정보를 DB에 업데이트 (DB 업데이트 메소드 호출)
		UserDAO dao = new UserDAO();
		boolean success = dao.updateUser(updatedUser); // DAO의 updateUser 메서드로 수정정보 보내기

		// 업데이트 성공 여부에 따른 리다이렉션 처리
		if (success) {
			// 업데이트 성공 시 세션에 저장된 사용자 정보 갱신
			httpSession.setAttribute("user", updatedUser);
			request.setAttribute("message", "회원정보 수정 성공");
			response.sendRedirect("Mypage.jsp"); // 메인 페이지로 리다이렉트
		} else {
			request.setAttribute("updatedUserFail", "회원정보 수정 실패");
			request.getRequestDispatcher("Update.jsp").forward(request, response); // 실패 시 다시 Update.jsp로 포워딩
		}
	}
}
