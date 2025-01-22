package com.TTteamProject.Frontcontroller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Command {

	
	// Frontcontroller 각각의 객체 생성은 따로 진행
	// 같은 타입의 이름으로 부르기 위해 작업하는 공간
	
	// joinProgram -> join.execute(); -> command.execte();
	// LoginProgram -> Login.execute(); -> command.execte();
	// WriteProgram -> Write.execute(); -> command.execte();
	// UpdateProgram -> Update.execute(); -> command.execte();
	
	// 인테페이스 : 인터페이스를 구현하는 모든 클래스는 일련의 규칙을 강제화
	// -> 인터페이스에 정의된 부분은 구현하는 모든 클래스에서 강제로 구현해야 함
	
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException ;
	// 인터페이스에서는 추상적인 코드가 구현됨
	
	
	
	
	
	
}
