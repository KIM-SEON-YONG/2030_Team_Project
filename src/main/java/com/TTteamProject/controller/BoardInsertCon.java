package com.TTteamProject.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TTteamProject.model.BoardDAO;
import com.TTteamProject.model.BoardDTO;


@WebServlet("/write")
public class BoardInsertCon extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("USER_ID");
		String content = request.getParameter("B_CONTENT");
		String[] category = request.getParameterValues("B_CATEGORY");
		String title = request.getParameter("B_TITLE");
		
		System.out.println(Arrays.toString(category));
		
		BoardDTO dto = new BoardDTO(userId,content,Arrays.toString(category), title);
		BoardDAO dao = new BoardDAO();
		int result =  dao.insertBoard(dto);
		response.sendRedirect("boardList.jsp");
	}

}
