package com.example.VO;

public class MemberVO {
	
	private String userid;
	private String contents;
	
	public String getUserid() {
		return userid;
	}
	public String getContents() {
		return contents;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	@Override
	public String toString() {
		return "MemberVO [userid=" + userid + ", contents=" + contents + "]";
	}
	
	

}
