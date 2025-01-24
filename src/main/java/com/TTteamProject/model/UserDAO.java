package com.TTteamProject.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

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
			UserDTO result = sqlSession.selectOne("checkId",user_id);
			// 3. sqlSession 반납
			sqlSession.close();				
			// 4. 결과값 리턴
			return result;
			
		}

	// 단일조회
		public UserDTO loginCheck(String user_id,String user_pw) {
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
	
	// 회원탈퇴
		



		
		
	
	
	
	    
}
