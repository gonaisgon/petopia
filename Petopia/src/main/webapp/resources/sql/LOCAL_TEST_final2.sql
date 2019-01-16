show user;

-- #업데이트 내역
-- [190106] 계정관련 쿼리문, 예약결제환불 관련 테이블 및 시퀀스
-- [190107] 1; 팀별 쿼리 병합
-- [190107] 2; 기업회원상세 테이블의 특이사항을 빼고 찾아오는길 컬럼 추가

---

-- 계정 조회
show user;

-- 모든 테이블 조회
select * from user_tables;

-- 모든 시퀀스 조회
select * from user_sequences;

-- 모든 제약조건 조회
select * from user_constraints;

-- 테이블 삭제 명령문
drop table member_level purge;
drop table member purge;
drop table login_log purge;
drop table biz_info purge;
drop table biz_info_img purge;
drop table recommend_tag purge;
drop table review_comment purge;
drop table reservation purge;
drop table pet_info purge;
drop table vaccine purge;
drop table shots purge;
drop table pet_list purge;
drop table petcare purge;
drop table caretype purge;
drop table chart purge;
drop table payment purge;
drop table deposit purge;
drop table refund purge;
drop table notification purge;
drop table withdraw purge;
drop table dep_use purge;
drop table prescription purge;
drop table video_advice purge;
drop table consult purge;
drop table consult_comment purge;
drop table petcare_img purge;
drop table board_group purge;
drop table board_post purge;
drop table board_comment purge;

-- 시퀀스 삭제 명령문
drop sequence seq_member;
drop sequence biz_info_img_seq;
drop sequence seq_doctors_UID;
drop sequence seq_recommend_tag_UID;
drop sequence hava_tag;
drop sequence review;
drop sequence seq_review_UID;
drop sequence seq_rc_UID;
drop sequence seq_schedule_UID;
drop sequence seq_reservation_UID;
drop sequence seq_pet_info_UID;
drop sequence seq_vaccine_UID;
drop sequence seq_shots_UID;
drop sequence seq_petcare_UID;
drop sequence seq_caretype_UID;
drop sequence chart_seq;
drop sequence seq_payment_UID;
drop sequence seq_deposit_UID;
drop sequence seq_refund_refund_UID;
drop sequence seq_notification_UID;
drop sequence seq_withdraw_UID;
drop sequence seq_dep_use_UID;
drop sequence seq_prescription_UID;
drop sequence seq_video_advice_UID;
drop sequence seq_consult_UID;
drop sequence seq_consult_comment;
drop sequence petcare_img_seq;
drop sequence board_group_seq;
drop sequence seq_board_post;
drop sequence board_comment_seq;
drop sequence comment_seq;

---

-- 회원
CREATE TABLE member (
idx NUMBER NOT NULL, -- 회원고유번호
userid VARCHAR2(255) NOT NULL, -- 이메일아이디
pwd VARCHAR2(100) NOT NULL, -- 비밀번호
name VARCHAR2(100) NOT NULL, -- 이름
nickname VARCHAR2(100) NOT NULL, -- 닉네임
birthday VARCHAR2(50) NOT NULL, -- 생년월일
gender NUMBER(1) default 1 NOT NULL, -- 성별
phone VARCHAR2(100) NOT NULL, -- 연락처
profileimg VARCHAR2(100) NOT NULL, -- 프로필사진
membertype NUMBER(1) NOT NULL, -- 회원타입
point NUMBER default 0 NOT NULL, -- 포인트
totaldeposit NUMBER default 0 NOT NULL, -- 누적예치금
noshow NUMBER default 0 NOT NULL, -- 노쇼지수
registerdate DATE default sysdate NOT NULL -- 가입일자

    , CONSTRAINT PK_member PRIMARY KEY (idx) -- 회원 기본키
    , CONSTRAINT uq_member_userid UNIQUE (userid) -- 회원아이디UQ   
    , CONSTRAINT ck_member_gender check(gender in(1,2)) -- 회원성별 체크제약   
    , CONSTRAINT ck_member_memtype check(membertype in(1, 2, 3)) -- 회원타입 체크제약

);

alter table member
add fileName VARCHAR2(100) NOT NULL;

-- 등급번호 삭제
ALTER TABLE member DROP COLUMN fk_level_UID;

CREATE TABLE login_log (
idx NUMBER NOT NULL, -- 회원고유번호
fk_userid VARCHAR2(255) NOT NULL, -- 이메일아이디
fk_pwd VARCHAR2(100) NOT NULL, -- 비밀번호
lastlogindate DATE NOT NULL, -- 로그인일시
member_status NUMBER(1) default 1 NOT NULL -- 회원상태 활동1 휴면0

    , CONSTRAINT PK_login_log PRIMARY KEY (idx) -- 로그인 기본키
    , CONSTRAINT CK_login_log_status check(member_status in(0,1)) -- 회원상태 체크제약
    , CONSTRAINT FK_member_TO_login_log FOREIGN KEY (idx) REFERENCES member (idx)

);

-- 회원 시퀀스
-- drop sequence seq_member;
create sequence seq_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 기업회원상세
CREATE TABLE biz_info (
idx_biz NUMBER NOT NULL, -- 병원/약국고유번호
biztype NUMBER(1) NOT NULL, -- 기업구분
repname VARCHAR2(50) NOT NULL, -- 대표자명
biznumber VARCHAR2(100) NOT NULL, -- 사업자번호
postcode VARCHAR2(10) NOT NULL, -- 우편번호
addr1 VARCHAR2(100) NOT NULL, -- 주소
addr2 VARCHAR2(100) NOT NULL, -- 주소2
latitude VARCHAR2(100) NOT NULL, -- 위도
longitude VARCHAR2(100) NOT NULL, -- 경도
prontimg VARCHAR2(100) NOT NULL, -- 대표이미지
weekday VARCHAR2(100) NOT NULL, -- 평일; 월~금(주 5), 화~금(주 4), 월, 수, 금(주 3)
wdstart DATE NOT NULL, -- 평일시작시간
wdend DATE NOT NULL, -- 평일종료시간
lunchstart DATE NOT NULL, -- 점심시작시간
lunchend DATE NOT NULL, -- 점심종료시간
satstart DATE NOT NULL, -- 토요일시작
satend DATE NOT NULL, -- 토요일종료
dayoff VARCHAR2(100) NOT NULL, -- 일요일/공휴일
dog NUMBER(1) NOT NULL, -- 강아지
cat NUMBER(1) NOT NULL, -- 고양이
smallani NUMBER(1) NOT NULL, -- 소동물
etc NUMBER(1) NOT NULL, -- 기타
easyway VARCHAR2(255) NULL, -- 찾아오는길
intro CLOB NOT NULL -- 소개글
,CONSTRAINT PK_biz_info -- 기업회원상세 기본키
PRIMARY KEY (
idx_biz -- 병원/약국고유번호
)
,CONSTRAINT UK_biz_info -- 기업회원상세 유니크 제약
UNIQUE (
biznumber -- 사업자번호
)
,CONSTRAINT ck_biz_info_dog -- 강아지 체크제약
check(dog in(1,0))
,CONSTRAINT ck_biz_info_cat -- 고양이 체크제약
check(cat in(1,0))
,CONSTRAINT ck_biz_info_smallani -- 소동물 체크제약
check(smallani in(1,0))
,CONSTRAINT ck_biz_info_etc -- 기타 체크제약
check(etc in(1,0))
,CONSTRAINT FK_member_TO_biz_info -- 회원 -> 기업회원상세
FOREIGN KEY (
idx_biz -- 병원/약국고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
)
);

