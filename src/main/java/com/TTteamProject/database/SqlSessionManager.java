package com.TTteamProject.database;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionManager { 
	// 사용하고자 하는 DB의 기본정보(드라이버, url, id, pw)를 가지고
	// 여러개의 sqlSession을 생성할 수 있는 SqlSessionFactory를 생성하고
	// 관리할 수 있는 클래스
   public static SqlSessionFactory sqlSessionFactory;
   		// static : 서버가 실행 될 때, 딱 1번 읽어서 사용하는 구간
   		// static {} 초기화 블럭 문법 -> main()메서드가 시작되자마자 같이 호출되는 구조!
   static {
      String resource = "com/TTteamProject/database/mybatis-config.xml";
      Reader reader;
      try {
         reader = Resources.getResourceAsReader(resource);

         sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
      } catch (IOException e) {
         e.printStackTrace();
      }
   }
   
   // 다른 클래스에서 sqlSessionFactory를 호출할 수 있는 메서드
   public static SqlSessionFactory getSqlSession() {
      return sqlSessionFactory;
   }
}
