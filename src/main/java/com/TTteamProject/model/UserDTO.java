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
	    private String user_pw;           // 비밀번호
	    private String user_name;         // 사용자 이름
	    private String user_birthdate;      // 생년월일
	    private String user_gender;       // 성별
	    private String user_phone;        // 전화번호
	    private String fav_welfare;       // 선호 복지
	    private String fav_region;        // 선호 지역
	    
	    
	    // 로그인
	  		public UserDTO(String user_id, String user_pw) {
			super();
			this.user_id = user_id;
			this.user_pw = user_pw;
		}
	    
	    
}


