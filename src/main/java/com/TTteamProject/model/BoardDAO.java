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
    public BoardDTO getBoard(int b_idx) { // BoardDAO 클래스에 추가
    	SqlSession sqlSession = sqlSessionFactory.openSession(true);
    	BoardDTO dto = sqlSession.selectOne("selectOneboard", b_idx);
    	sqlSession.close();
    	return dto;	
    	
    }
    public List<BoardDTO> getUserBoards(String userId) { // 사용자 ID에 해당하는 게시글 목록 조회
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        List<BoardDTO> result = sqlSession.selectList("getUserBoards", userId); 
        sqlSession.close();
        return result;
    }
    public int getPostCountByUserId(String userId) {// 사용자가 작성한 게시글 수를 반환하는 메서드
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        int postCount = sqlSession.selectOne("getPostCountByUserId", userId);  // MyBatis 쿼리
        sqlSession.close();
        return postCount;
    }
    public int updateBoard(BoardDTO dto) {// 게시글 수정
        int result = 0;
        try (SqlSession session = SqlSessionManager.getSqlSession().openSession()) {// 게시글 수정 메서
            result = session.update("com.TTteamProject.database.boardMapper.updateBoard", dto);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public int deleteBoard(int b_idx) {//게시글 삭제 메서드
        int result = 0;
        try (SqlSession session = SqlSessionManager.getSqlSession().openSession()) {
            result = session.delete("com.TTteamProject.database.boardMapper.deleteBoard", b_idx);
            session.commit(); // 변경사항 적용
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
    
    
    
    

