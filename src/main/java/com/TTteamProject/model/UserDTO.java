package com.TTteamProject.model;

public class UserDTO {
	
	 	private String Id;
	    private String Pw;
	    private String Name;
	    private String Birthdate;
	    private String Gender;
	    private int Phone;
	    
	  

	    // Getter
	    public String getId() {
	    	return Id;
	    }
	    public String getPw() {
	    	return Pw;
	    }
	    public String getName() {
	    	return Name;
	    }
	    public String getBirthdate() {
	    	return Birthdate;
	    }
	    public String getGender() {
	    	return Gender;
	    }
	    public int getPhone() {
	    	return Phone;
	    }
	    
	    //Setter 메서드
	    public void setId(String id) {
	    	Id = id;
	    }
	    public void setPw(String pw) {
	    	Pw = pw;
	    }
	    public void setName(String name) {
	    	Name = name;
	    }
	    public void setBirthdate(String birthdate) {
	    	Birthdate = birthdate;
	    }
	    public void setGender(String gender) {
	    	Gender = gender;
	    }
	    public void setPhone(int phone) {
	    	Phone = phone;
	    }
	    
	    
	
	    
}