-- 기업회원추가이미지
CREATE TABLE biz_info_img (
img_UID NUMBER NOT NULL, -- 이미지고유번호
fk_idx_biz NUMBER NOT NULL, -- 병원/약국고유번호
imgfilename VARCHAR2(100) NOT NULL -- 이미지파일명
,CONSTRAINT PK_biz_info_img -- 기업회원추가이미지 기본키
PRIMARY KEY (
img_UID -- 이미지고유번호
)
);

ALTER TABLE biz_info_img
ADD
CONSTRAINT FK_biz_info_TO_biz_info_img -- 기업회원상세 -> 기업회원추가이미지
FOREIGN KEY (
fk_idx_biz -- 병원/약국고유번호
)
REFERENCES biz_info ( -- 기업회원상세
idx_biz -- 병원/약국고유번호
);

create sequence biz_info_img_seq --기업정보 이미지
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 의료진
CREATE TABLE doctors (
doc_UID NUMBER NOT NULL, -- 의료진고유번호
fk_idx_biz NUMBER NOT NULL, -- 병원/약국고유번호
docname VARCHAR2(100) NOT NULL, -- 의료진명
dog NUMBER(1) NOT NULL, -- 강아지
cat NUMBER(1) NOT NULL, -- 고양이
smallani NUMBER(1) NOT NULL, -- 소동물
etc NUMBER(1) NOT NULL -- 기타
,CONSTRAINT PK_doctors -- 의료진 기본키
PRIMARY KEY (
doc_UID -- 의료진고유번호
)
,CONSTRAINT ck_doctors_dog -- 강아지 체크제약
check(dog in(1,0))
,CONSTRAINT ck_doctors_cat -- 고양이 체크제약
check(cat in(1,0))
,CONSTRAINT ck_doctors_smallani -- 소동물 체크제약
check(smallani in(1,0))
,CONSTRAINT ck_doctors_etc -- 기타 체크제약
check(etc in(1,0))
);

create sequence seq_doctors_UID --의료진
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 태그 테이블
--drop table recommend_tag purge;
CREATE TABLE recommend_tag (
tag_UID NUMBER NOT NULL, -- 태그번호
tag_type VARCHAR2(100) NOT NULL, -- 분야
tag_name VARCHAR2(100) NOT NULL -- 태그이름
,CONSTRAINT PK_recommend_tag PRIMARY KEY(tag_UID)
);

ALTER TABLE recommend_tag
ADD CONSTRAINT UQ_recommend_tag_name UNIQUE(tag_name);

-- 태그 시퀀스
create sequence seq_recommend_tag_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

CREATE TABLE have_tag (
fk_tag_UID NUMBER NOT NULL, -- 태그번호
fk_tag_name VARCHAR2(100) NOT NULL, -- 태그이름
fk_idx NUMBER NOT NULL -- 회원고유번호
);

ALTER TABLE have_tag
ADD CONSTRAINT FK_have_tag_UID FOREIGN KEY(fk_tag_UID)
REFERENCES recommend_tag(tag_UID);

ALTER TABLE have_tag
ADD CONSTRAINT FK_have_tag_name FOREIGN KEY(fk_tag_name)
REFERENCES recommend_tag(tag_name);

ALTER TABLE have_tag
ADD CONSTRAINT FK_have_tag_ide FOREIGN KEY(fk_idx)
REFERENCES member(idx);

-- 리뷰
CREATE TABLE review (
review_UID NUMBER NOT NULL, -- 리뷰코드
fk_idx_biz NUMBER NOT NULL, -- 병원/약국고유번호
fk_idx NUMBER NOT NULL, -- 회원고유번호
fk_reservation_UID NUMBER NOT NULL, -- 예약코드
startpoint NUMBER NOT NULL, -- 평점
fk_userid VARCHAR2(255) NOT NULL, -- 작성자아이디
fk_nickname VARCHAR2(100) NOT NULL, -- 작성자닉네임
rv_contents CLOB NOT NULL, -- 한줄리뷰내용
rv_status NUMBER(1) NOT NULL, -- 리뷰상태
rv_blind NUMBER(1) NOT NULL, -- 리뷰블라인드사유 0 없음 1 욕설 2 기업회원요청 3 신고누적 4 기타
rv_writeDate date default sysdate NOT NULL -- 리뷰날짜
,CONSTRAINT PK_review PRIMARY KEY (review_UID)
,CONSTRAINT ck_review_status -- 리뷰상태 체크제약
check(rv_status in(0,1))
,CONSTRAINT ck_review_blind -- 리뷰블라인드사유 체크제약
check(rv_blind in(0,1,2,3,4))
);

-- 리뷰 시퀀스
create sequence seq_review_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 리뷰댓글(reviewComment)
CREATE TABLE review_comment (
rc_id NUMBER NOT NULL, -- 리뷰댓글번호
fk_review_UID NUMBER NOT NULL, -- 리뷰코드
fk_idx NUMBER NOT NULL, -- 회원고유번호
rc_content CLOB NOT NULL, -- 댓글내용
rc_writedate DATE NOT NULL, -- 댓글날짜
fk_rc_id NUMBER NOT NULL, -- 원댓글 고유번호
rc_group NUMBER NOT NULL, -- 댓글그룹번호
rc_g_odr NUMBER NOT NULL, -- 댓글그룹순서
rc_depth NUMBER NOT NULL, -- 계층
rc_blind NUMBER(1) NOT NULL, -- 블라인드처리이유 0 없음 1 욕설 2 기업회원요청 3 신고누적 4 기타
rc_status NUMBER(1) NULL, -- 상태
CONSTRAINT PK_review_comment PRIMARY KEY(rc_id)
,CONSTRAINT ck_rc_status -- 리뷰댓글상태 체크제약
check(rc_status in(0,1))
,CONSTRAINT ck_rc_blind -- 블라인드처리이유 체크제약
check(rc_blind in(0,1,2,3,4))
);

-- 리뷰 댓글 시퀀스
create sequence seq_rc_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 스케쥴
CREATE TABLE schedule (
schedule_UID NUMBER NOT NULL, -- 스케쥴코드
fk_idx_biz NUMBER NOT NULL, -- 병원/약국고유번호
schedule_DATE DATE NOT NULL, -- 예약일정
schedule_status NUMBER(1) default 0 NOT NULL -- 일정상태 예약: 1/ 비예약: 0/default: 0
,CONSTRAINT PK_schedule -- 스케쥴 기본키
PRIMARY KEY (schedule_UID)
,CONSTRAINT ck_sch_status -- 일정상태 체크제약
check(schedule_status in(1,0))
,CONSTRAINT fk_sch_idx_biz -- 기업회원상세 -> 스케쥴
FOREIGN KEY (fk_idx_biz)	REFERENCES biz_info(idx_biz)
);

-- 스케쥴
create sequence seq_schedule_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 예약
CREATE TABLE reservation (
reservation_UID NUMBER NOT NULL, -- 예약코드
fk_idx NUMBER NOT NULL, -- 회원고유번호
fk_schedule_UID NUMBER NOT NULL, -- 스케쥴코드
fk_pet_UID NUMBER NOT NULL, -- 반려동물코드
bookingdate DATE default sysdate NOT NULL, -- 예약완료일시
reservation_DATE DATE NOT NULL, -- 방문예정일
reservation_status NUMBER(1) NOT NULL, -- 예약진행상태 1 예약완료/ 2 결제완료 / 3 진료완료 / 4 취소 / 5 no show
reservation_type NUMBER NOT NULL -- 예약타입 1 진료 / 2 예방접종 / 3 수술/ 4 호텔링

    ,CONSTRAINT PK_reservation -- 예약 기본키
    	PRIMARY KEY (reservation_UID)
    ,CONSTRAINT ck_rev_status -- 예약진행상태 체크제약
    	check(reservation_status in(1,2,3,4,5))
    ,CONSTRAINT ck_rev_type -- 예약타입 체크제약
    	check(reservation_type in(1, 2, 3, 4))
    ,CONSTRAINT FK_member_TO_reservation -- 회원 -> 예약
    	FOREIGN KEY (
    		fk_idx -- 회원고유번호
    	)
    	REFERENCES member ( -- 회원
    		idx -- 회원고유번호
    	)
    ,CONSTRAINT FK_schedule_TO_reservation -- 스케쥴 -> 예약
    	FOREIGN KEY (
    		fk_schedule_UID -- 스케쥴코드
    	)
    	REFERENCES schedule ( -- 스케쥴
    		schedule_UID -- 스케쥴코드
    	)

);

