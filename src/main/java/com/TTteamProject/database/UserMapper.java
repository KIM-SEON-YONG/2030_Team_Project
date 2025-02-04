package com.TTteamProject.database;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.TTteamProject.model.UserDTO;

public interface UserMapper {
	 int updateUser(UserDTO updatedUser);
	 
     // 예시로 사용자 목록을 가져오는 메서드
     List<UserDTO> joinList(@Param("criteria") String criteria);


	 
	 
	// 이메일로 사용자 정보를 찾아 비밀번호를 갱신하는 메서드
	    void updatePassword(@Param("email") String email, @Param("newPassword") String newPassword);
	
	    
	    
	}