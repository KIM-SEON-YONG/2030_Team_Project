package com.TTteamProject.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

public class WelfareDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public List<WelfareDTO> selectJob() {
		
		System.out.print("DAO접속!!!");
		// DB에 접근할 수 있도록 하는 권한(입장권)인 SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<WelfareDTO> result = sqlSession.selectList("jobList");

		System.out.print("DB접근 후:" + result);

		sqlSession.close();
		return result;
	}

}
