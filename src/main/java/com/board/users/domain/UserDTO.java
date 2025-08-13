package com.board.users.domain;

// 어노테이션 없는 유일한 클래스
public class UserDTO {
	private String userid;
	private int    passwd;
	private String username;
	private String email;
	private String upoint;
	private String grade;
	private String indate;
	
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getPasswd() {
		return passwd;
	}

	public void setPasswd(int passwd) {
		this.passwd = passwd;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUpoint() {
		return upoint;
	}

	public void setUpoint(String upoint) {
		this.upoint = upoint;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getIndate() {
		return indate;
	}

	public void setIndate(String indate) {
		this.indate = indate;
	}

	public UserDTO() {}
	
	
	
	public UserDTO(String userid, int passwd, String username, String email, String upoint, String grade, String indate) {
		this.userid = userid;
		this.passwd = passwd;
		this.username = username;
		this.email = email;
		this.upoint = upoint;
		this.grade = grade;
		this.indate = indate;
	}

	@Override
	public String toString() {
		return "UserDTO [userid=" + userid + ", passwd=" + passwd + ", username=" + username + ", email=" + email
				+ ", upoint=" + upoint + ", grade=" + grade + ", indate=" + indate + "]";
	}

	
	
	
	
	
	
}
