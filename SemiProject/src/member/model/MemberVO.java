package member.model;

import java.util.Calendar;

public class MemberVO {
	
	private String userid; 				// 유저아이디
	private String pwd;					// 비밀번호
	private String name;				// 이름
	private String email;				// 이메일
	private String mobile;				// 핸드폰
	private String postcode;			// 우편번호
	private String address;				// 주소
	private String detailaddress;		// 상세주소
	private String extraaddress;		// 추가주소
	private String gender;				// 성별
	private String birthday;			// 생일
	private String referral;			// 추천인
	private int point;					// 포인트
	private String registerday;			// 가입일자
	private String lastpwdchangedate;	// 비번변경일자
	private int status;					// 회원상태  1(사용가능) 0(탈퇴)
	private int idle;					// 휴면유무  0(활동중)  1(휴면처리)
	
	
	private int age; // 회원 상세조회용입니다.
	
	
	public String getUserid() {
		return userid;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getPwd() {
		return pwd;
	}
	
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getPostcode() {
		return postcode;
	}
	
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getDetailaddress() {
		return detailaddress;
	}
	
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	
	public String getExtraaddress() {
		return extraaddress;
	}
	
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	
	public String getGender() {
		return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;

		
	}
	
	public String getBirthday() {
		return birthday;
	}
	
	public void setBirthday(String birthday) { // 생년월일에서 연도만 알면 나이를 알 수 있습니다.
		this.birthday = birthday;
		
		
		Calendar now = Calendar.getInstance(); // 현재날짜와 시간을 얻어온다.
		int currentYear = now.get(Calendar.YEAR); // 현재년도를 얻어온다.
		
		String strBirthYear = birthday.substring(0, 4);
		int birthYear = Integer.parseInt(strBirthYear);
		
		this.age = currentYear - birthYear + 1;
		
	}
	
	public String getReferral() {
		return referral;
	}
	
	public void setReferral(String referral) {
		this.referral = referral;
	}
	
	public int getPoint() {
		return point;
	}
	
	public void setPoint(int point) {
		this.point = point;
	}
	
	public String getRegisterday() {
		return registerday;
	}
	
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	
	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}
	
	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}
	
	public int getStatus() {
		return status;
	}
	
	public void setStatus(int status) {
		this.status = status;
	}
	
	public int getIdle() {
		return idle;
	}
	
	public void setIdle(int idle) {
		this.idle = idle;
	}

	public int getAge() { // 생년월일을 이용해서 나이를 얻어옵니다.
		return age;
	}
	
	
	
}
