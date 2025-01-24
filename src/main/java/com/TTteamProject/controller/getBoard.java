package com.TTteamProject.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.TTteamProject.model.BoardDAO;
import com.TTteamProject.model.BoardDTO;


@WebServlet("/getBoard")
public class getBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("UTF-8");
	        response.setContentType("application/json; charset=UTF-8");

	        // 요청에서 게시글 ID(b_idx) 가져오기
	        String b_idxParam = request.getParameter("b_idx");
	        int b_idx = 0;
	        if (b_idxParam != null) {
	            try {
	                b_idx = Integer.parseInt(b_idxParam);
	            } catch (NumberFormatException e) {
	                response.getWriter().write("{\"error\": \"Invalid ID format\"}");
	                return;
	            }
	        }

	        // DB에서 게시글 가져오기
	        BoardDAO dao = new BoardDAO();
	        BoardDTO post = dao.getBoard(b_idx);

	        // JSON 데이터로 변환하여 클라이언트에 응답
	        PrintWriter out = response.getWriter();
	        JSONObject json = new JSONObject();
	        if (post != null) {
	            json.put("b_idx", post.getB_idx());
	            json.put("b_title", post.getB_title());
	            json.put("b_content", post.getB_content());
	            json.put("user_id", post.getUserId());
	            json.put("create_dt", post.getCreate_dt().toString());
	        } else {
	            json.put("error", "Post not found");
	        }
	        out.print(json.toString());
	        out.flush();
	    }
}

		
		
		
		

