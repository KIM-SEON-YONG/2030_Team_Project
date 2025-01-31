package com.TTteamProject.controller;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;

public class MyBatisUtil {
    // SqlSessionFactory 객체를 하나만 생성하여 여러 DAO에서 공유합니다.
    private static SqlSessionFactory sqlSessionFactory;

    // static 초기화 블록을 사용하여 한 번만 초기화됩니다.
    static {
        try {
            // mybatis-config.xml 파일 경로 확인
            String resource = "mybatis-config.xml";  // "resources" 폴더에 위치한 mybatis-config.xml 파일
            Reader reader = Resources.getResourceAsReader(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            e.printStackTrace();  // 오류 발생 시 스택 추적 출력
        }
    }

    public static SqlSessionFactory getSqlSessionFactory() {
        if (sqlSessionFactory == null) {
            throw new IllegalStateException("SqlSessionFactory가 초기화되지 않았습니다.");
        }
        return sqlSessionFactory;
    }
}