-- 예약
create sequence seq_reservation_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 반려동물정보
CREATE TABLE pet_info (
pet_UID NUMBER NOT NULL, -- 반려동물코드
fk_idx NUMBER NOT NULL, -- 회원고유번호
pet_name VARCHAR2(100) NOT NULL, -- 반려동물이름
pet_type VARCHAR2(50) NOT NULL, -- 종류 dog/cat/smallani/etc
pet_birthday VARCHAR2(100) NULL, -- 반려동물생일
pet_size VARCHAR2(2) NULL, -- 사이즈 L/M/S
pet_weight NUMBER NULL, -- 몸무게
pet_gender NUMBER(1) NULL, -- 성별 1 남 2 여
pet_neutral NUMBER(1) NULL, -- 중성화여부 1 함 / 0 안함 / 2 모름
medical_history CLOB NULL, -- 과거병력기재
allergy CLOB NULL, -- 알러지내역
pet_profileimg VARCHAR2(255) NULL -- 반려동물프로필사진
,CONSTRAINT PK_pet_info -- 반려동물정보 기본키
PRIMARY KEY (pet_UID)
,CONSTRAINT ck_petinfo_gender -- 반려동물성별 체크제약
check(pet_gender in(1,2))
,CONSTRAINT ck_petinfo_neutral -- 중성화여부 체크제약
check(pet_neutral in(0,1,2))
);

create sequence seq_pet_info_UID --반려동물정보
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 백신
CREATE TABLE vaccine (
vaccine_UID NUMBER NOT NULL, -- 백신코드
vaccine_name VARCHAR2(100) NOT NULL, -- 백신명
dog NUMBER(1) NOT NULL, -- 강아지
cat NUMBER(1) NOT NULL, -- 고양이
smallani NUMBER(1) NOT NULL -- 소동물
,CONSTRAINT PK_vaccine -- 백신 기본키
PRIMARY KEY (vaccine_UID)
,CONSTRAINT ck_vaccine_dog -- 강아지 체크제약
check(dog in(1,0))
,CONSTRAINT ck_vaccine_cat -- 고양이 체크제약
check(cat in(1,0))
,CONSTRAINT ck_vaccine_smallani -- 소동물 체크제약
check(smallani in(1,0))
);

create sequence seq_vaccine_UID --백신
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 접종내용
CREATE TABLE shots (
shots_UID NUMBER NOT NULL, -- 접종코드
fk_pet_UID NUMBER NOT NULL, -- 반려동물코드
fk_vaccine_UID NUMBER NOT NULL, -- 백신코드
vaccine_name VARCHAR2(100) NOT NULL -- 백신명
,CONSTRAINT PK_shots -- 접종내용 기본키
PRIMARY KEY (shots_UID)
);

create sequence seq_shots_UID --접종
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 반려동물목록
CREATE TABLE pet_list (
petlist_UID NUMBER NOT NULL, -- 목록번호
fk_idx NUMBER NOT NULL, -- 회원고유번호
fk_pet_UID NUMBER NOT NULL, -- 반려동물코드
fk_pet_name VARCHAR2(100) NOT NULL -- 반려동물명
,CONSTRAINT PK_pet_list -- 반려동물목록 기본키
PRIMARY KEY (petlist_UID)
);

-- 반려동물케어
CREATE TABLE petcare (
care_UID NUMBER NOT NULL, -- 케어코드
fk_pet_UID NUMBER NOT NULL, -- 반려동물코드
fk_caretype_UID NUMBER NOT NULL, -- 케어타입코드
care_contents CLOB NOT NULL, -- 내용
care_memo CLOB NULL, -- 메모
care_start DATE NOT NULL, -- 시작일시
care_end DATE NOT NULL, -- 종료일시
care_alarm NUMBER(10) NULL, -- 알림여부 없음 0/5분전 5/10분전 10/하루전 1440 (분 단위 환산)
care_date DATE NOT NULL -- 케어등록 일자
,CONSTRAINT PK_petcare -- 반려동물케어 기본키
PRIMARY KEY (care_UID)
);

create sequence seq_petcare_UID --펫케어
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 케어타입
CREATE TABLE caretype (
caretype_UID NUMBER NOT NULL, -- 케어타입코드
caretype_name VARCHAR2(100) NOT NULL, -- 케어타입명
caretype_info CLOB NOT NULL -- 케어타입별설명
,CONSTRAINT PK_caretype -- 케어타입 기본키
PRIMARY KEY (caretype_UID)
);

create sequence seq_caretype_UID --케어 타입
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 진료기록
CREATE TABLE chart (
chart_UID NUMBER NOT NULL, -- 차트코드
fk_pet_UID NUMBER NOT NULL, -- 반려동물코드
fk_idx NUMBER NOT NULL, -- 회원고유번호
chart_type NUMBER(1) NOT NULL, -- 진료타입 0 약국/1 진료 / 2 예방접종 / 3 수술 / 4 호텔링
biz_name VARCHAR2(100) NOT NULL, -- 병원/약국명
bookingdate DATE NULL, -- 예약완료일시
reservation_DATE DATE NULL, -- 방문예정일
doc_name VARCHAR2(100) NULL, -- 수의사명
cautions CLOB NULL, -- 주의사항
chart_contents CLOB NULL, -- 내용
payment_pay NUMBER NULL, -- 사용예치금
payment_point NUMBER NULL, -- 사용포인트
addpay NUMBER NULL, -- 본인부담금(추가결제금액)
totalpay NUMBER NULL -- 진료비총액
,CONSTRAINT PK_chart -- 진료기록 기본키
PRIMARY KEY (chart_UID)
,CONSTRAINT ck_chart_type -- 진료타입 체크제약
check(chart_type in(0,1,2,3,4))
);

create sequence chart_seq --차트
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 예치금결제
CREATE TABLE payment (
payment_UID NUMBER NOT NULL, -- 결제코드
fk_reservation_UID NUMBER NOT NULL, -- 예약코드
payment_total NUMBER NOT NULL, -- 결제총액
payment_point NUMBER NOT NULL, -- 결제포인트
payment_pay NUMBER NOT NULL, -- 실결제금액
payment_date DATE NOT NULL, -- 결제일자
payment_status NUMBER(1) NOT NULL -- 결제상태 1 결제완료 / 0 미결제 / 2 취소 / 3 환불
,CONSTRAINT PK_payment PRIMARY KEY (payment_UID)
,CONSTRAINT CK_payment_status -- 결제상태 체크제약
check(payment_status in(0,1,2,3))
);

-- 예치금결제
create sequence seq_payment_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 예치금
CREATE TABLE deposit (
deposit_UID NUMBER NOT NULL, -- 예치금코드
fk_idx NUMBER NOT NULL, -- 회원고유번호
depositcoin NUMBER NOT NULL, -- 예치금
deposit_status NUMBER(1) default 1 NOT NULL, -- 예치금상태 1 사용가능 / 0 사용불가능 / 2 환불취소신청 / 3 출금
deposit_type VARCHAR2(50) NOT NULL, -- 충전수단
deposit_date DATE default sysdate NOT NULL -- 충전일자
,CONSTRAINT PK_deposit -- 예치금 기본키
PRIMARY KEY (deposit_UID)
,CONSTRAINT CK_deposit_status -- 예치금상태 체크제약
check(deposit_status in(0,1,2,3))
);

