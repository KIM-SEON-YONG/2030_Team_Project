package com.TTteamProject.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TTteamProject.model.PolicyDAO;
import com.TTteamProject.model.PolicyDTO;

@WebServlet("/welfareList")
public class PolicyList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 인코딩
//		request.setCharacterEncoding("UTF-8");
//		
//		// 2. request 객체에서 데이터 가져오기
//		
//		// 3. boardDAO
//		WelfareDAO dao = new WelfareDAO();
//		List<WelfareDTO> result = dao.selectJob();
//		
//		System.out.print(result);
		
		
		
		
	}

}
