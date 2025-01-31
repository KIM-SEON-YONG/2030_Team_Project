package com.TTteamProject.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CheckIdCon")
public class CheckIdCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// email 중복 가입 체크 로직
		response.setCharacterEncoding("UTF-8");

		String user_id = request.getParameter("USER_ID");
		System.out.println(user_id);
		UserDAO dao = new UserDAO();
		UserDTO result = dao.checkId(user_id);
		System.out.println(result);

		if (result == null) {
			// DB에서 동일한 이메일 값을 찾지 못한 경우
			response.getWriter().write("available");
		} else {
			// DB에서 동일한 이메일 값을 찾은 경우 == 중복이다.
			response.getWriter().write("duplicate");
		}
	}

}