-- 예치금
create sequence seq_deposit_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 환불
CREATE TABLE refund (
refund_UID NUMBER NOT NULL, -- 환불코드
fk_payment_UID NUMBER NOT NULL, -- 결제코드
fk_idx NUMBER NOT NULL, -- 환불받을회원번호
fk_idx_biz NUMBER NOT NULL, -- 병원번호
refund_DATE DATE default sysdate NOT NULL, -- 환불신청일자
add_DATE DATE NOT NULL, -- 사용일자
refund_reason VARCHAR2(255) NOT NULL, -- 환불사유
refund_money NUMBER NOT NULL, -- 환불금액
refund_status NUMBER(1) default 0 NOT NULL -- 승인여부 1확인 0미확인
,CONSTRAINT PK_refund -- 환불 기본키
PRIMARY KEY (refund_UID)
,CONSTRAINT CK_refund_status -- 승인여부 체크제약
check(refund_status in(0,1))
);

-- 환불
create sequence seq_refund_refund_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 알림
CREATE TABLE notification (
not_UID NUMBER NOT NULL, -- 알림코드
fk_idx NUMBER NOT NULL, -- 회원고유번호
not_type NUMBER(1) NOT NULL, -- 알림유형 0 전체공지 / 1 petcare / 2 reservation / 3 payment / 4 board
not_message CLOB NOT NULL, -- 알림내용
not_date DATE NOT NULL, -- 알림발송일시
not_readcheck NUMBER(1) default 0 NOT NULL -- 확인여부 확인 1 / 미확인 0
,CONSTRAINT PK_notification -- 알림 기본키
PRIMARY KEY (not_UID)
,CONSTRAINT CK_not_type -- 알림유형 체크제약
check(not_type in(0,1,2,3,4))
,CONSTRAINT CK_not_readcheck -- 확인여부 체크제약
check(not_readcheck in(0,1))
);

create sequence seq_notification_UID --알람
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 예치금출금
CREATE TABLE withdraw (
withdraw_UID NUMBER NOT NULL, -- 출금코드
fk_deposit_UID NUMBER NOT NULL, -- 예치금코드
withdraw_money NUMBER NOT NULL, -- 출금요청금액
withdraw_status NUMBER(1) default 0 NOT NULL -- 출금상태 1 완료 / 0 대기
,CONSTRAINT PK_withdraw -- 예치금출금 기본키
PRIMARY KEY (withdraw_UID)
,CONSTRAINT CK_withdraw_status -- 출금상태 체크제약
check(withdraw_status in(0,1))
);

-- 예치금출금
create sequence seq_withdraw_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 예치금 사용내역
CREATE TABLE dep_use (
dep_use_UID NUMBER NOT NULL, -- 사용내역코드
fk_deposit_UID NUMBER NOT NULL, -- 예치금코드
fk_payment_UID NUMBER NOT NULL, -- 결제코드
fk_reservation_UID NUMBER NOT NULL, -- 예약코드
depu_money NUMBER NOT NULL, -- 사용금액
deposit_usedate DATE default sysdate NOT NULL -- 사용일자
,CONSTRAINT PK_dep_use -- 예치금 사용내역 기본키
PRIMARY KEY (dep_use_UID)
);

-- 사용내역
create sequence seq_dep_use_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 처방전
CREATE TABLE prescription (
rx_UID number NOT NULL, -- 처방코드
chart_UID NUMBER NOT NULL, -- 차트코드
rx_name varchar2(100) NOT NULL, -- 처방약
dose_number varchar2(100) NULL, -- 복용횟수
dosage varchar2(100) NULL, -- 복용용량
rx_notice CLOB NULL, -- 처방안내
rx_cautions varchar2(100) NULL, -- 주의사항
rx_regName varchar2(100) NOT NULL -- 등록한사람
,CONSTRAINT PK_prescription -- 처방전 기본키
PRIMARY KEY (rx_UID)
);

create sequence seq_prescription_UID --처방
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 화상 상담(video advice)
CREATE TABLE video_advice (
va_UID NUMBER NOT NULL, -- 화상상담 번호
fk_idx NUMBER NOT NULL, -- 회원고유번호
fk_idx_biz NUMBER NOT NULL, -- 병원/약국고유번호
chatcode VARCHAR2(20) NOT NULL, -- 채팅방 코드
fk_userid VARCHAR2(255) NOT NULL, -- 회원아이디
fk_name_biz VARCHAR2(100) NOT NULL, -- 병원명
fk_docname VARCHAR2(100) NOT NULL, -- 수의사명
usermessage CLOB NULL, -- 회원이 보낸 메세지
docmessage CLOB NULL, -- 수의사가 보낸 메세지
umtime DATE NULL, -- 회원이 메세지보낸 시각
dmtime DATE NULL, -- 수의사가 메세지보낸 시각
startTime date default sysdate NOT NULL, -- 화상채팅 시작시간
endTime date NULL -- 화상채팅 종료시간

    ,CONSTRAINT PK_video_advice -- 화상 상담(video advice) 기본키
    	PRIMARY KEY (va_UID)

);

create sequence seq_video_advice_UID --화상상담
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

------------------------- 생성 여기까지 함 --------



-- 1:1상담
CREATE TABLE consult (
consult_UID NUMBER NOT NULL, -- 상담코드
fk_idx NUMBER NOT NULL, -- 회원고유번호
cs_pet_type NUMBER(1) NOT NULL, -- 동물분류 1 강아지 / 2 고양이 / 3 소동물 / 4 기타
cs_title VARCHAR2(100) NOT NULL, -- 상담제목
cs_contents CLOB NOT NULL, -- 상담내용
cs_hit NUMBER NOT NULL, -- 조회수
cs_writeday DATE NOT NULL, -- 작성일자
cs_secret NUMBER(1) NOT NULL -- 공개여부 0 비공개 / 1 공개
,CONSTRAINT PK_consult -- 1:1상담 기본키
PRIMARY KEY (consult_UID)
,CONSTRAINT ck_consult_type -- 동물분류 체크제약
check(cs_pet_type in(1,2,3,4))
,CONSTRAINT ck_cs_secret -- 공개여부 체크제약
check(cs_secret in(0,1))
);

create sequence seq_consult_UID --1:1 상담
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 1:1상담 댓글
CREATE TABLE consult_comment (
cmt_id NUMBER NOT NULL, -- 댓글고유번호
fk_consult_UID NUMBER NOT NULL, -- 상담코드
fk_idx NUMBER NOT NULL, -- 댓글회원고유번호
cscmt_nickname VARCHAR2(100) NOT NULL, -- 댓글작성자
cscmt_contents CLOB NOT NULL, -- 댓글내용
cscmt_writeday DATE NOT NULL, -- 댓글작성일시
fk_cmt_id NUMBER NOT NULL, -- 원댓글 고유번호
cscmt_group NUMBER default 0 NOT NULL, -- 댓글그룹번호
cscmt_g_odr NUMBER default 0 NOT NULL, -- 댓글그룹순서
cscmt_depth NUMBER default 0 NOT NULL, -- 계층
cscmt_del NUMBER(1) default 1 NOT NULL -- 삭제여부 0삭제 / 1 사용가능
,CONSTRAINT PK_consult_comment PRIMARY KEY (cmt_id)
,CONSTRAINT ck_cscmt_del -- 삭제여부 체크제약
check(cscmt_del in(1,0))
);

