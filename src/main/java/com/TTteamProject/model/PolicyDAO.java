package com.TTteamProject.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

public class PolicyDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	

	// 여기까지
	
	public List<PolicyDTO> jobList() {
		 SqlSession sqlSession = sqlSessionFactory.openSession(true);
		 
		 List<PolicyDTO> jobList = sqlSession.selectList("jobList");
		 
		 sqlSession.close();
		 return jobList;
		 
	}
	
	// AJAX 검색을 위한 메서드
	public List<PolicyDTO> selecJobList(List<String> regionSplit) {
		
		// DB에 접근할 수 있도록 하는 권한(입장권)인 SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<PolicyDTO> selecJobList = sqlSession.selectList("selecJobList", regionSplit);

		System.out.println("DB접근 후:" + selecJobList);

		sqlSession.close();
		return selecJobList;
		
		
	}

}
