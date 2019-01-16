package com.final2.petopia.model;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public class MemberVO {

   private int idx;            // 회원고유번호
   private String userid;         // 이메일아이디
   private String pwd;            // 비밀번호
   private String name;              // 이름
   private String nickname;         // 닉네임
   private String birthday;      // 생년월일
   private String gender;         // 성별
   private String phone;         // 연락처
   private String membertype;      // 회원타입
   private String fk_level_UID;   // 등급번호
   private int point;            // 포인트
   private int totaldeposit;      // 누적예치금
   private int noshow;            // 노쇼지수
   private String registerdate;   // 가입일자
   
   private String fileName;        // 톰캣에 저장될 프로필사진명
   private String orgFilename;     // 원본 프로필사진명
   private String fileSize;      // 파일 크기
   
   private MultipartFile profileimg; // 진짜 파일
   
   public MemberVO() {}

   public MemberVO(int idx, String userid, String pwd, String name, String nickname, String birthday, String gender,
         String phone, String membertype, String fk_level_UID, int point, int totaldeposit, int noshow,
         String registerdate, String fileName, String orgFilename, String fileSize, MultipartFile profileimg) {
      this.idx = idx;
      this.userid = userid;
      this.pwd = pwd;
      this.name = name;
      this.nickname = nickname;
      this.birthday = birthday;
      this.gender = gender;
      this.phone = phone;
      this.membertype = membertype;
      this.fk_level_UID = fk_level_UID;
      this.point = point;
      this.totaldeposit = totaldeposit;
      this.noshow = noshow;
      this.registerdate = registerdate;
      this.fileName = fileName;
      this.orgFilename = orgFilename;
      this.fileSize = fileSize;
      this.profileimg = profileimg;
   }

   public int getIdx() {
      return idx;
   }

   public void setIdx(int idx) {
      this.idx = idx;
   }

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

   public String getNickname() {
      return nickname;
   }

   public void setNickname(String nickname) {
      this.nickname = nickname;
   }

   public String getBirthday() {
      return birthday;
   }

   public void setBirthday(String birthday) {
      this.birthday = birthday;
   }

   public String getGender() {
      return gender;
   }

   public void setGender(String gender) {
      this.gender = gender;
   }

   public String getPhone() {
      return phone;
   }

   public void setPhone(String phone) {
      this.phone = phone;
   }

   public String getMembertype() {
      return membertype;
   }

   public void setMembertype(String membertype) {
      this.membertype = membertype;
   }

   public String getFk_level_UID() {
      return fk_level_UID;
   }

   public void setFk_level_UID(String fk_level_UID) {
      this.fk_level_UID = fk_level_UID;
   }

   public int getPoint() {
      return point;
   }

   public void setPoint(int point) {
      this.point = point;
   }

   public int getTotaldeposit() {
      return totaldeposit;
   }

   public void setTotaldeposit(int totaldeposit) {
      this.totaldeposit = totaldeposit;
   }

   public int getNoshow() {
      return noshow;
   }

   public void setNoshow(int noshow) {
      this.noshow = noshow;
   }

   public String getRegisterdate() {
      return registerdate;
   }

   public void setRegisterdate(String registerdate) {
      this.registerdate = registerdate;
   }

   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }

   public String getOrgFilename() {
      return orgFilename;
   }

   public void setOrgFilename(String orgFilename) {
      this.orgFilename = orgFilename;
   }

   public String getFileSize() {
      return fileSize;
   }

   public void setFileSize(String fileSize) {
      this.fileSize = fileSize;
   }

   public MultipartFile getProfileimg() {
      return profileimg;
   }

   public void setProfileimg(MultipartFile profileimg) {
      this.profileimg = profileimg;
   }
   
} // end of class MemberVO