create sequence seq_consult_comment --1:1 상담 댓글
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 펫케어 이미지
CREATE TABLE petcare_img (
pc_img_UID NUMBER NOT NULL, -- 이미지번호
fk_care_UID NUMBER NOT NULL, -- 케어코드
pc_img_name VARCHAR2(255) NOT NULL -- 이미지명
,CONSTRAINT PK_petcare_img -- 펫케어 이미지 기본키
PRIMARY KEY (pc_img_UID)
);

create sequence petcare_img_seq --펫케어 이미지
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 게시판그룹
CREATE TABLE board_group (
brd_id NUMBER NOT NULL, -- 게시판그룹코드
brd_name VARCHAR2(20) NOT NULL, -- 게시판명
brd_grant NUMBER(1) NOT NULL -- 글쓰기권한 (1, 2, 3)
,CONSTRAINT PK_board_group -- 게시판그룹 기본키
PRIMARY KEY (brd_id)
,CONSTRAINT ck_brd_grant -- 글쓰기권한 체크제약
check(brd_grant in(1,2,3))
);

create sequence board_group_seq --게시판 그룹
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 게시글
CREATE TABLE board_post (
post_id NUMBER NOT NULL, -- 게시글고유번호
fk_brd_id NUMBER NOT NULL, -- 게시판그룹코드
post_title VARCHAR2(100) NOT NULL, -- 게시글제목
post_contents CLOB NOT NULL, -- 게시글내용
fk_idx NUMBER NOT NULL, -- 작성자고유번호
fk_nickname VARCHAR2(100) NOT NULL, -- 작성자
post_writeday DATE NOT NULL, -- 작성일
post_hit NUMBER NOT NULL, -- 조회수
post_del NUMBER(1) NOT NULL, -- 삭제여부
post_repcnt NUMBER NOT NULL, -- 댓글수
post_imgfilename VARCHAR2(255) NULL -- 대표이미지
,CONSTRAINT PK_board_post -- 게시글 기본키
PRIMARY KEY (post_id)
,CONSTRAINT ck_post_del -- 삭제여부 체크제약
check(post_del in(0,1))
);

create sequence seq_board_post --게시글
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 댓글
CREATE TABLE board_comment (
cmt_id NUMBER NOT NULL, -- 댓글고유번호
fk_brd_id NUMBER NOT NULL, -- 게시판그룹코드
fk_post_id NUMBER NOT NULL, -- 게시글고유번호
fk_idx NUMBER NOT NULL, -- 댓글작성자고유번호
fk_nickname VARCHAR2(100) NOT NULL, -- 댓글작성자
cmt_contents CLOB NOT NULL, -- 댓글내용
cmt_writeday DATE NOT NULL, -- 댓글작성일시
cmt_group NUMBER NOT NULL, -- 댓글그룹번호
cmt_g_odr NUMBER NOT NULL, -- 댓글그룹순서
cmt_depth NUMBER NOT NULL, -- 계층
cmt_del NUMBER(1) NOT NULL -- 삭제여부
,CONSTRAINT PK_comment PRIMARY KEY (cmt_id)
,CONSTRAINT ck_cmt_del -- 삭제여부 체크제약
check(cmt_del in(0,1))
);

create sequence board_comment_seq --댓글
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

## ---- 이벤트
--CREATE TABLE event (
--	ev_id NUMBER NOT NULL, -- 이벤트코드
--	ev_title VARCHAR2(255) NOT NULL, -- 이벤트제목
--	ev_contents CLOB NOT NULL, -- 이벤트내용
--	ev_imgfilename VARCHAR2(255) NOT NULL, -- 이벤트배너
--	ev_start DATE NOT NULL, -- 이벤트시작
--	ev_end DATE NOT NULL -- 이벤트종료
-- ,CONSTRAINT PK_event -- 이벤트 기본키
--	PRIMARY KEY (ev_id)
--);

## ---- 유기동물후원
--CREATE TABLE funding (
--	fd_id NUMBER NOT NULL, -- 후원코드
--	fd_title VARCHAR2 NOT NULL, -- 후원제목
--	fd_orgname VARCHAR2 NOT NULL, -- 단체및시설이름
--	region VARCHAR2 NOT NULL, -- 지역
--	fd_name VARCHAR2 NOT NULL, -- 대표자
--	fd_phone VARCHAR2 NOT NULL, -- 연락처
--	fd_goal NUMBER NOT NULL, -- 후원모금액
--	fd_start DATE NOT NULL, -- 시작일
--	fd_end DATE NOT NULL, -- 종료일
--	fd_imgfilename VARCHAR2 NOT NULL, -- 대표이미지
--	fd_contents CLOB NOT NULL -- 후원내용
--);

## ---- 유기동물후원
--ALTER TABLE funding
--	ADD
--	CONSTRAINT PK_funding -- 유기동물후원 기본키
--	PRIMARY KEY (
--	fd_id -- 후원코드
--	);

## ---- 유기동물후원이미지
--CREATE TABLE funding_img (
--	fdimg_id NUMBER NOT NULL, -- 후원이미지코드
--	fk_fd_id NUMBER NOT NULL, -- 후원코드
--	fdimg_name VARCHAR2 NOT NULL -- 이미지파일명
--);

## ---- 유기동물후원이미지
--ALTER TABLE funding_img
--	ADD
--	CONSTRAINT PK_funding_img -- 유기동물후원이미지 기본키
--	PRIMARY KEY (
--	fdimg_id -- 후원이미지코드
--	);

## ---- 펀딩결제
--CREATE TABLE funding_payment (
--	payment_UID NUMBER NOT NULL, -- 결제코드
--	fk_fd_id NUMBER NOT NULL, -- 후원코드
--	payment_total NUMBER NOT NULL, -- 결제총액
--	payment_point NUMBER NOT NULL, -- 결제포인트
--	payment_pay NUMBER NOT NULL, -- 실결제금액
--	payment_date DATE NOT NULL, -- 결제일자
--	payment_status NUMBER NOT NULL -- 결제상태
--);

## ---- 펀딩결제
--ALTER TABLE funding_payment
--	ADD
--	CONSTRAINT PK_funding_payment -- 펀딩결제 기본키
--	PRIMARY KEY (
--	payment_UID -- 결제코드
--	);

## ---- 펀딩환불
--CREATE TABLE funding_refund (
--	refund_UID VARCHAR2 NOT NULL, -- 환불코드
--	fk_payment_UID NUMBER NOT NULL, -- 결제코드
--	fk_idx NUMBER NOT NULL, -- 환불받을회원번호
--	refund_DATE DATE NOT NULL, -- 환불신청일자
--	add_DATE DATE NOT NULL, -- 사용일자
--	refund_reason VARCHAR2 NOT NULL, -- 환불사유
--	refund_money NUMBER NOT NULL, -- 환불금액
--	refund_status NUMBER NOT NULL -- 승인여부
--);

## ---- 펀딩환불
--ALTER TABLE funding_refund
--	ADD
--	CONSTRAINT PK_funding_refund -- 펀딩환불 기본키
--	PRIMARY KEY (
--	refund_UID -- 환불코드
--	);

-- #제약조건 추가

-- 의료진
ALTER TABLE doctors
ADD
CONSTRAINT FK_biz_info_TO_doctors -- 기업회원상세 -> 의료진
FOREIGN KEY (
fk_idx_biz -- 병원/약국고유번호
)
REFERENCES biz_info ( -- 기업회원상세
idx_biz -- 병원/약국고유번호
);

-- 리뷰
ALTER TABLE review
ADD
CONSTRAINT FK_biz_info_TO_review -- 기업회원상세 -> 리뷰
FOREIGN KEY (
fk_idx_biz -- 병원/약국고유번호
)
REFERENCES biz_info ( -- 기업회원상세
idx_biz -- 병원/약국고유번호
);

