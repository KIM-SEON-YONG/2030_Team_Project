package com.TTteamProject.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

public class UserDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	private Object dto;

	
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
		public boolean checkId(String user_id) {
			if (user_id == null || user_id.trim().isEmpty()) {
		        // 아이디가 null이거나 빈 값일 경우 처리
		        return false;  // 중복도 아니라고 처리
		    }

		    SqlSession sqlSession = sqlSessionFactory.openSession(true);
		    try {
		        int count = sqlSession.selectOne("checkId", user_id);
		        return count > 0;  // 중복된 아이디가 있으면 true, 없으면 false
		    } finally {
		        sqlSession.close();  // 리소스 반환
		    }
		}
		
	
	// 회원탈퇴
	
	// 회원정보수정
	
	
	
	    
}
