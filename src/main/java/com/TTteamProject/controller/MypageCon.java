package com.TTteamProject.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TTteamProject.model.BoardDAO;
import com.TTteamProject.model.BoardDTO;
import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

@WebServlet("/MypageCon")
public class MypageCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	  @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
		  
		  	//  인코딩
			request.setCharacterEncoding("UTF-8");
			
			// 사용자 세션 확인
	        HttpSession session = request.getSession();
	        UserDTO user = (UserDTO) session.getAttribute("user");
	       
	        // 로그인된 사용자만 마이페이지 접근 가능
	        if (user != null) {
	            String userId = user.getUser_id();
	            
	            
	            
	            
	        
	            // BoardDAO 객체를 통해 해당 사용자가 작성한 게시글 목록 가져오기
	            BoardDAO boardDAO = new BoardDAO();
	            List<BoardDTO> userBoards = boardDAO.getUserBoards(userId);

	            // 게시글 목록을 JSP에 전달
	            request.setAttribute("userBoards", userBoards);
	            request.getRequestDispatcher("Mypage.jsp").forward(request, response);
	        } else {
	            response.sendRedirect("login.jsp"); // 로그인되어 있지 않으면 로그인 페이지로 리다이렉트
	        }
	    }
	}