-- 리뷰
ALTER TABLE review
ADD
CONSTRAINT FK_member_TO_review -- 회원 -> 리뷰
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 리뷰
ALTER TABLE review
ADD
CONSTRAINT FK_reservation_TO_review -- 예약 -> 리뷰
FOREIGN KEY (
fk_reservation_UID -- 예약코드
)
REFERENCES reservation ( -- 예약
reservation_UID -- 예약코드
);

-- 예약
ALTER TABLE reservation
ADD
CONSTRAINT FK_pet_info_TO_reservation -- 반려동물정보 -> 예약
FOREIGN KEY (
fk_pet_UID -- 반려동물코드
)
REFERENCES pet_info ( -- 반려동물정보
pet_UID -- 반려동물코드
);

-- 반려동물정보
ALTER TABLE pet_info
ADD
CONSTRAINT FK_member_TO_pet_info -- 회원 -> 반려동물정보
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 접종내용
ALTER TABLE shots
ADD
CONSTRAINT FK_vaccine_TO_shots -- 백신 -> 접종내용
FOREIGN KEY (
fk_vaccine_UID -- 백신코드
)
REFERENCES vaccine ( -- 백신
vaccine_UID -- 백신코드
);

-- 접종내용
ALTER TABLE shots
ADD
CONSTRAINT FK_pet_info_TO_shots -- 반려동물정보 -> 접종내용
FOREIGN KEY (
fk_pet_UID -- 반려동물코드
)
REFERENCES pet_info ( -- 반려동물정보
pet_UID -- 반려동물코드
);

-- 반려동물목록
ALTER TABLE pet_list
ADD
CONSTRAINT FK_member_TO_pet_list -- 회원 -> 반려동물목록
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 반려동물목록
ALTER TABLE pet_list
ADD
CONSTRAINT FK_pet_info_TO_pet_list -- 반려동물정보 -> 반려동물목록
FOREIGN KEY (
fk_pet_UID -- 반려동물코드
)
REFERENCES pet_info ( -- 반려동물정보
pet_UID -- 반려동물코드
);

-- 반려동물케어
ALTER TABLE petcare
ADD
CONSTRAINT FK_pet_info_TO_petcare -- 반려동물정보 -> 반려동물케어
FOREIGN KEY (
fk_pet_UID -- 반려동물코드
)
REFERENCES pet_info ( -- 반려동물정보
pet_UID -- 반려동물코드
);

-- 반려동물케어
ALTER TABLE petcare
ADD
CONSTRAINT FK_caretype_TO_petcare -- 케어타입 -> 반려동물케어
FOREIGN KEY (
fk_caretype_UID -- 케어타입코드
)
REFERENCES caretype ( -- 케어타입
caretype_UID -- 케어타입코드
);

-- 진료기록
ALTER TABLE chart
ADD
CONSTRAINT FK_pet_info_TO_chart -- 반려동물정보 -> 진료기록
FOREIGN KEY (
fk_pet_UID -- 반려동물코드
)
REFERENCES pet_info ( -- 반려동물정보
pet_UID -- 반려동물코드
);

-- 진료기록
ALTER TABLE chart
ADD
CONSTRAINT FK_member_TO_chart -- 회원 -> 진료기록
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 예치금결제
ALTER TABLE payment
ADD
CONSTRAINT FK_reservation_TO_payment -- 예약 -> 예치금결제
FOREIGN KEY (
fk_reservation_UID -- 예약코드
)
REFERENCES reservation ( -- 예약
reservation_UID -- 예약코드
);

-- 예치금
ALTER TABLE deposit
ADD
CONSTRAINT FK_member_TO_deposit -- 회원 -> 예치금
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 환불
ALTER TABLE refund
ADD
CONSTRAINT FK_payment_TO_refund -- 예치금결제 -> 환불
FOREIGN KEY (
fk_payment_UID -- 결제코드
)
REFERENCES payment ( -- 예치금결제
payment_UID -- 결제코드
);

-- 1:1상담
ALTER TABLE consult
ADD
CONSTRAINT FK_member_TO_consult -- 회원 -> 1:1상담
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 알림
ALTER TABLE notification
ADD
CONSTRAINT FK_member_TO_notification -- 회원 -> 알림
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 예치금출금
ALTER TABLE withdraw
ADD
CONSTRAINT FK_deposit_TO_withdraw -- 예치금 -> 예치금출금
FOREIGN KEY (
fk_deposit_UID -- 예치금코드
)
REFERENCES deposit ( -- 예치금
deposit_UID -- 예치금코드
);

-- 예치금 사용내역
ALTER TABLE dep_use
ADD
CONSTRAINT FK_deposit_TO_dep_use -- 예치금 -> 예치금 사용내역
FOREIGN KEY (
fk_deposit_UID -- 예치금코드
)
REFERENCES deposit ( -- 예치금
deposit_UID -- 예치금코드
);

-- 예치금 사용내역
ALTER TABLE dep_use
ADD
CONSTRAINT FK_payment_TO_dep_use -- 예치금결제 -> 예치금 사용내역
FOREIGN KEY (
fk_payment_UID -- 결제코드
)
REFERENCES payment ( -- 예치금결제
payment_UID -- 결제코드
);

-- 예치금 사용내역
ALTER TABLE dep_use
ADD
CONSTRAINT FK_reservation_TO_dep_use -- 예약 -> 예치금 사용내역
FOREIGN KEY (
fk_reservation_UID -- 예약코드
)
REFERENCES reservation ( -- 예약
reservation_UID -- 예약코드
);

-- 처방전
ALTER TABLE prescription
ADD
CONSTRAINT FK_chart_TO_prescription -- 진료기록 -> 처방전
FOREIGN KEY (
chart_UID -- 차트코드
)
REFERENCES chart ( -- 진료기록
chart_UID -- 차트코드
);

-- 화상 상담(video advice)
ALTER TABLE video_advice
ADD
CONSTRAINT FK_member_TO_video_advice -- 회원 -> 화상 상담(video advice)
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 화상 상담(video advice)
ALTER TABLE video_advice
ADD
CONSTRAINT FK_biz_info_TO_video_advice -- 기업회원상세 -> 화상 상담(video advice)
FOREIGN KEY (
fk_idx_biz -- 병원/약국고유번호
)
REFERENCES biz_info ( -- 기업회원상세
idx_biz -- 병원/약국고유번호
);

-- 리뷰댓글(reviewComment)
ALTER TABLE review_comment
ADD
CONSTRAINT FK_review_TO_review_comment -- 리뷰 -> 리뷰댓글(reviewComment)
FOREIGN KEY (
fk_review_UID -- 리뷰코드
)
REFERENCES review ( -- 리뷰
review_UID -- 리뷰코드
);

