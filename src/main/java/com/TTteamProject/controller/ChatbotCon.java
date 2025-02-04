package com.TTteamProject.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

/**
 * Servlet implementation class ChatbotCon
 */
@WebServlet("/ChatbotCon")
public class ChatbotCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		try {
            // 사용자 입력 받기
            String userMessage = request.getParameter("userMessage");

            // Flask 챗봇 API 호출
            String apiUrl = "http://127.0.0.1:5000/api/chatbot";
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // HTTP 요청 설정
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // JSON 데이터 생성 및 전송
            JSONObject json = new JSONObject();
            json.put("message", userMessage);
            try (OutputStream os = conn.getOutputStream()) {
                os.write(json.toString().getBytes("UTF-8"));
                os.flush();
            }

            // Flask API 응답 받기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder responseStr = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseStr.append(line);
            }
            br.close();

            // **✅ JSON 응답 강제 설정**
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(responseStr.toString());

        } catch (Exception e) {
            e.printStackTrace();
            // **에러 발생 시 JSON 응답을 반환해야 함**
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"answer\": \"서버 오류 발생\"}");
        }
    }
}