package com.TTteamProject.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.TTteamProject.controller.MyBatisUtil;
import com.TTteamProject.database.SqlSessionManager;
import com.TTteamProject.database.UserMapper;

public class UserDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	private Object dto;
	private Object user_id;

	// 회원정보
	public int joinList(UserDTO dto) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.insert("joinList", dto);
		sqlSession.close();
		return result;
	}

	// 로그인
	public UserDTO login(String user_id, String user_pw) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		UserDTO result = sqlSession.selectOne("login", user_id);
		sqlSession.close();
		return result;
	}

	// ID중복확인
	public UserDTO checkId(String user_id) {
		// 1. db에 접근 할 수 있는 sqlSeeeion생성
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		// 2. mapper의 check id를 가진 sql쿼리문 실행
		UserDTO result = sqlSession.selectOne("checkId", user_id);
		// 3. sqlSession 반납
		sqlSession.close();
		// 4. 결과값 리턴
		return result;

	}

	// 단일조회
	public UserDTO loginCheck(String user_id, String user_pw) {
		// 1. db에 접근 할 수 있는 sqlSeeeion생성
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		// DB에서 사용자 정보 조회
		UserDTO user = sqlSession.selectOne("loginCheck", user_id);
		
		sqlSession.close();
		
		return user; // 로그인 성공
	}

	// 회원정보수정
	public boolean updateUser(UserDTO updateUser) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true); // 자동 커밋 옵션을 활성화
		
		// 업데이트 쿼리 실행
		int rowsAffected = sqlSession.update("updateUser", updateUser);
		
		sqlSession.close();
		
		// rowsAffected가 1이상이면 성공으로 간주, 아니면 실행
		return rowsAffected > 0; // 업데이트된 행의 수가 1이상이면 true, 아니면 false
	}
	
	/*
	 * public boolean updateUser(UserDTO updatedUser) { // SqlSession을 통해 데이터베이스와 연결
	 * try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession()) {
	 * // UserMapper를 통해 실제 쿼리 메소드 호출 UserMapper mapper =
	 * session.getMapper(UserMapper.class); int result =
	 * mapper.updateUser(updatedUser);
	 * 
	 * // 회원 정보 업데이트 실행 if (result > 0) { session.commit(); // 성공 시 트랜잭션 커밋 return
	 * true; } else { session.rollback(); // 실패 시 롤백 return false; } } catch
	 * (Exception e) { e.printStackTrace(); return false; } }
	 */
	
	
 
	// 회원탈퇴
	public int Delete(String user_id, String user_pw) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.insert("Delete", dto);
		sqlSession.close();
		return result;
	}

	// 마이페이지 정보 가져오기
    public UserDTO getUserInfo(String user_id) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
            return sqlSession.selectOne("getUserInfo", user_id);
        }
    }
	
    public UserDTO getUserByEmail(String email) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        UserDTO user = null;

        try {
            user = sqlSession.selectOne("UserMapper.getUserByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return user;
    }

    // Google 사용자 자동 회원가입
    public int registerGoogleUser(UserDTO user) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int result = 0;

        try {
            result = sqlSession.insert("UserMapper.registerGoogleUser", user);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }

    public int registerNaveruser(UserDTO user) {
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int result = 0;

        try {
            result = sqlSession.insert("UserMapper.registerNaverUser", user);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }
    
    

 // 아이디 찾기 (이름과 전화번호로 이메일 찾기)
    public UserDTO findEmailByNameAndPhone(String user_name, String user_phone) {
        try (SqlSession sqlSession = sqlSessionFactory.openSession(true)) {
        	 // user_name, user_phone에 대해 null 체크 추가
            if (user_name == null || user_phone == null) {
                throw new IllegalArgumentException("user_name or user_phone cannot be null");
            }
            
            UserDTO user = new UserDTO();
            user.setUser_name(user_name);
            user.setUser_phone(user_phone);

            UserDTO result = sqlSession.selectOne("com.TTteamProject.database.UserMapper.findEmailByNameAndPhone", user);
            return result;
        }
    }

    // 패스워드 이메일로 찾기
	    public UserDTO setPassword(String user_email) {
	    	// DB에서 이메일로 사용자 검색 후 반환
	        // 예시: SELECT * FROM users WHERE email = ?
	    }
	    
	    // 비밀번호 업데이트
	    public void updatePassword(String email, String newPassword) {
	        // DB에서 사용자의 비밀번호를 생년월일로 업데이트
	        // 예시: UPDATE users SET password = ? WHERE email = ?
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        try {
	            // DB 연결 및 비밀번호 업데이트 쿼리 실행
	            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	            String sql = "UPDATE users SET password = ? WHERE email = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, newPassword); // 생년월일을 비밀번호로 설정
	            pstmt.setString(2, email);       // 이메일로 해당 사용자 찾기
	            pstmt.executeUpdate();           // 쿼리 실행
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            // 자원 정리
	            try {
	                if (pstmt != null) pstmt.close();
	                if (conn != null) conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}