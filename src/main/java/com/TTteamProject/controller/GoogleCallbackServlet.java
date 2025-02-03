package com.TTteamProject.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GoogleCallbackServlet
 */
@WebServlet("/google-callback")
public class GoogleCallbackServlet extends HttpServlet {
    private static final String CLIENT_ID = "552140088937-4e7nhjd7bhmbhgs46cl4ig4ncc9jlkhv.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8081/2030_Team_Project/api/google/callback";
    private static final String TOKEN_URL = "https://oauth2.googleapis.com/token";
    private static final String USER_INFO_URL = "https://www.googleapis.com/oauth2/v2/userinfo";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String code = request.getParameter("code");
        if (code == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // 1. Access Token 요청
        String accessToken = getAccessToken(code);
        if (accessToken == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // 2. 사용자 정보 요청ㅇ
        String userInfoJson = getUserInfo(accessToken);
        if (userInfoJson == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // 3. 세션에 사용자 정보 저장
        HttpSession session = request.getSession();
        session.setAttribute("user", userInfoJson);

        // 4. 메인 페이지로 이동
        response.sendRedirect("m.jsp");
    }

    private String getAccessToken(String code) throws IOException {
        String params = "code=" + code
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&grant_type=authorization_code";

        String response = sendPostRequest(TOKEN_URL, params);
        JsonObject json = JsonParser.parseString(response).getAsJsonObject();
        return json.has("access_token") ? json.get("access_token").getAsString() : null;
    }

    private String getUserInfo(String accessToken) throws IOException {
        String response = sendGetRequest(USER_INFO_URL, accessToken);
        return response;
    }

    private String sendPostRequest(String url, String params) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        
        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes(StandardCharsets.UTF_8));
        }

        return readResponse(conn);
    }

    private String sendGetRequest(String url, String accessToken) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
        return readResponse(conn);
    }

    private String readResponse(HttpURLConnection conn) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            return br.lines().collect(Collectors.joining());
        }
    }
}
