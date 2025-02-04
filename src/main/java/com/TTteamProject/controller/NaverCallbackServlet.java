package com.TTteamProject.controller;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TTteamProject.model.UserDAO;
import com.TTteamProject.model.UserDTO;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/NaverCallbackServlet")
public class NaverCallbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID = "2S5dv8uJFdmdx0ucmg8H";
    private static final String CLIENT_SECRET = "NFMMKjcv42";
    private static final String REDIRECT_URI = "http://localhost:8081/2030_Team_Project/NaverCallbackServlet";
    private static final String TOKEN_URL = "https://nid.naver.com/oauth2.0/token";
    private static final String USER_INFO_URL = "https://openapi.naver.com/v1/nid/me";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("✅ NaverCallbackServlet 실행됨");

        // 1️⃣ `code` 값 확인
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        System.out.println("🔹 받은 code 값: " + code);
        System.out.println("🔹 받은 state 값: " + state);

        if (code == null || code.isEmpty()) {
            System.out.println("❌ code 값이 없음 -> 로그인 페이지로 이동");
            request.setAttribute("errorMessage", "네이버 로그인에 실패했습니다.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 2️⃣ `code`를 사용해 `access_token` 요청
        String accessToken = getAccessToken(code, state);
        System.out.println("🔹 받은 액세스 토큰: " + accessToken);

        if (accessToken == null) {
            System.out.println("❌ accessToken을 가져오는 데 실패");
            request.setAttribute("errorMessage", "네이버 액세스 토큰 요청 실패");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 3️⃣ `access_token`을 사용해 사용자 정보 요청
        String userInfoJson = getUserInfo(accessToken);
        System.out.println("🔹 받은 사용자 정보 JSON: " + userInfoJson);

        if (userInfoJson == null) {
            System.out.println("❌ 사용자 정보를 가져오는 데 실패");
            request.setAttribute("errorMessage", "네이버 사용자 정보 요청 실패");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // JSON 파싱
        JsonObject userJson = JsonParser.parseString(userInfoJson).getAsJsonObject();
        JsonObject responseObj = userJson.getAsJsonObject("response");

        String naverId = responseObj.get("id").getAsString();
        String name = responseObj.get("name").getAsString();
        String email = responseObj.get("email").getAsString();

        System.out.println("🔹 네이버 사용자 ID: " + naverId);
        System.out.println("🔹 사용자 이름: " + name);
        System.out.println("🔹 사용자 이메일: " + email);

        // 4️⃣ 데이터베이스에서 사용자 확인 (MyBatis 활용)
        UserDAO dao = new UserDAO();
        UserDTO user = dao.getUserByEmail(naverId);

        if (user == null) {
            // 신규 사용자라면 자동 회원가입
	        user = new UserDTO(email, "GOOGLE_LOGIN", name);
            dao.registerNaveruser(user);
            System.out.println("✅ 신규 네이버 사용자 등록 완료");
        } else {
            System.out.println("✅ 기존 네이버 사용자 로그인");
        }

        // 5️⃣ 로그인 성공 시 세션 저장
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // 6️⃣ 로그인 성공 후 메인 페이지로 이동
        System.out.println("🔹 로그인 성공! Main.jsp로 이동");
        response.sendRedirect(request.getContextPath() + "/Main.jsp");
    }

    // 네이버에서 액세스 토큰 가져오기
    private String getAccessToken(String code, String state) throws IOException {
        String params = "grant_type=authorization_code"
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&code=" + code
                + "&state=" + state;

        String response = sendPostRequest(TOKEN_URL, params);
        System.out.println("🔹 받은 액세스 토큰 응답: " + response);

        JsonObject json = JsonParser.parseString(response).getAsJsonObject();
        return json.has("access_token") ? json.get("access_token").getAsString() : null;
    }

    // 네이버에서 사용자 정보 가져오기
    private String getUserInfo(String accessToken) throws IOException {
        return sendGetRequest(USER_INFO_URL, accessToken);
    }

    // POST 요청 (네이버 OAuth 토큰 요청)
    private String sendPostRequest(String url, String params) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        // 🔥 타임아웃 설정 (10초)
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(10000);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes(StandardCharsets.UTF_8));
        }

        return readResponse(conn);
    }

    // GET 요청 (네이버 사용자 정보 요청)
    private String sendGetRequest(String url, String accessToken) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        System.out.println("🔹 네이버 API 요청: " + url);
        System.out.println("🔹 Authorization 헤더: Bearer " + accessToken);

        // 🔥 타임아웃 설정 (10초)
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(10000);

        int responseCode = conn.getResponseCode();
        System.out.println("🔹 네이버 API 응답 코드: " + responseCode);

        if (responseCode == 401) {
            System.out.println("❌ 401 오류 - 액세스 토큰이 유효하지 않음.");
            return null;
        }

        return readResponse(conn);
    }

    // HTTP 응답 읽기
    private String readResponse(HttpURLConnection conn) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            return br.lines().collect(Collectors.joining());
        }
    }
}
