package com.TTteamProject.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DB_Connection {


		// 1. 드라이버 및 DB연결

		public static Connection getConnection() throws SQLException {
			Connection conn = null;
			
				try {
					Class.forName("oracle.jdbc.driver.OracleDriver");
					
					// url
					String url = "jdbc:oracle:thin:@project-db-cgi.smhrd.com:1524:xe";
					// id
					String id = "mp_24K_bigdata28_p2_3";
					// pw
					String pw = "smhrd3";
					
					conn = DriverManager.getConnection(url, id, pw);
					
				} catch (ClassNotFoundException e) {
		            System.err.println("JDBC 드라이버 로드 실패: " + e.getMessage());
		        } catch (SQLException e) {
		            System.err.println("DB 연결 실패: " + e.getMessage());
		            throw e; // SQLException 다시 던지기
		        }

		        return conn;

		}
	}