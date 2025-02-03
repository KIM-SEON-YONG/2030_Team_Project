package com.TTteamProject.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GoogleLoginServlet
 */
@WebServlet("/GoogleLoginServlet")
public class GoogleLoginServlet extends HttpServlet {
    private static final String CLIENT_ID = "552140088937-4e7nhjd7bhmbhgs46cl4ig4ncc9jlkhv.apps.googleusercontent.com";
    private static final String REDIRECT_URI = "http://localhost:8081/2030_Team_Project/GoogleLoginCon";
    private static final String AUTH_URL = "https://accounts.google.com/o/oauth2/auth";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String loginUrl = AUTH_URL + "?client_id=" + CLIENT_ID
                        + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8.name())
                        + "&response_type=code"
                        + "&scope=openid email profile"
                        + "&access_type=offline"
                        + "&prompt=consent";

        System.out.println("✅ 생성된 Google 로그인 URL: " + loginUrl);

        response.sendRedirect(loginUrl);
    }
}
