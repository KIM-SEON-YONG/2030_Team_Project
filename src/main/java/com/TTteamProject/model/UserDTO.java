package com.TTteamProject.model;


import org.apache.ibatis.reflection.SystemMetaObject;

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
	    private int wel_point;        // 복지포인트
	    private int postCount; // 예시로 게시글 수를 저장하는 필드
	    
	    
	    
	    // 로그인
	  		public UserDTO(String user_id, String user_pw) {
			super();
			this.user_id = user_id;
			this.user_pw = user_pw;
		}

	  	    // Google 로그인용 생성자 추가
	  	    public UserDTO(String user_email, String user_pw, String user_name) {
	  	        this.user_id = user_email;
	  	        this.user_pw = user_pw;  // Google 로그인 계정은 비밀번호 없음 → "GOOGLE_LOGIN"
	  	        this.user_name = user_name;
	  	    }

	  	// 로그인할때(id/pw확인)
			public UserDTO loginCheck(String user_id, String user_pw) {
				// TODO Auto-generated method stub
				return null;
			}



	  	// 회원정보수정할때
			public boolean Update(String user_id, UserDTO updatedUser) {
				// UserDAO 객체 또는 MyBatis mapper를 통해 업데이트 쿼리 실행
			    UserDAO userDAO = new UserDAO();

			    // UserDAO의 update 메서드 호출 (UserDTO 객체를 넘겨서 업데이트 진행)
			    boolean updateSuccess = userDAO.Update(updatedUser);

			    if (updateSuccess) {
			        // 업데이트가 성공하면 true 반환
			        return true;
			    } else {
			        // 업데이트 실패 시 false 반환
			        return false;
			    }
		
			}
		
		// 로그인 후 마이페이지에 DB정보 끌어오기
			public  UserDTO user(String user_id) {
				return null;
			}
			
		
			
		// 전화번호를 반환하는 메서드 추가
	    public String getUserPhone() {
	        return user_phone;
	    }
	
			

	 // 복지 포인트가 int 형이라면
	    public int getUserPoints() {
	            return wel_point; // 숫자 형식 오류 시 0 반환
	        }
	  
	    
	   
	// 선호 지역(fav_region)을 반환하는 메서드 추가
		public String getUser_fav_region() {
		    return fav_region;
		}

	
	// 선호 복지(fav_welfare)를 반환하는 메서드 추가
	    public String getUser_fav_welfare() {
	        return fav_welfare;
	    }

	    


}
	    