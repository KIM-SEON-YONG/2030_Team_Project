package com.TTteamProject.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

public class RegionDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	public List<RegionDTO> regionList(){
		
		SqlSession sqlSession =sqlSessionFactory.openSession(true);
		
		List<RegionDTO> results = sqlSession.selectList("regionList");
		
		sqlSession.close();
		return results;
	}
	
	
	
	
	
	
	
	
	
	
}