-- 리뷰댓글(reviewComment)
ALTER TABLE review_comment
ADD
CONSTRAINT FK_member_TO_review_comment -- 회원 -> 리뷰댓글(reviewComment)
FOREIGN KEY (
fk_idx -- 회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 1:1상담 댓글
ALTER TABLE consult_comment
ADD
CONSTRAINT FK_consult_TO_consult_comment -- 1:1상담 -> 1:1상담 댓글
FOREIGN KEY (
fk_consult_UID -- 상담코드
)
REFERENCES consult ( -- 1:1상담
consult_UID -- 상담코드
);

-- 1:1상담 댓글
ALTER TABLE consult_comment
ADD
CONSTRAINT FK_member_TO_consult_comment -- 회원 -> 1:1상담 댓글
FOREIGN KEY (
fk_idx -- 댓글회원고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 펫케어 이미지
ALTER TABLE petcare_img
ADD
CONSTRAINT FK_petcare_TO_petcare_img -- 반려동물케어 -> 펫케어 이미지
FOREIGN KEY (
fk_care_UID -- 케어코드
)
REFERENCES petcare ( -- 반려동물케어
care_UID -- 케어코드
);

-- #보조기능 관련 제약조건 추가
-- 게시글
ALTER TABLE board_post
ADD
CONSTRAINT FK_board_group_TO_board_post -- 게시판그룹 -> 게시글
FOREIGN KEY (
fk_brd_id -- 게시판그룹코드
)
REFERENCES board_group ( -- 게시판그룹
brd_id -- 게시판그룹코드
);

-- 게시글
ALTER TABLE board_post
ADD
CONSTRAINT FK_member_TO_board_post -- 회원 -> 게시글
FOREIGN KEY (
fk_idx -- 작성자고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 댓글
ALTER TABLE board_comment
ADD
CONSTRAINT FK_board_group_TO_comment -- 게시판그룹 -> 댓글
FOREIGN KEY (
fk_brd_id -- 게시판그룹코드
)
REFERENCES board_group ( -- 게시판그룹
brd_id -- 게시판그룹코드
);

-- 댓글
ALTER TABLE board_comment
ADD
CONSTRAINT FK_board_post_TO_comment -- 게시글 -> 댓글
FOREIGN KEY (
fk_post_id -- 게시글고유번호
)
REFERENCES board_post ( -- 게시글
post_id -- 게시글고유번호
);

-- 댓글
ALTER TABLE board_comment
ADD
CONSTRAINT FK_member_TO_comment -- 회원 -> 댓글
FOREIGN KEY (
fk_idx -- 댓글작성자고유번호
)
REFERENCES member ( -- 회원
idx -- 회원고유번호
);

-- 유기동물후원이미지
--ALTER TABLE funding_img
--	ADD
--	CONSTRAINT FK_funding_TO_funding_img -- 유기동물후원 -> 유기동물후원이미지
--	FOREIGN KEY (
--	fk_fd_id -- 후원코드
--	)
--	REFERENCES funding ( -- 유기동물후원
--	fd_id -- 후원코드
--	);

-- 펀딩결제
--ALTER TABLE funding_payment
--	ADD
--	CONSTRAINT FK_funding_TO_funding_payment -- 유기동물후원 -> 펀딩결제
--	FOREIGN KEY (
--	fk_fd_id -- 후원코드
--	)
--	REFERENCES funding ( -- 유기동물후원
--	fd_id -- 후원코드
--	);

-- 펀딩환불
--ALTER TABLE funding_refund
--	ADD
--	CONSTRAINT FK_funding_payment_TO_funding_refund -- 펀딩결제 -> 펀딩환불
--	FOREIGN KEY (
--	fk_payment_UID -- 결제코드
--	)
--	REFERENCES funding_payment ( -- 펀딩결제
--	payment_UID -- 결제코드
--	);





insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','1','정귀근','605-17-38838', '47258', '부산광역시 부산진구 부전로 87 (부전동)', '1층 서면동물병원',''
,'','seomyun_medical.jpg','월~금',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 18:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 14:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),'쉼',1,1,0,'수술전문병원','안녕하세요. 
서면동물병원입니다. Tel. 051-809-8092  위치 : 서면역 7번 출구 부전2동 주민센터 부근 ▶수술전문동물병원 (※10000마리 이상의 다년간의 수술경험)')


insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','2','김수현','106-23-35564', '06239', '서울시 강남구 역삼동 828-7번지 한동빌딩 1층', '혜민동물병원',''
,'','hyemin_medical.jpg','월~금',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 18:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 14:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),'쉼',1,1,1,'난치병치료전문 한방의료원','난치병치료전문 혜민동물병원 with 한국동물한방의료원 입니다.')

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','3','최기현','825-18-00234', '14549', '경기도 부천시 신흥로 190 위브더스테이트', '1단지상가 2층 214-216호',''
,'','headeun_medical.jpg','365일 24시간 진료',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 21:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 12:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 21:00:00','yyyy-mm-dd hh24:mm:ss'),'안쉼',1,1,1,'노령견전문','저희 24시 해든동물병원은 항상 친절하고 정직과 믿음을 가치로 반려동물들은 물론이고 보호자분들과도 거리감 없는 병원이 되기 위해 노력하겠습니다. 24시간 운영을 기본으로 365일 하루도 빠지지 않고 최선을 다해서 사랑스러운 반려동물들과 그리고 여러분들과 함께하겠습니다. 감사합니다.')


insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','4','하지명, 팽준호','133-24-07642', '05612', '서울특별시 송파구 삼학사로 88 1층', '24시 베스트 동물메디컬센터',''
,'','best_medical.jpg','365일 24시간 진료',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 12:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),'안쉼',1,1,0,'고양이특화진료','말하지 못하는 반려동물이 얼마나, 어떻게, 왜 아픈지,어떻게 해야 오래토록 행복하게 살 수 있는지.... 그것들을 보호자분들께 정확히 알려드리고 반려동물을 위한 최선의 길을 찾아주는 것이 저희 병원의 사명이라고 생각합니다.그 누구보다 기쁠 때 같이 기뻐해주고, 아플 때 같이 아파하며,따뜻한 눈과 마음으로 최선을 다해 돌보겠습니다.쉼 없는 노력과 최첨단 의료시스템의 도입으로 수준 높은24시 잠실 베스트 동물메디컬 센터를 실현하겠습니다.언제나 저희 병원을 사랑해주시는 보호자분들께 감사 인사드리며 앞으로도 언제나 함께하겠습니다.')

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','5','김대현,이동현','489-01-00840', '10387', '경기도 고양시 일산서구 중앙로 1455', ' 116호(주엽동, 대우시티프라자)',''
,'','ilsanwoori_medical.jpg','365일 24시간 진료',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 12:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),'안쉼',1,1,0,'슬개골탈구전문','가장 중요한 것은 믿음과 신뢰라고 생각합니다. 진심으로 반려동물을 아끼고 사랑하는 보호자 분들의 마음을 누구보다 잘 알기에 소중한 반려동물들의 건강, 믿음과 신뢰 그리고 실력으로 보여드리겠습니다. 여러분들의 가족을 위해 언제나 깨어있는 24시 일산우리 동물의료센터가 되겠습니다^^')


insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'dongnimmun', 'qwer1234$', '홍길동', '독립문동물병원', '19700812', 1, '01075369514', 'dongnimmun.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(3, 1, '이관영', '123-45-88890', '03735', '서울 서대문구 통일로 171-1', '냉천동 195', '37.569342', '126.963168'
    , 'dongnimmunHos.png', '월,화,수,목,금', '09:00', '18:00', '12:00', '13:00', '09:00', '15:00', '휴일', 1, 1, 1
    , 0, '5호선 서대문역과 독립문사거리 중간의 서울 금화초등학교 정문 옆에 위치합니다.', '진료과목<br>- 내과, 외과, 정형외과, 피부과 및 산과는 물론 치아건강을 위한 치과 진료 서비스를 제공합니다. <br>- 질병을 치료보다는 예방하는 것이 중요하기 때문에 예방의학과 운영. 각종 예방주사 프로그램 및 스케쥴 관리와 기생충검사, 심장사상충 검사 및 예방 프로그램, 치과 질환 예방 프로그램 운영합니다.<br>- 빠른 치료를 위해서는 정확한 진단이 중요하기에 정확한 진단을 위한 현미경 혈액분석기, 초음파 검사 등 여러 장비를 구비하여 임상병리실을 운영하고 집중치료가 필요한 환자를 위한 .입원실을 운영합니다. <br>- 강아지 뿐만 아니라 고양이, 토끼, 햄스터,기니픽 등을 전문진료하고 있습니다.<br>- 애견미용실을 운영하고 있습니다.'
    ); -- note를 찾아오는길로 바꾸기

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(3, 3, '동물친화적');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(3, 3, '친절한');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(3, 12, '가성비');

