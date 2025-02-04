package com.TTteamProject.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

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
		// 비밀번호 비교
		if (user != null && user.getUser_pw().equals(user_pw)) {
			return user; // 로그인 성공
		}
		return null; // 로그인 실패
	}

	// 회원정보수정
	public boolean Update(UserDTO updatedUser) {
		 // SqlSession을 통해 데이터베이스와 연결
        try (SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession()) {
            // UserMapper를 통해 실제 쿼리 메소드 호출
            UserMapper mapper = session.getMapper(UserMapper.class);
            int result = mapper.updateUser(updatedUser);

            // 회원 정보 업데이트 실행
            if (result > 0) {
                session.commit();  // 성공 시 트랜잭션 커밋
                return true;
            } else {
                session.rollback();  // 실패 시 롤백
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

 
	// 회원탈퇴
	public int Delete(String user_id, String user_pw) {
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		int result = sqlSession.insert("Delete", dto);
		sqlSession.close();
		return result;
	}

	// 마이페이지 정보 가져오기(DB)
	public UserDTO getUserInfo(String user_id) {
			SqlSession sqlSession = sqlSessionFactory.openSession(true);
			UserDTO user = null;
			
			 try {
			        System.out.println("DB 조회 시작, user_id: " + user_id); // 디버깅용 로그
			        user = sqlSession.selectOne("UserMapper.getUserInfo", user_id);
			        System.out.println("DB 조회 결과: " + user); // 디버깅용 로그
			    } catch (Exception e) {
			        e.printStackTrace();
			    } finally {
			        sqlSession.close();
			    }
			    
			    return user;
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

    // 아이디 찾기
	public UserDTO findEmailByNameAndPhone(String user_name, String user_phone) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		UserDTO user = null;
		
		 try {
			 // UserDTO 객체 생성 및 값 설정
	            UserDTO searchUser = new UserDTO();
	            searchUser.setUser_name(user_name);
	            searchUser.setUser_phone(user_phone);
			 user = sqlSession.selectOne("UserMapper.findEmailByNameAndPhone", new UserDTO(user_name, user_phone));
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            sqlSession.close();
	        }
	        return user;
	    }

	
	// 패스워드 찾기
	public String findPasswordByEmail(String user_email) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		String password = null;
		return password;
		
	}

}
