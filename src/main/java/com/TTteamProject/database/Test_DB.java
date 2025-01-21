package com.TTteamProject.database;

import java.sql.Connection;
import java.sql.SQLException;

public class Test_DB {

	public static void main(String[] args) {
        try {
            Connection conn = DB_Connection.getConnection();
            if (conn != null) {
                System.out.println("데이터베이스 연결 성공!");
                conn.close(); // 연결 종료
            } else {
                System.out.println("데이터베이스 연결 실패!");
            }
        } catch (SQLException e) {
            System.err.println("SQLException 발생: " + e.getMessage());
        }
    }

}
