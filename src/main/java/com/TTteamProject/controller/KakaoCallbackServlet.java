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

@WebServlet("/KakaoCallbackServlet")
public class KakaoCallbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String REST_API_KEY = "e7fbd858403212906ac6febac4a9d400";
    private static final String REDIRECT_URI = "http://localhost:8081/2030_Team_Project/KakaoCallbackServlet";
    private static final String TOKEN_URL = "https://kauth.kakao.com/oauth/token";
    private static final String USER_INFO_URL = "https://kapi.kakao.com/v2/user/me";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            request.setAttribute("errorMessage", "카카오 로그인에 실패했습니다.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String accessToken = getAccessToken(code);

        if (accessToken == null) {
            request.setAttribute("errorMessage", "카카오 액세스 토큰 요청 실패");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String userInfoJson = getUserInfo(accessToken);
        JsonObject userJson = JsonParser.parseString(userInfoJson).getAsJsonObject();
        System.out.println("🔹 받은 사용자 정보 JSON: " + userInfoJson);

        JsonObject kakaoAccount = userJson.has("kakao_account") ? userJson.getAsJsonObject("kakao_account") : null;
        JsonObject properties = userJson.has("properties") ? userJson.getAsJsonObject("properties") : null;

        String kakaoId = (kakaoAccount != null && kakaoAccount.has("email")) ? kakaoAccount.get("email").getAsString() : null;
        String name = (properties != null && properties.has("nickname")) ? properties.get("nickname").getAsString() : "Unknown";

        // 이메일이 없는 경우 예외 방지
        if (kakaoId == null) {
            request.setAttribute("errorMessage", "카카오 이메일 정보를 가져올 수 없습니다. 이메일 제공 동의를 확인해주세요.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 4️⃣ 데이터베이스에서 사용자 확인 (MyBatis 활용)
        UserDAO dao = new UserDAO();
        UserDTO user = dao.getUserByEmail(kakaoId);

        if (user == null) {
            // 신규 사용자라면 자동 회원가입
	        user = new UserDTO(kakaoId, "KAKAO_LOGIN", name);
            dao.registerNaveruser(user);
            System.out.println("✅ 신규 네이버 사용자 등록 완료");
        } else {
            System.out.println("✅ 기존 네이버 사용자 로그인");
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/Main.jsp");
    }

    private String getAccessToken(String code) throws IOException {
        String params = "grant_type=authorization_code"
                + "&client_id=" + REST_API_KEY
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8.name())
                + "&code=" + code;

        System.out.println("🔹 요청할 Token URL: " + TOKEN_URL);
        System.out.println("🔹 보낼 파라미터: " + params);

        String response = sendPostRequest(TOKEN_URL, params);
        System.out.println("🔹 받은 액세스 토큰 응답: " + response);

        JsonObject json = JsonParser.parseString(response).getAsJsonObject();

        if (json.has("error")) {
            System.out.println("❌ 카카오 인증 오류 발생: " + json.get("error").getAsString());
            System.out.println("🔹 오류 설명: " + json.get("error_description").getAsString());
            return null;
        }

        return json.has("access_token") ? json.get("access_token").getAsString() : null;
    }

    private String getUserInfo(String accessToken) throws IOException {
        return sendGetRequest(USER_INFO_URL, accessToken);
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