-- 4
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'baekseul', 'qwer1234$', '주성범', '백슬동물병원', '19790625', 1, '01095183654', 'baekseul.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(4, 1, '주성범', '123-45-67890', '04501', '서울특별시 중구 만리재로 177', '서울역한라비발디센트럴 105호', '37.554747', '126.965442'
    , 'baekseulHos.png', '화,수,목,금', '10:00', '20:00', '12:00', '13:00', '10:00', '15:00', '휴일', 1, 0, 0
    , 0, '버스 : 손기정체육공원입구 버스승장장, 손기정체육공원 버스승장장<br>전철 : 무조건 1번 출구로 나오셔서 롯데마트&아울렛을 뚫고 건너오시면 숩게 오실 수 있습니다.', '서울역 백슬동물병원은 강아지 슬개골탈구 전문수술 동물병원입니다.<br>작년 2017년도 슬개골탈구 수술 1,000건을 돌파한 실력있는 동물병원입니다.<br>저렴한 비용으로 진행되며, 재발없는 수술을 위한 주성범원장님의 3원칙으로 치료를 진행합니다.<br>현재 슬개골탈구 무료검진 이벤트를 진행하고 있으니 많은 관심 부탁드립니다. 감사합니다.'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 7, '무선안터넷');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 8, '주차');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 10, '세심한');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 15, '슬개골전문');

-- 5
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'gwanghwamun', 'qwer1234$', '이광희', '광화문동물병원', '19860905', 2, '01037651258', 'gwanghwamun.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(5, 1, '신재영', '367-05-00209', '03027', '서울특별시 종로구 사직로9길 6-1', '사직동 주민센터 옆', '37.576761', '126.968757'
    , 'gwanghwamunHos.png', '월,화,수,목,금', '09:00', '20:30', '12:00', '13:00', '10:00', '15:00', '휴일', 1, 1, 0
    , 0, '3호선 경복궁역 사직동주민센터 옆', '돌봄과 치유의 공동체'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 7, '무선안터넷');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 8, '주차');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 17, '중성화수술전문');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 34, '미용');

-- 6
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'gwanghwamun', 'qwer1234$', '김푸른', '푸른온누리약국', '19950930', 2, '01034683514', 'blueOnNuri.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(5, 2, '온누리', '623-07-51312', '03181', '서울특별시 종로구 새문안로 19', '문문수세무회계', '37.567609', '126.967876'
    , 'blueOnNuriHos.png', '월,화,수,목,금', '08:30', '19:30', '12:00', '13:00', '08:30', '14:00', '휴일', 1, 1, 0
    , 0, '서대문역(5호선) 4번 출구 도보 2분<br>충정로역(2호선,5호선) 9번 출구 도보 14분<br>광화문역(5호선) 1번 출구 도보 15분<br>시청역(1호선,2호선) 10번 출구 도보 16분', '병의원 처방조제 및 동물의약품 취급'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(6, 1, '깨끗함');

-- 7
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'gyeonghuigung', 'qwer1234$', '김경희', '경희궁햇살약국', '19901216', 2, '01015379583', 'gyeonghuigung.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(7, 2, '김경희', '957-02-51384', '03165', '서울특별시 종로구 송월길 99', '경희궁자이 상가 203동 2층 경희궁햇살약국', '37.570986', '126.964416'
    , 'gyeonghuigungHos.png', '월, 화,수,목,금', '09:00', '19:00', '12:00', '13:00', '09:00', '19:00', '09:00~14:00', 1, 0, 0
    , 0, '서대문역(5호선) 4번 출구 도보 10분<br>독립문역(3호선) 3번 출구 도보 10분', '병의원 처방조제 일반의약품 건강기능식품 서대문구 동물약국 종로구 동물약국 영천시장 건너편 경희궁자이 상가 2층 약국 튼튼소아과 옆 경희궁햇살약국입니다.'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(7, 7, '무선안터넷');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(7, 8, '주차');


-- 기업회원 insert 5개
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'youjs', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '유재석', '메뚜기', '19981212', 1, 'spTAeO5ydUaLRUSt9gs4NQ==', 'youjs.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'haha', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '하하', '하하하', '19880213', 1, 'spTAeO5ydUaLRUSt9gs4NQ==', 'haha.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'parkms', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '박명수', '이인자', '20010312', 2, 'spTAeO5ydUaLRUSt9gs4NQ==', 'parkms.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'yangsh', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '양세형', '양세바리', '19930618', 2, 'spTAeO5ydUaLRUSt9gs4NQ==', 'yangsh.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'jungjh', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '정준하', '식신', '20020331', 2, 'spTAeO5ydUaLRUSt9gs4NQ==', 'jungjh.jpg', 2, default, default, default, default);


-- 기업회원 상세 insert 5개
insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 1, '유재석', '3828839198', '23123', '서울특별시 동대문구 전농1동', '다일천사병원', '37.576869', '127.047577', 'dail.jpg'
, '월,화,수,목,금', '2019-01-17 08:00:00', '2019-01-17 18:00:00', '2019-01-17 12:00:00', '2019-01-17 13:00:00', '2019-01-17 09:00:00', '2019-01-17 15:00:00', '일', 1, 0, 0, 0, '공휴일', '어서오세요 다일천사병원입니다. 강아지전문병원이에요.');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 1, '하하', '2948162923', '04057', '서울특별시 서대문구 홍제2동', '한솔동물병원', '37.586140', '126.948811', 'hansol.jpg'
, '월,화,수,목,금', '2019-01-17 09:00:00', '2019-01-17 21:00:00', '2019-01-17 12:00:00', '2019-01-17 13:00:00', '2019-01-17 09:00:00', '2019-01-17 15:00:00', '일', 1, 0, 0, 0, '노령전문', '안녕하세요 한솔동물병원입니다.');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 1, '박명수', '2917293817', '02720', '서울특별시 은평구 응암동', '24시스마트동물메디컬센터', '37.600714', '126.918242', 'medical.jpg'
, '월,화,수,목,금', '2019-01-17 09:00:00', '2019-01-17 20:00:00', '2019-01-17 13:00:00', '2019-01-17 14:00:00', '2019-01-17 09:00:00', '2019-01-17 14:00:00', '공휴일', 1, 0, 0, 0, '24시간', '안녕하세요 24시간 돌보는 스마트동물메디컬 센터입니다. 부담없이 오세요~');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 2, '양세형', '9583738495', '23123', '서울특별시 성동구 금호1가동', '금호동물약국', '37.559677', '127.024500', 'geumho.jpg'
, '월,화,수,목,금', '2019-01-17 08:00:00', '2019-01-17 20:00:00', '2019-01-17 12:00:00', '2019-01-17 13:00:00', '2019-01-17 08:00:00', '2019-01-17 15:00:00', '공휴일', 1, 0, 0, 0, '24시간', '처방 확실하게 해드리겠습니다!!');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 2, '정준하', '4827394837', '01025', '서울특별시 중구 회현동3가', '한국화이자동물약품', '37.565859', '126.984498', 'korea.jpg'
, '월,화,수,목,금', '2019-01-17 10:00:00', '2019-01-17 18:00:00', '2019-01-17 13:00:00', '2019-01-17 14:00:00', '2019-01-17 09:00:00', '2019-01-17 15:00:00', '공휴일', 1, 0, 0, 0, '24시간', '안녕하세요 한국화이자동물약품입니다.’);


