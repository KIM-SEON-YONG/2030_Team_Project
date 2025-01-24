package com.TTteamProject.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.TTteamProject.database.SqlSessionManager;

public class BoardDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public List<BoardDTO> boardList() {
		
		System.out.print("DAO접속!!!");
		// DB에 접근할 수 있도록 하는 권한(입장권)인 SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<BoardDTO> result = sqlSession.selectList("boardList");

		System.out.print("DB접근 후:" + result);

		sqlSession.close();
		return result;
	}
    public int insertBoard(BoardDTO dto) {
        int result = 0;
        try (SqlSession session = SqlSessionManager.getSqlSession().openSession()) {
            result = session.insert("com.TTteamProject.database.boardMapper.insertAllboard", dto);
            session.commit(); // INSERT/UPDATE/DELETE 후에는 commit() 필요
        }
        return result;
    }
    public BoardDTO getBoard(int b_idx) {
    	SqlSession sqlSession = sqlSessionFactory.openSession(true);
    	BoardDTO dto = sqlSession.selectOne("selectOneboard", b_idx);
    	sqlSession.close();
    	return dto;	
    	
    }
}
