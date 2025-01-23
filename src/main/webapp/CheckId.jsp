<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.TTteamProject.model.UserDAO"%>
<%@ page import="com.TTteamProject.model.UserDTO"%>
<%
    String user_id = request.getParameter("user_id"); // 클라이언트에서 전달된 아이디
    UserDAO userDAO = new UserDAO();
    boolean isDuplicate = userDAO.checkId(user_id); // 아이디 중복 확인
    
    if (isDuplicate) {
        request.setAttribute("id_check_msg", "이미 존재하는 아이디입니다."); // 중복 아이디 메시지 설정
    } else {
        request.setAttribute("id_check_msg", "사용 가능한 아이디입니다."); // 사용 가능한 아이디 메시지 설정
    }
    
    request.setAttribute("user_id", user_id); // 입력한 아이디를 계속 전달
    request.getRequestDispatcher("join.jsp").forward(request, response); // 회원가입 페이지로 포워딩
%>
