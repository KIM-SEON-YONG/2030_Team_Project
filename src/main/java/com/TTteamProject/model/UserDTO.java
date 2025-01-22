package com.TTteamProject.model;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
// 회원정보
public class UserDTO {
	
	    private String user_id;           // 사용자 ID 기본키
	    private String user_Pw;           // 비밀번호
	    private String user_Name;         // 사용자 이름
	    private String user_Birthdate;      // 생년월일
	    private String user_Gender;       // 성별
	    private String user_Phone;        // 전화번호
	    private String fav_Welfare;       // 선호 복지
	    private String fav_Region;        // 선호 지역
	    private String join_Dt;             // 가입 날짜
	    private int welfare_Point;        // 복지 포인트

	    
	  

	    
}
