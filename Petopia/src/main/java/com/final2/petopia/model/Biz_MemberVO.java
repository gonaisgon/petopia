package com.final2.petopia.model;

import org.springframework.stereotype.Repository;

@Repository
public class Biz_MemberVO {
	
	private int idx_biz;  // 병원/약국고유번호
	private String name;  // 기업명
	private int biztype; // 기업구분
	private String repname;    // 대표자명
	private String biznumber;   // 사업자번호
	private String phone;  // 연락처
	private String postcode;    // 우편번호
	private String addr1;       // 주소
	private String addr2;      // 주소2
	private int latitude;    // 위도
	private int longitude;   // 경도
	private String prontimg;   // 대표이미지
	private String weekday;   // 평일
	private String wdstart;    // 평일시작시간
	private String wdend;     // 평일종료시간
	private String lunchstart;  // 점심시작시간
	private String lunchend;    // 점심종료시간
	private String satstrart;   // 토요일시작
	private String satend;      // 토요일종료
	private String dayoff;      // 일요일/공휴일
	private int dog;         // 강아지
	private int cat;         // 고양이
	private int smallani;    // 소동물
	private int etc;         // 기타
	private String note;       // 특이사항
	private String intro;      // 소개글
	
	public Biz_MemberVO() { }
	
	public Biz_MemberVO(int idx_biz, String name, int biztype, String repname, String biznumber, String phone,
			String postcode, String addr1, String addr2, int latitude, int longitude, String prontimg, String weekday,
			String wdstart, String wdend, String lunchstart, String lunchend, String satstrart, String satend,
			String dayoff, int dog, int cat, int smallani, int etc, String note, String intro) {

		this.idx_biz = idx_biz;
		this.name = name;
		this.biztype = biztype;
		this.repname = repname;
		this.biznumber = biznumber;
		this.phone = phone;
		this.postcode = postcode;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.latitude = latitude;
		this.longitude = longitude;
		this.prontimg = prontimg;
		this.weekday = weekday;
		this.wdstart = wdstart;
		this.wdend = wdend;
		this.lunchstart = lunchstart;
		this.lunchend = lunchend;
		this.satstrart = satstrart;
		this.satend = satend;
		this.dayoff = dayoff;
		this.dog = dog;
		this.cat = cat;
		this.smallani = smallani;
		this.etc = etc;
		this.note = note;
		this.intro = intro;
	}

	public int getIdx_biz() {
		return idx_biz;
	}

	public void setIdx_biz(int idx_biz) {
		this.idx_biz = idx_biz;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getBiztype() {
		return biztype;
	}

	public void setBiztype(int biztype) {
		this.biztype = biztype;
	}

	public String getRepname() {
		return repname;
	}

	public void setRepname(String repname) {
		this.repname = repname;
	}

	public String getBiznumber() {
		return biznumber;
	}

	public void setBiznumber(String biznumber) {
		this.biznumber = biznumber;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public int getLatitude() {
		return latitude;
	}

	public void setLatitude(int latitude) {
		this.latitude = latitude;
	}

	public int getLongitude() {
		return longitude;
	}

	public void setLongitude(int longitude) {
		this.longitude = longitude;
	}

	public String getProntimg() {
		return prontimg;
	}

	public void setProntimg(String prontimg) {
		this.prontimg = prontimg;
	}

	public String getWeekday() {
		return weekday;
	}

	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}

	public String getWdstart() {
		return wdstart;
	}

	public void setWdstart(String wdstart) {
		this.wdstart = wdstart;
	}

	public String getWdend() {
		return wdend;
	}

	public void setWdend(String wdend) {
		this.wdend = wdend;
	}

	public String getLunchstart() {
		return lunchstart;
	}

	public void setLunchstart(String lunchstart) {
		this.lunchstart = lunchstart;
	}

	public String getLunchend() {
		return lunchend;
	}

	public void setLunchend(String lunchend) {
		this.lunchend = lunchend;
	}

	public String getSatstrart() {
		return satstrart;
	}

	public void setSatstrart(String satstrart) {
		this.satstrart = satstrart;
	}

	public String getSatend() {
		return satend;
	}

	public void setSatend(String satend) {
		this.satend = satend;
	}

	public String getDayoff() {
		return dayoff;
	}

	public void setDayoff(String dayoff) {
		this.dayoff = dayoff;
	}

	public int getDog() {
		return dog;
	}

	public void setDog(int dog) {
		this.dog = dog;
	}

	public int getCat() {
		return cat;
	}

	public void setCat(int cat) {
		this.cat = cat;
	}

	public int getSmallani() {
		return smallani;
	}

	public void setSmallani(int smallani) {
		this.smallani = smallani;
	}

	public int getEtc() {
		return etc;
	}

	public void setEtc(int etc) {
		this.etc = etc;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}
	
}
