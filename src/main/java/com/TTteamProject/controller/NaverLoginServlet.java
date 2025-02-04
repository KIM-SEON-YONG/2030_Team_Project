package com.TTteamProject.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NaverLoginServlet")
public class NaverLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String CLIENT_ID = "2S5dv8uJFdmdx0ucmg8H";
    private static final String REDIRECT_URI = "http://localhost:8081/2030_Team_Project/NaverCallbackServlet";
    private static final String STATE = "RANDOM_STRING"; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                        + "&client_id=" + CLIENT_ID
                        + "&redirect_uri=" + REDIRECT_URI
                        + "&state=" + STATE;

        response.sendRedirect(loginUrl);
    }
}
