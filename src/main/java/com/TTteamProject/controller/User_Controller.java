package com.TTteamProject.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class User_Controller {

		// 1. 드라이버 로딩
		// 2. DB연결
		// 3. sql 문장전송
		// 4. 객체 반납

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int result = 0;

		// 1. 드라이버 및 DB연결

		public void Main() {

			try {

				Class.forName("oracle.jdbc.driver.OracleDriver");
				// url
				String url = "project-db-cgi.smhrd.com:1524:xe";
				// id
				String id = "mp_24K_bigdata28_p2_3";
				// pw
				String pw = "smhrd3";

				conn = DriverManager.getConnection(url, id, pw);
				if (conn != null) {
					System.out.println("연결성공");
				} else {
					System.out.println("연결실패");
				}

			} catch (ClassNotFoundException e) {

				e.printStackTrace();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}

		
		
		
		
		
		

	}

