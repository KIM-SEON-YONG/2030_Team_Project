package com.TTteamProject.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

public class PolicyDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	
	// 취업 기본 페이지
	public List<PolicyDTO> jobList() {
		 SqlSession sqlSession = sqlSessionFactory.openSession(true);
		 
		 List<PolicyDTO> jobList = sqlSession.selectList("jobList");
		 
		 sqlSession.close();
		 return jobList;
		 
	}
	
	// 결혼 기본 페이지
	public List<PolicyDTO> weddingList() {
		 SqlSession sqlSession = sqlSessionFactory.openSession(true);
		 
		 List<PolicyDTO> weddingList = sqlSession.selectList("weddingList");
		 
		 sqlSession.close();
		 return weddingList;
		 
	}
	
	
	// 출산 기본 페이지
	public List<PolicyDTO> pregList() {
		 SqlSession sqlSession = sqlSessionFactory.openSession(true);
		 
		 List<PolicyDTO> pregList = sqlSession.selectList("pregList");
		 
		 sqlSession.close();
		 return pregList;
		 
	}
	
	// AJAX 검색을 위한 메서드
	
	public List<PolicyDTO> selecJobList(List<String> regionList) {
		
		// DB에 접근할 수 있도록 하는 권한(입장권)인 SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<PolicyDTO> selecJobList = sqlSession.selectList("selecJobList", regionList);

		System.out.println("DB접근 후:" + selecJobList);

		sqlSession.close();
		return selecJobList;
		
		
	}

	public List<PolicyDTO> selecWeddingList(List<String> regionList) {
		
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		List<PolicyDTO> selecWeddingList = sqlSession.selectList("selecWeddingList", regionList);
		
		System.out.println("DB접근 후:" + selecWeddingList);
		
		sqlSession.close();
		return selecWeddingList;
	}

	public List<PolicyDTO> selecPregList(List<String> regionList) {
		
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		List<PolicyDTO> selecPregList = sqlSession.selectList("selecPregList", regionList);
		System.out.println("DB접근 후:" + selecPregList);
		
		sqlSession.close();
		return selecPregList;
	}

}
