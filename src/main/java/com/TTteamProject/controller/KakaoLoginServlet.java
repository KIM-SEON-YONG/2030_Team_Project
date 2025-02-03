package com.TTteamProject.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/KakaoLoginServlet")
public class KakaoLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String REST_API_KEY = "e7fbd858403212906ac6febac4a9d400";
    private static final String REDIRECT_URI = "http://localhost:8081/2030_Team_Project/KakaoCallbackServlet";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUrl = "https://kauth.kakao.com/oauth/authorize?"
                        + "client_id=" + REST_API_KEY
                        + "&redirect_uri=" + REDIRECT_URI
                        + "&response_type=code";

        response.sendRedirect(loginUrl);
    }
}
