/*
 * package com.TTteamProject.listener;
 * 
 * import java.io.InputStream;
 * 
 * import javax.servlet.ServletContextEvent; import
 * javax.servlet.ServletContextListener;
 * 
 * import org.apache.ibatis.io.Resources; import
 * org.apache.ibatis.session.SqlSessionFactory; import
 * org.apache.ibatis.session.SqlSessionFactoryBuilder;
 * 
 * // 이페이지는 취업지원 페이지 새로고침하면 input창 클릭시 모달창 안뜨는 현상때문에 만든거라서 나중에 // 해당 페이지로 작업하지
 * 않아도 된다면 삭제처리 // web.xml 에 등록한 내용도 삭제 //<listener>
 * //<listener-class>com.TTteamProject.listener.MyAppContextListener</listener-
 * class> //</listener> public class MyAppContextListener implements
 * ServletContextListener {
 * 
 * @Override public void contextInitialized(ServletContextEvent sce) { try {
 * String resource = "mybatis-config.xml"; // MyBatis 설정 파일 경로 InputStream
 * inputStream = Resources.getResourceAsStream(resource); SqlSessionFactory
 * sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
 * sce.getServletContext().setAttribute("sqlSessionFactory", sqlSessionFactory);
 * System.out.println("SqlSessionFactory 초기화 성공."); } catch (Exception e) {
 * e.printStackTrace(); System.out.println("SqlSessionFactory 초기화 실패."); } }
 * 
 * @Override public void contextDestroyed(ServletContextEvent sce) { // 필요 시 자원
 * 해제 } }
 */