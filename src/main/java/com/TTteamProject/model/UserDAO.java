package com.TTteamProject.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

public class UserDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	
	// 회원정보 
		public int register(UserDTO dto) {
		    int result = 0;  // 기본값 설정
		    SqlSession sqlSession = sqlSessionFactory.openSession(true);
		    
		    try {
		        result = sqlSession.insert("UserMapper.register", dto);  // 실제 INSERT SQL 실행
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        sqlSession.close();
		    }
		    
		    return result;  // 영향받은 행 수 반환
		}





	
	
	// 로그인
	
	// 회원탈퇴
	
	// 회원정보수정
	
	
	
	    
}
