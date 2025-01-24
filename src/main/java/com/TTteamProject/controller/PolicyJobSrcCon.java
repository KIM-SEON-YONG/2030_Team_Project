package com.TTteamProject.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TTteamProject.model.PolicyDAO;
import com.TTteamProject.model.PolicyDTO;
import com.google.gson.Gson;

@WebServlet("/PolicyJobSrcCon")
public class PolicyJobSrcCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. request 객체에서 데이터 가져오기
		String regionParam = request.getParameter("regionInput");
		System.out.println("원데이터 개수확인: "+ regionParam.length());
		
		// 지역데이터 값이 있으면 쉼표를 기준으로 split
		String[] regionSplit= regionParam != null ? regionParam.split(",") : new String[0];
		
		// 요청받은 지역이 있는지 유무 확인
		if(regionParam.length() > 0) {
			// 한개의 input에 여러개의 값을 받았으므로 쉼표를 기준으로 나눠서 배열에 저장
			regionSplit = regionParam.split(",");

			System.out.println("regionSplit: "+ Arrays.toString(regionSplit));
			System.out.println("regionSplit: "+ regionSplit.length);
			

		}else{
			// 요청받은 지역이 없다면 alert창으로 띄워줘야함 - 썜한테 물어보기!
			request.setAttribute("alertMsg", "지역명을 선택해 주세요!");
			System.out.println("else if 문 들어옴:");
			
			RequestDispatcher rd = request.getRequestDispatcher("policy_job.jsp");
			rd.forward(request, response);
			return;
		}
		
		
		// DAO 호출
		PolicyDAO dao = new PolicyDAO();
		// 배열타입이었던 regionSplit를 List 형태로 형변환해줌(mapper의 parameterType을 List로 해줬기때문)
		List<String> regionList = Arrays.asList(regionSplit); 
		List<PolicyDTO> selecJobList = dao.selecJobList(regionList);
		
		
		// 결과처리 =>frontController 연결 시 redirect 형태로 변경해야됨
		HttpSession session = request.getSession();
		// 선택한 지역에 대한 복지혜택이 있는지 여부 확인
		if(selecJobList != null && !selecJobList.isEmpty()) {
			System.out.println("마지막 jsp 리턴하기전 배열개수:"+selecJobList.size());
			
				// JSON 변환 라이브러리 - GSON 사용
				Gson gson = new Gson();
				String json = gson.toJson(selecJobList);
				
				// 응답 타입 및 인코딩 설정
				response.setContentType("application/json; charset=UTF-8");
				
				// 실제로 JSON 문자열 출력
				PrintWriter out = response.getWriter();
				out.print(json);
				out.flush();
				
				// DB에서 가져온 값 확인용
				// for문 사용
//				for(int i=0; i< selecJobList.size(); i++) {
//					System.out.println("마지막 jsp로 리턴하기전:"+selecJobList.get(i).getWelfare_title());
//				}
//				// foreach문 사용
				for(PolicyDTO policy : selecJobList) {
					System.out.println("마지막 jsp로 리턴하기전: "+policy.getWelfare_title());
				}
				
			
				session.setAttribute("selecJobList", selecJobList);
			/* response.sendRedirect(); front 작성예정 */
			
		}else {
			
			// 리스트가 null이거나 비어있을 경우 빈 JSON 배열 반환
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("[]");
            out.flush();
			
			// jsp에 alert 창 띄워주기
//			request.setAttribute("jobAlertbMsg", "해당지역에는 복지혜택이 없습니다.");
			
		}
		
		
		// RegionDTO를 이용해서 지역명이랑 인덱스 -> 매칭해줌 아래 코드 필요없을 듯
		// 요청받은 지역명이 있는지 검사
//		boolean isValid = true; // 기본은 유효하다고 가정
//		if(regionArray != null) {
//			for(String region : regionParam) {
//				// "REGION_NAME 1"~ "REGION_NAME 5"만 유효하다고 가정
//				if(!region.equals("REGION_NAME 1") && !region.equals("REGION_NAME 2")
//						&& !region.equals("REGION_NAME 3")
//						&& !region.equals("REGION_NAME 4")
//						&& !region.equals("REGION_NAME 5")) {
//					isValid = false;
//					break;
//				}
//			}
//		}
//		// 만약 DB에 없는 지역이라면 alert창 띄우기
//		if(!isValid) {
//			model.addAttribute("alertMSG", "지역명을 입력해 주세요!");
//			return "alertPage"; // alertPage.jsp로 forward 
//		}
//		
//		// 지역명 -> 숫자 매핑을 위한 리스트
//		List<Integer> regionNumberList = new ArrayList<>();
//		if(regionArray != null) {
//			for(String region : regionArray) {
//				switch(region) {
//				case "REGION_NAME 1":
//					regionNumberList.add(1);
//					break;
//				case "REGION_NAME 2":
//					regionNumberList.add(2);
//					break;
//				case "REGION_NAME 3":
//					regionNumberList.add(3);
//					break;
//				case "REGION_NAME 4":
//					regionNumberList.add(4);
//					break;
//				case "REGION_NAME 5":
//					regionNumberList.add(5);
//					break;
//				default:
//					// 정의되지 않은 지역 문자열이 들어온 경우
//					break;
//				}
//			}
//		}
//		System.out.print("지역명숫자번호로매핑:"+regionNumberList);
		

		
	
		
	}

}
