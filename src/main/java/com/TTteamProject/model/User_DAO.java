package com.TTteamProject.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.TTteamProject.database.DB_Connection;

public class User_DAO {
	
	public void addUser(User_VO user) {
        try (Connection conn = DB_Connection.getConnection()) {
            String sql = "INSERT INTO TB_USER (USER_ID, USER_PW, USER_NAME, USER_BIRTHDATE, USER_GENDER, USER_PHONE) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, user.getId());
                pstmt.setString(2, user.getPw());
                pstmt.setString(3, user.getName());
                pstmt.setString(4, user.getBirthdate());
                pstmt.setString(5, user.getGender());
                pstmt.setInt(6, user.getPhone());
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
