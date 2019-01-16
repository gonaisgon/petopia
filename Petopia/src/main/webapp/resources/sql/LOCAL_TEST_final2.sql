show user;

-- #������Ʈ ����
-- [190106] �������� ������, �������ȯ�� ���� ���̺� �� ������
-- [190107] 1; ���� ���� ����
-- [190107] 2; ���ȸ���� ���̺��� Ư�̻����� ���� ã�ƿ��±� �÷� �߰�

---

-- ���� ��ȸ
show user;

-- ��� ���̺� ��ȸ
select * from user_tables;

-- ��� ������ ��ȸ
select * from user_sequences;

-- ��� �������� ��ȸ
select * from user_constraints;

-- ���̺� ���� ��ɹ�
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

-- ������ ���� ��ɹ�
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

-- ȸ��
CREATE TABLE member (
idx NUMBER NOT NULL, -- ȸ��������ȣ
userid VARCHAR2(255) NOT NULL, -- �̸��Ͼ��̵�
pwd VARCHAR2(100) NOT NULL, -- ��й�ȣ
name VARCHAR2(100) NOT NULL, -- �̸�
nickname VARCHAR2(100) NOT NULL, -- �г���
birthday VARCHAR2(50) NOT NULL, -- �������
gender NUMBER(1) default 1 NOT NULL, -- ����
phone VARCHAR2(100) NOT NULL, -- ����ó
profileimg VARCHAR2(100) NOT NULL, -- �����ʻ���
membertype NUMBER(1) NOT NULL, -- ȸ��Ÿ��
point NUMBER default 0 NOT NULL, -- ����Ʈ
totaldeposit NUMBER default 0 NOT NULL, -- ������ġ��
noshow NUMBER default 0 NOT NULL, -- �������
registerdate DATE default sysdate NOT NULL -- ��������

    , CONSTRAINT PK_member PRIMARY KEY (idx) -- ȸ�� �⺻Ű
    , CONSTRAINT uq_member_userid UNIQUE (userid) -- ȸ�����̵�UQ   
    , CONSTRAINT ck_member_gender check(gender in(1,2)) -- ȸ������ üũ����   
    , CONSTRAINT ck_member_memtype check(membertype in(1, 2, 3)) -- ȸ��Ÿ�� üũ����

);

alter table member
add fileName VARCHAR2(100) NOT NULL;

-- ��޹�ȣ ����
ALTER TABLE member DROP COLUMN fk_level_UID;

CREATE TABLE login_log (
idx NUMBER NOT NULL, -- ȸ��������ȣ
fk_userid VARCHAR2(255) NOT NULL, -- �̸��Ͼ��̵�
fk_pwd VARCHAR2(100) NOT NULL, -- ��й�ȣ
lastlogindate DATE NOT NULL, -- �α����Ͻ�
member_status NUMBER(1) default 1 NOT NULL -- ȸ������ Ȱ��1 �޸�0

    , CONSTRAINT PK_login_log PRIMARY KEY (idx) -- �α��� �⺻Ű
    , CONSTRAINT CK_login_log_status check(member_status in(0,1)) -- ȸ������ üũ����
    , CONSTRAINT FK_member_TO_login_log FOREIGN KEY (idx) REFERENCES member (idx)

);

-- ȸ�� ������
-- drop sequence seq_member;
create sequence seq_member
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ���ȸ����
CREATE TABLE biz_info (
idx_biz NUMBER NOT NULL, -- ����/�౹������ȣ
biztype NUMBER(1) NOT NULL, -- �������
repname VARCHAR2(50) NOT NULL, -- ��ǥ�ڸ�
biznumber VARCHAR2(100) NOT NULL, -- ����ڹ�ȣ
postcode VARCHAR2(10) NOT NULL, -- �����ȣ
addr1 VARCHAR2(100) NOT NULL, -- �ּ�
addr2 VARCHAR2(100) NOT NULL, -- �ּ�2
latitude VARCHAR2(100) NOT NULL, -- ����
longitude VARCHAR2(100) NOT NULL, -- �浵
prontimg VARCHAR2(100) NOT NULL, -- ��ǥ�̹���
weekday VARCHAR2(100) NOT NULL, -- ����; ��~��(�� 5), ȭ~��(�� 4), ��, ��, ��(�� 3)
wdstart DATE NOT NULL, -- ���Ͻ��۽ð�
wdend DATE NOT NULL, -- ��������ð�
lunchstart DATE NOT NULL, -- ���ɽ��۽ð�
lunchend DATE NOT NULL, -- ��������ð�
satstart DATE NOT NULL, -- ����Ͻ���
satend DATE NOT NULL, -- ���������
dayoff VARCHAR2(100) NOT NULL, -- �Ͽ���/������
dog NUMBER(1) NOT NULL, -- ������
cat NUMBER(1) NOT NULL, -- �����
smallani NUMBER(1) NOT NULL, -- �ҵ���
etc NUMBER(1) NOT NULL, -- ��Ÿ
easyway VARCHAR2(255) NULL, -- ã�ƿ��±�
intro CLOB NOT NULL -- �Ұ���
,CONSTRAINT PK_biz_info -- ���ȸ���� �⺻Ű
PRIMARY KEY (
idx_biz -- ����/�౹������ȣ
)
,CONSTRAINT UK_biz_info -- ���ȸ���� ����ũ ����
UNIQUE (
biznumber -- ����ڹ�ȣ
)
,CONSTRAINT ck_biz_info_dog -- ������ üũ����
check(dog in(1,0))
,CONSTRAINT ck_biz_info_cat -- ����� üũ����
check(cat in(1,0))
,CONSTRAINT ck_biz_info_smallani -- �ҵ��� üũ����
check(smallani in(1,0))
,CONSTRAINT ck_biz_info_etc -- ��Ÿ üũ����
check(etc in(1,0))
,CONSTRAINT FK_member_TO_biz_info -- ȸ�� -> ���ȸ����
FOREIGN KEY (
idx_biz -- ����/�౹������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
)
);

-- ���ȸ���߰��̹���
CREATE TABLE biz_info_img (
img_UID NUMBER NOT NULL, -- �̹���������ȣ
fk_idx_biz NUMBER NOT NULL, -- ����/�౹������ȣ
imgfilename VARCHAR2(100) NOT NULL -- �̹������ϸ�
,CONSTRAINT PK_biz_info_img -- ���ȸ���߰��̹��� �⺻Ű
PRIMARY KEY (
img_UID -- �̹���������ȣ
)
);

ALTER TABLE biz_info_img
ADD
CONSTRAINT FK_biz_info_TO_biz_info_img -- ���ȸ���� -> ���ȸ���߰��̹���
FOREIGN KEY (
fk_idx_biz -- ����/�౹������ȣ
)
REFERENCES biz_info ( -- ���ȸ����
idx_biz -- ����/�౹������ȣ
);

create sequence biz_info_img_seq --������� �̹���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �Ƿ���
CREATE TABLE doctors (
doc_UID NUMBER NOT NULL, -- �Ƿ���������ȣ
fk_idx_biz NUMBER NOT NULL, -- ����/�౹������ȣ
docname VARCHAR2(100) NOT NULL, -- �Ƿ�����
dog NUMBER(1) NOT NULL, -- ������
cat NUMBER(1) NOT NULL, -- �����
smallani NUMBER(1) NOT NULL, -- �ҵ���
etc NUMBER(1) NOT NULL -- ��Ÿ
,CONSTRAINT PK_doctors -- �Ƿ��� �⺻Ű
PRIMARY KEY (
doc_UID -- �Ƿ���������ȣ
)
,CONSTRAINT ck_doctors_dog -- ������ üũ����
check(dog in(1,0))
,CONSTRAINT ck_doctors_cat -- ����� üũ����
check(cat in(1,0))
,CONSTRAINT ck_doctors_smallani -- �ҵ��� üũ����
check(smallani in(1,0))
,CONSTRAINT ck_doctors_etc -- ��Ÿ üũ����
check(etc in(1,0))
);

create sequence seq_doctors_UID --�Ƿ���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �±� ���̺�
--drop table recommend_tag purge;
CREATE TABLE recommend_tag (
tag_UID NUMBER NOT NULL, -- �±׹�ȣ
tag_type VARCHAR2(100) NOT NULL, -- �о�
tag_name VARCHAR2(100) NOT NULL -- �±��̸�
,CONSTRAINT PK_recommend_tag PRIMARY KEY(tag_UID)
);

ALTER TABLE recommend_tag
ADD CONSTRAINT UQ_recommend_tag_name UNIQUE(tag_name);

-- �±� ������
create sequence seq_recommend_tag_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

CREATE TABLE have_tag (
fk_tag_UID NUMBER NOT NULL, -- �±׹�ȣ
fk_tag_name VARCHAR2(100) NOT NULL, -- �±��̸�
fk_idx NUMBER NOT NULL -- ȸ��������ȣ
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

-- ����
CREATE TABLE review (
review_UID NUMBER NOT NULL, -- �����ڵ�
fk_idx_biz NUMBER NOT NULL, -- ����/�౹������ȣ
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
fk_reservation_UID NUMBER NOT NULL, -- �����ڵ�
startpoint NUMBER NOT NULL, -- ����
fk_userid VARCHAR2(255) NOT NULL, -- �ۼ��ھ��̵�
fk_nickname VARCHAR2(100) NOT NULL, -- �ۼ��ڴг���
rv_contents CLOB NOT NULL, -- ���ٸ��䳻��
rv_status NUMBER(1) NOT NULL, -- �������
rv_blind NUMBER(1) NOT NULL, -- �������ε���� 0 ���� 1 �弳 2 ���ȸ����û 3 �Ű��� 4 ��Ÿ
rv_writeDate date default sysdate NOT NULL -- ���䳯¥
,CONSTRAINT PK_review PRIMARY KEY (review_UID)
,CONSTRAINT ck_review_status -- ������� üũ����
check(rv_status in(0,1))
,CONSTRAINT ck_review_blind -- �������ε���� üũ����
check(rv_blind in(0,1,2,3,4))
);

-- ���� ������
create sequence seq_review_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ������(reviewComment)
CREATE TABLE review_comment (
rc_id NUMBER NOT NULL, -- �����۹�ȣ
fk_review_UID NUMBER NOT NULL, -- �����ڵ�
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
rc_content CLOB NOT NULL, -- ��۳���
rc_writedate DATE NOT NULL, -- ��۳�¥
fk_rc_id NUMBER NOT NULL, -- ����� ������ȣ
rc_group NUMBER NOT NULL, -- ��۱׷��ȣ
rc_g_odr NUMBER NOT NULL, -- ��۱׷����
rc_depth NUMBER NOT NULL, -- ����
rc_blind NUMBER(1) NOT NULL, -- ����ε�ó������ 0 ���� 1 �弳 2 ���ȸ����û 3 �Ű��� 4 ��Ÿ
rc_status NUMBER(1) NULL, -- ����
CONSTRAINT PK_review_comment PRIMARY KEY(rc_id)
,CONSTRAINT ck_rc_status -- �����ۻ��� üũ����
check(rc_status in(0,1))
,CONSTRAINT ck_rc_blind -- ����ε�ó������ üũ����
check(rc_blind in(0,1,2,3,4))
);

-- ���� ��� ������
create sequence seq_rc_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ������
CREATE TABLE schedule (
schedule_UID NUMBER NOT NULL, -- �������ڵ�
fk_idx_biz NUMBER NOT NULL, -- ����/�౹������ȣ
schedule_DATE DATE NOT NULL, -- ��������
schedule_status NUMBER(1) default 0 NOT NULL -- �������� ����: 1/ �񿹾�: 0/default: 0
,CONSTRAINT PK_schedule -- ������ �⺻Ű
PRIMARY KEY (schedule_UID)
,CONSTRAINT ck_sch_status -- �������� üũ����
check(schedule_status in(1,0))
,CONSTRAINT fk_sch_idx_biz -- ���ȸ���� -> ������
FOREIGN KEY (fk_idx_biz)	REFERENCES biz_info(idx_biz)
);

-- ������
create sequence seq_schedule_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ����
CREATE TABLE reservation (
reservation_UID NUMBER NOT NULL, -- �����ڵ�
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
fk_schedule_UID NUMBER NOT NULL, -- �������ڵ�
fk_pet_UID NUMBER NOT NULL, -- �ݷ������ڵ�
bookingdate DATE default sysdate NOT NULL, -- ����Ϸ��Ͻ�
reservation_DATE DATE NOT NULL, -- �湮������
reservation_status NUMBER(1) NOT NULL, -- ����������� 1 ����Ϸ�/ 2 �����Ϸ� / 3 ����Ϸ� / 4 ��� / 5 no show
reservation_type NUMBER NOT NULL -- ����Ÿ�� 1 ���� / 2 �������� / 3 ����/ 4 ȣ�ڸ�

    ,CONSTRAINT PK_reservation -- ���� �⺻Ű
    	PRIMARY KEY (reservation_UID)
    ,CONSTRAINT ck_rev_status -- ����������� üũ����
    	check(reservation_status in(1,2,3,4,5))
    ,CONSTRAINT ck_rev_type -- ����Ÿ�� üũ����
    	check(reservation_type in(1, 2, 3, 4))
    ,CONSTRAINT FK_member_TO_reservation -- ȸ�� -> ����
    	FOREIGN KEY (
    		fk_idx -- ȸ��������ȣ
    	)
    	REFERENCES member ( -- ȸ��
    		idx -- ȸ��������ȣ
    	)
    ,CONSTRAINT FK_schedule_TO_reservation -- ������ -> ����
    	FOREIGN KEY (
    		fk_schedule_UID -- �������ڵ�
    	)
    	REFERENCES schedule ( -- ������
    		schedule_UID -- �������ڵ�
    	)

);

-- ����
create sequence seq_reservation_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �ݷ���������
CREATE TABLE pet_info (
pet_UID NUMBER NOT NULL, -- �ݷ������ڵ�
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
pet_name VARCHAR2(100) NOT NULL, -- �ݷ������̸�
pet_type VARCHAR2(50) NOT NULL, -- ���� dog/cat/smallani/etc
pet_birthday VARCHAR2(100) NULL, -- �ݷ���������
pet_size VARCHAR2(2) NULL, -- ������ L/M/S
pet_weight NUMBER NULL, -- ������
pet_gender NUMBER(1) NULL, -- ���� 1 �� 2 ��
pet_neutral NUMBER(1) NULL, -- �߼�ȭ���� 1 �� / 0 ���� / 2 ��
medical_history CLOB NULL, -- ���ź��±���
allergy CLOB NULL, -- �˷�������
pet_profileimg VARCHAR2(255) NULL -- �ݷ����������ʻ���
,CONSTRAINT PK_pet_info -- �ݷ��������� �⺻Ű
PRIMARY KEY (pet_UID)
,CONSTRAINT ck_petinfo_gender -- �ݷ��������� üũ����
check(pet_gender in(1,2))
,CONSTRAINT ck_petinfo_neutral -- �߼�ȭ���� üũ����
check(pet_neutral in(0,1,2))
);

create sequence seq_pet_info_UID --�ݷ���������
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ���
CREATE TABLE vaccine (
vaccine_UID NUMBER NOT NULL, -- ����ڵ�
vaccine_name VARCHAR2(100) NOT NULL, -- ��Ÿ�
dog NUMBER(1) NOT NULL, -- ������
cat NUMBER(1) NOT NULL, -- �����
smallani NUMBER(1) NOT NULL -- �ҵ���
,CONSTRAINT PK_vaccine -- ��� �⺻Ű
PRIMARY KEY (vaccine_UID)
,CONSTRAINT ck_vaccine_dog -- ������ üũ����
check(dog in(1,0))
,CONSTRAINT ck_vaccine_cat -- ����� üũ����
check(cat in(1,0))
,CONSTRAINT ck_vaccine_smallani -- �ҵ��� üũ����
check(smallani in(1,0))
);

create sequence seq_vaccine_UID --���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��������
CREATE TABLE shots (
shots_UID NUMBER NOT NULL, -- �����ڵ�
fk_pet_UID NUMBER NOT NULL, -- �ݷ������ڵ�
fk_vaccine_UID NUMBER NOT NULL, -- ����ڵ�
vaccine_name VARCHAR2(100) NOT NULL -- ��Ÿ�
,CONSTRAINT PK_shots -- �������� �⺻Ű
PRIMARY KEY (shots_UID)
);

create sequence seq_shots_UID --����
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �ݷ��������
CREATE TABLE pet_list (
petlist_UID NUMBER NOT NULL, -- ��Ϲ�ȣ
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
fk_pet_UID NUMBER NOT NULL, -- �ݷ������ڵ�
fk_pet_name VARCHAR2(100) NOT NULL -- �ݷ�������
,CONSTRAINT PK_pet_list -- �ݷ�������� �⺻Ű
PRIMARY KEY (petlist_UID)
);

-- �ݷ������ɾ�
CREATE TABLE petcare (
care_UID NUMBER NOT NULL, -- �ɾ��ڵ�
fk_pet_UID NUMBER NOT NULL, -- �ݷ������ڵ�
fk_caretype_UID NUMBER NOT NULL, -- �ɾ�Ÿ���ڵ�
care_contents CLOB NOT NULL, -- ����
care_memo CLOB NULL, -- �޸�
care_start DATE NOT NULL, -- �����Ͻ�
care_end DATE NOT NULL, -- �����Ͻ�
care_alarm NUMBER(10) NULL, -- �˸����� ���� 0/5���� 5/10���� 10/�Ϸ��� 1440 (�� ���� ȯ��)
care_date DATE NOT NULL -- �ɾ��� ����
,CONSTRAINT PK_petcare -- �ݷ������ɾ� �⺻Ű
PRIMARY KEY (care_UID)
);

create sequence seq_petcare_UID --���ɾ�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �ɾ�Ÿ��
CREATE TABLE caretype (
caretype_UID NUMBER NOT NULL, -- �ɾ�Ÿ���ڵ�
caretype_name VARCHAR2(100) NOT NULL, -- �ɾ�Ÿ�Ը�
caretype_info CLOB NOT NULL -- �ɾ�Ÿ�Ժ�����
,CONSTRAINT PK_caretype -- �ɾ�Ÿ�� �⺻Ű
PRIMARY KEY (caretype_UID)
);

create sequence seq_caretype_UID --�ɾ� Ÿ��
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ������
CREATE TABLE chart (
chart_UID NUMBER NOT NULL, -- ��Ʈ�ڵ�
fk_pet_UID NUMBER NOT NULL, -- �ݷ������ڵ�
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
chart_type NUMBER(1) NOT NULL, -- ����Ÿ�� 0 �౹/1 ���� / 2 �������� / 3 ���� / 4 ȣ�ڸ�
biz_name VARCHAR2(100) NOT NULL, -- ����/�౹��
bookingdate DATE NULL, -- ����Ϸ��Ͻ�
reservation_DATE DATE NULL, -- �湮������
doc_name VARCHAR2(100) NULL, -- ���ǻ��
cautions CLOB NULL, -- ���ǻ���
chart_contents CLOB NULL, -- ����
payment_pay NUMBER NULL, -- ��뿹ġ��
payment_point NUMBER NULL, -- �������Ʈ
addpay NUMBER NULL, -- ���κδ��(�߰������ݾ�)
totalpay NUMBER NULL -- ������Ѿ�
,CONSTRAINT PK_chart -- ������ �⺻Ű
PRIMARY KEY (chart_UID)
,CONSTRAINT ck_chart_type -- ����Ÿ�� üũ����
check(chart_type in(0,1,2,3,4))
);

create sequence chart_seq --��Ʈ
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��ġ�ݰ���
CREATE TABLE payment (
payment_UID NUMBER NOT NULL, -- �����ڵ�
fk_reservation_UID NUMBER NOT NULL, -- �����ڵ�
payment_total NUMBER NOT NULL, -- �����Ѿ�
payment_point NUMBER NOT NULL, -- ��������Ʈ
payment_pay NUMBER NOT NULL, -- �ǰ����ݾ�
payment_date DATE NOT NULL, -- ��������
payment_status NUMBER(1) NOT NULL -- �������� 1 �����Ϸ� / 0 �̰��� / 2 ��� / 3 ȯ��
,CONSTRAINT PK_payment PRIMARY KEY (payment_UID)
,CONSTRAINT CK_payment_status -- �������� üũ����
check(payment_status in(0,1,2,3))
);

-- ��ġ�ݰ���
create sequence seq_payment_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��ġ��
CREATE TABLE deposit (
deposit_UID NUMBER NOT NULL, -- ��ġ���ڵ�
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
depositcoin NUMBER NOT NULL, -- ��ġ��
deposit_status NUMBER(1) default 1 NOT NULL, -- ��ġ�ݻ��� 1 ��밡�� / 0 ���Ұ��� / 2 ȯ����ҽ�û / 3 ���
deposit_type VARCHAR2(50) NOT NULL, -- ��������
deposit_date DATE default sysdate NOT NULL -- ��������
,CONSTRAINT PK_deposit -- ��ġ�� �⺻Ű
PRIMARY KEY (deposit_UID)
,CONSTRAINT CK_deposit_status -- ��ġ�ݻ��� üũ����
check(deposit_status in(0,1,2,3))
);

-- ��ġ��
create sequence seq_deposit_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ȯ��
CREATE TABLE refund (
refund_UID NUMBER NOT NULL, -- ȯ���ڵ�
fk_payment_UID NUMBER NOT NULL, -- �����ڵ�
fk_idx NUMBER NOT NULL, -- ȯ�ҹ���ȸ����ȣ
fk_idx_biz NUMBER NOT NULL, -- ������ȣ
refund_DATE DATE default sysdate NOT NULL, -- ȯ�ҽ�û����
add_DATE DATE NOT NULL, -- �������
refund_reason VARCHAR2(255) NOT NULL, -- ȯ�һ���
refund_money NUMBER NOT NULL, -- ȯ�ұݾ�
refund_status NUMBER(1) default 0 NOT NULL -- ���ο��� 1Ȯ�� 0��Ȯ��
,CONSTRAINT PK_refund -- ȯ�� �⺻Ű
PRIMARY KEY (refund_UID)
,CONSTRAINT CK_refund_status -- ���ο��� üũ����
check(refund_status in(0,1))
);

-- ȯ��
create sequence seq_refund_refund_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �˸�
CREATE TABLE notification (
not_UID NUMBER NOT NULL, -- �˸��ڵ�
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
not_type NUMBER(1) NOT NULL, -- �˸����� 0 ��ü���� / 1 petcare / 2 reservation / 3 payment / 4 board
not_message CLOB NOT NULL, -- �˸�����
not_date DATE NOT NULL, -- �˸��߼��Ͻ�
not_readcheck NUMBER(1) default 0 NOT NULL -- Ȯ�ο��� Ȯ�� 1 / ��Ȯ�� 0
,CONSTRAINT PK_notification -- �˸� �⺻Ű
PRIMARY KEY (not_UID)
,CONSTRAINT CK_not_type -- �˸����� üũ����
check(not_type in(0,1,2,3,4))
,CONSTRAINT CK_not_readcheck -- Ȯ�ο��� üũ����
check(not_readcheck in(0,1))
);

create sequence seq_notification_UID --�˶�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��ġ�����
CREATE TABLE withdraw (
withdraw_UID NUMBER NOT NULL, -- ����ڵ�
fk_deposit_UID NUMBER NOT NULL, -- ��ġ���ڵ�
withdraw_money NUMBER NOT NULL, -- ��ݿ�û�ݾ�
withdraw_status NUMBER(1) default 0 NOT NULL -- ��ݻ��� 1 �Ϸ� / 0 ���
,CONSTRAINT PK_withdraw -- ��ġ����� �⺻Ű
PRIMARY KEY (withdraw_UID)
,CONSTRAINT CK_withdraw_status -- ��ݻ��� üũ����
check(withdraw_status in(0,1))
);

-- ��ġ�����
create sequence seq_withdraw_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ��ġ�� ��볻��
CREATE TABLE dep_use (
dep_use_UID NUMBER NOT NULL, -- ��볻���ڵ�
fk_deposit_UID NUMBER NOT NULL, -- ��ġ���ڵ�
fk_payment_UID NUMBER NOT NULL, -- �����ڵ�
fk_reservation_UID NUMBER NOT NULL, -- �����ڵ�
depu_money NUMBER NOT NULL, -- ���ݾ�
deposit_usedate DATE default sysdate NOT NULL -- �������
,CONSTRAINT PK_dep_use -- ��ġ�� ��볻�� �⺻Ű
PRIMARY KEY (dep_use_UID)
);

-- ��볻��
create sequence seq_dep_use_UID
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ó����
CREATE TABLE prescription (
rx_UID number NOT NULL, -- ó���ڵ�
chart_UID NUMBER NOT NULL, -- ��Ʈ�ڵ�
rx_name varchar2(100) NOT NULL, -- ó���
dose_number varchar2(100) NULL, -- ����Ƚ��
dosage varchar2(100) NULL, -- ����뷮
rx_notice CLOB NULL, -- ó��ȳ�
rx_cautions varchar2(100) NULL, -- ���ǻ���
rx_regName varchar2(100) NOT NULL -- ����ѻ��
,CONSTRAINT PK_prescription -- ó���� �⺻Ű
PRIMARY KEY (rx_UID)
);

create sequence seq_prescription_UID --ó��
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ȭ�� ���(video advice)
CREATE TABLE video_advice (
va_UID NUMBER NOT NULL, -- ȭ���� ��ȣ
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
fk_idx_biz NUMBER NOT NULL, -- ����/�౹������ȣ
chatcode VARCHAR2(20) NOT NULL, -- ä�ù� �ڵ�
fk_userid VARCHAR2(255) NOT NULL, -- ȸ�����̵�
fk_name_biz VARCHAR2(100) NOT NULL, -- ������
fk_docname VARCHAR2(100) NOT NULL, -- ���ǻ��
usermessage CLOB NULL, -- ȸ���� ���� �޼���
docmessage CLOB NULL, -- ���ǻ簡 ���� �޼���
umtime DATE NULL, -- ȸ���� �޼������� �ð�
dmtime DATE NULL, -- ���ǻ簡 �޼������� �ð�
startTime date default sysdate NOT NULL, -- ȭ��ä�� ���۽ð�
endTime date NULL -- ȭ��ä�� ����ð�

    ,CONSTRAINT PK_video_advice -- ȭ�� ���(video advice) �⺻Ű
    	PRIMARY KEY (va_UID)

);

create sequence seq_video_advice_UID --ȭ����
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

------------------------- ���� ������� �� --------



-- 1:1���
CREATE TABLE consult (
consult_UID NUMBER NOT NULL, -- ����ڵ�
fk_idx NUMBER NOT NULL, -- ȸ��������ȣ
cs_pet_type NUMBER(1) NOT NULL, -- �����з� 1 ������ / 2 ����� / 3 �ҵ��� / 4 ��Ÿ
cs_title VARCHAR2(100) NOT NULL, -- �������
cs_contents CLOB NOT NULL, -- ��㳻��
cs_hit NUMBER NOT NULL, -- ��ȸ��
cs_writeday DATE NOT NULL, -- �ۼ�����
cs_secret NUMBER(1) NOT NULL -- �������� 0 ����� / 1 ����
,CONSTRAINT PK_consult -- 1:1��� �⺻Ű
PRIMARY KEY (consult_UID)
,CONSTRAINT ck_consult_type -- �����з� üũ����
check(cs_pet_type in(1,2,3,4))
,CONSTRAINT ck_cs_secret -- �������� üũ����
check(cs_secret in(0,1))
);

create sequence seq_consult_UID --1:1 ���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 1:1��� ���
CREATE TABLE consult_comment (
cmt_id NUMBER NOT NULL, -- ��۰�����ȣ
fk_consult_UID NUMBER NOT NULL, -- ����ڵ�
fk_idx NUMBER NOT NULL, -- ���ȸ��������ȣ
cscmt_nickname VARCHAR2(100) NOT NULL, -- ����ۼ���
cscmt_contents CLOB NOT NULL, -- ��۳���
cscmt_writeday DATE NOT NULL, -- ����ۼ��Ͻ�
fk_cmt_id NUMBER NOT NULL, -- ����� ������ȣ
cscmt_group NUMBER default 0 NOT NULL, -- ��۱׷��ȣ
cscmt_g_odr NUMBER default 0 NOT NULL, -- ��۱׷����
cscmt_depth NUMBER default 0 NOT NULL, -- ����
cscmt_del NUMBER(1) default 1 NOT NULL -- �������� 0���� / 1 ��밡��
,CONSTRAINT PK_consult_comment PRIMARY KEY (cmt_id)
,CONSTRAINT ck_cscmt_del -- �������� üũ����
check(cscmt_del in(1,0))
);

create sequence seq_consult_comment --1:1 ��� ���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ���ɾ� �̹���
CREATE TABLE petcare_img (
pc_img_UID NUMBER NOT NULL, -- �̹�����ȣ
fk_care_UID NUMBER NOT NULL, -- �ɾ��ڵ�
pc_img_name VARCHAR2(255) NOT NULL -- �̹�����
,CONSTRAINT PK_petcare_img -- ���ɾ� �̹��� �⺻Ű
PRIMARY KEY (pc_img_UID)
);

create sequence petcare_img_seq --���ɾ� �̹���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �Խ��Ǳ׷�
CREATE TABLE board_group (
brd_id NUMBER NOT NULL, -- �Խ��Ǳ׷��ڵ�
brd_name VARCHAR2(20) NOT NULL, -- �Խ��Ǹ�
brd_grant NUMBER(1) NOT NULL -- �۾������ (1, 2, 3)
,CONSTRAINT PK_board_group -- �Խ��Ǳ׷� �⺻Ű
PRIMARY KEY (brd_id)
,CONSTRAINT ck_brd_grant -- �۾������ üũ����
check(brd_grant in(1,2,3))
);

create sequence board_group_seq --�Խ��� �׷�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- �Խñ�
CREATE TABLE board_post (
post_id NUMBER NOT NULL, -- �Խñ۰�����ȣ
fk_brd_id NUMBER NOT NULL, -- �Խ��Ǳ׷��ڵ�
post_title VARCHAR2(100) NOT NULL, -- �Խñ�����
post_contents CLOB NOT NULL, -- �Խñ۳���
fk_idx NUMBER NOT NULL, -- �ۼ��ڰ�����ȣ
fk_nickname VARCHAR2(100) NOT NULL, -- �ۼ���
post_writeday DATE NOT NULL, -- �ۼ���
post_hit NUMBER NOT NULL, -- ��ȸ��
post_del NUMBER(1) NOT NULL, -- ��������
post_repcnt NUMBER NOT NULL, -- ��ۼ�
post_imgfilename VARCHAR2(255) NULL -- ��ǥ�̹���
,CONSTRAINT PK_board_post -- �Խñ� �⺻Ű
PRIMARY KEY (post_id)
,CONSTRAINT ck_post_del -- �������� üũ����
check(post_del in(0,1))
);

create sequence seq_board_post --�Խñ�
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ���
CREATE TABLE board_comment (
cmt_id NUMBER NOT NULL, -- ��۰�����ȣ
fk_brd_id NUMBER NOT NULL, -- �Խ��Ǳ׷��ڵ�
fk_post_id NUMBER NOT NULL, -- �Խñ۰�����ȣ
fk_idx NUMBER NOT NULL, -- ����ۼ��ڰ�����ȣ
fk_nickname VARCHAR2(100) NOT NULL, -- ����ۼ���
cmt_contents CLOB NOT NULL, -- ��۳���
cmt_writeday DATE NOT NULL, -- ����ۼ��Ͻ�
cmt_group NUMBER NOT NULL, -- ��۱׷��ȣ
cmt_g_odr NUMBER NOT NULL, -- ��۱׷����
cmt_depth NUMBER NOT NULL, -- ����
cmt_del NUMBER(1) NOT NULL -- ��������
,CONSTRAINT PK_comment PRIMARY KEY (cmt_id)
,CONSTRAINT ck_cmt_del -- �������� üũ����
check(cmt_del in(0,1))
);

create sequence board_comment_seq --���
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

## ---- �̺�Ʈ
--CREATE TABLE event (
--	ev_id NUMBER NOT NULL, -- �̺�Ʈ�ڵ�
--	ev_title VARCHAR2(255) NOT NULL, -- �̺�Ʈ����
--	ev_contents CLOB NOT NULL, -- �̺�Ʈ����
--	ev_imgfilename VARCHAR2(255) NOT NULL, -- �̺�Ʈ���
--	ev_start DATE NOT NULL, -- �̺�Ʈ����
--	ev_end DATE NOT NULL -- �̺�Ʈ����
-- ,CONSTRAINT PK_event -- �̺�Ʈ �⺻Ű
--	PRIMARY KEY (ev_id)
--);

## ---- ���⵿���Ŀ�
--CREATE TABLE funding (
--	fd_id NUMBER NOT NULL, -- �Ŀ��ڵ�
--	fd_title VARCHAR2 NOT NULL, -- �Ŀ�����
--	fd_orgname VARCHAR2 NOT NULL, -- ��ü�׽ü��̸�
--	region VARCHAR2 NOT NULL, -- ����
--	fd_name VARCHAR2 NOT NULL, -- ��ǥ��
--	fd_phone VARCHAR2 NOT NULL, -- ����ó
--	fd_goal NUMBER NOT NULL, -- �Ŀ���ݾ�
--	fd_start DATE NOT NULL, -- ������
--	fd_end DATE NOT NULL, -- ������
--	fd_imgfilename VARCHAR2 NOT NULL, -- ��ǥ�̹���
--	fd_contents CLOB NOT NULL -- �Ŀ�����
--);

## ---- ���⵿���Ŀ�
--ALTER TABLE funding
--	ADD
--	CONSTRAINT PK_funding -- ���⵿���Ŀ� �⺻Ű
--	PRIMARY KEY (
--	fd_id -- �Ŀ��ڵ�
--	);

## ---- ���⵿���Ŀ��̹���
--CREATE TABLE funding_img (
--	fdimg_id NUMBER NOT NULL, -- �Ŀ��̹����ڵ�
--	fk_fd_id NUMBER NOT NULL, -- �Ŀ��ڵ�
--	fdimg_name VARCHAR2 NOT NULL -- �̹������ϸ�
--);

## ---- ���⵿���Ŀ��̹���
--ALTER TABLE funding_img
--	ADD
--	CONSTRAINT PK_funding_img -- ���⵿���Ŀ��̹��� �⺻Ű
--	PRIMARY KEY (
--	fdimg_id -- �Ŀ��̹����ڵ�
--	);

## ---- �ݵ�����
--CREATE TABLE funding_payment (
--	payment_UID NUMBER NOT NULL, -- �����ڵ�
--	fk_fd_id NUMBER NOT NULL, -- �Ŀ��ڵ�
--	payment_total NUMBER NOT NULL, -- �����Ѿ�
--	payment_point NUMBER NOT NULL, -- ��������Ʈ
--	payment_pay NUMBER NOT NULL, -- �ǰ����ݾ�
--	payment_date DATE NOT NULL, -- ��������
--	payment_status NUMBER NOT NULL -- ��������
--);

## ---- �ݵ�����
--ALTER TABLE funding_payment
--	ADD
--	CONSTRAINT PK_funding_payment -- �ݵ����� �⺻Ű
--	PRIMARY KEY (
--	payment_UID -- �����ڵ�
--	);

## ---- �ݵ�ȯ��
--CREATE TABLE funding_refund (
--	refund_UID VARCHAR2 NOT NULL, -- ȯ���ڵ�
--	fk_payment_UID NUMBER NOT NULL, -- �����ڵ�
--	fk_idx NUMBER NOT NULL, -- ȯ�ҹ���ȸ����ȣ
--	refund_DATE DATE NOT NULL, -- ȯ�ҽ�û����
--	add_DATE DATE NOT NULL, -- �������
--	refund_reason VARCHAR2 NOT NULL, -- ȯ�һ���
--	refund_money NUMBER NOT NULL, -- ȯ�ұݾ�
--	refund_status NUMBER NOT NULL -- ���ο���
--);

## ---- �ݵ�ȯ��
--ALTER TABLE funding_refund
--	ADD
--	CONSTRAINT PK_funding_refund -- �ݵ�ȯ�� �⺻Ű
--	PRIMARY KEY (
--	refund_UID -- ȯ���ڵ�
--	);

-- #�������� �߰�

-- �Ƿ���
ALTER TABLE doctors
ADD
CONSTRAINT FK_biz_info_TO_doctors -- ���ȸ���� -> �Ƿ���
FOREIGN KEY (
fk_idx_biz -- ����/�౹������ȣ
)
REFERENCES biz_info ( -- ���ȸ����
idx_biz -- ����/�౹������ȣ
);

-- ����
ALTER TABLE review
ADD
CONSTRAINT FK_biz_info_TO_review -- ���ȸ���� -> ����
FOREIGN KEY (
fk_idx_biz -- ����/�౹������ȣ
)
REFERENCES biz_info ( -- ���ȸ����
idx_biz -- ����/�౹������ȣ
);

-- ����
ALTER TABLE review
ADD
CONSTRAINT FK_member_TO_review -- ȸ�� -> ����
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ����
ALTER TABLE review
ADD
CONSTRAINT FK_reservation_TO_review -- ���� -> ����
FOREIGN KEY (
fk_reservation_UID -- �����ڵ�
)
REFERENCES reservation ( -- ����
reservation_UID -- �����ڵ�
);

-- ����
ALTER TABLE reservation
ADD
CONSTRAINT FK_pet_info_TO_reservation -- �ݷ��������� -> ����
FOREIGN KEY (
fk_pet_UID -- �ݷ������ڵ�
)
REFERENCES pet_info ( -- �ݷ���������
pet_UID -- �ݷ������ڵ�
);

-- �ݷ���������
ALTER TABLE pet_info
ADD
CONSTRAINT FK_member_TO_pet_info -- ȸ�� -> �ݷ���������
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ��������
ALTER TABLE shots
ADD
CONSTRAINT FK_vaccine_TO_shots -- ��� -> ��������
FOREIGN KEY (
fk_vaccine_UID -- ����ڵ�
)
REFERENCES vaccine ( -- ���
vaccine_UID -- ����ڵ�
);

-- ��������
ALTER TABLE shots
ADD
CONSTRAINT FK_pet_info_TO_shots -- �ݷ��������� -> ��������
FOREIGN KEY (
fk_pet_UID -- �ݷ������ڵ�
)
REFERENCES pet_info ( -- �ݷ���������
pet_UID -- �ݷ������ڵ�
);

-- �ݷ��������
ALTER TABLE pet_list
ADD
CONSTRAINT FK_member_TO_pet_list -- ȸ�� -> �ݷ��������
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- �ݷ��������
ALTER TABLE pet_list
ADD
CONSTRAINT FK_pet_info_TO_pet_list -- �ݷ��������� -> �ݷ��������
FOREIGN KEY (
fk_pet_UID -- �ݷ������ڵ�
)
REFERENCES pet_info ( -- �ݷ���������
pet_UID -- �ݷ������ڵ�
);

-- �ݷ������ɾ�
ALTER TABLE petcare
ADD
CONSTRAINT FK_pet_info_TO_petcare -- �ݷ��������� -> �ݷ������ɾ�
FOREIGN KEY (
fk_pet_UID -- �ݷ������ڵ�
)
REFERENCES pet_info ( -- �ݷ���������
pet_UID -- �ݷ������ڵ�
);

-- �ݷ������ɾ�
ALTER TABLE petcare
ADD
CONSTRAINT FK_caretype_TO_petcare -- �ɾ�Ÿ�� -> �ݷ������ɾ�
FOREIGN KEY (
fk_caretype_UID -- �ɾ�Ÿ���ڵ�
)
REFERENCES caretype ( -- �ɾ�Ÿ��
caretype_UID -- �ɾ�Ÿ���ڵ�
);

-- ������
ALTER TABLE chart
ADD
CONSTRAINT FK_pet_info_TO_chart -- �ݷ��������� -> ������
FOREIGN KEY (
fk_pet_UID -- �ݷ������ڵ�
)
REFERENCES pet_info ( -- �ݷ���������
pet_UID -- �ݷ������ڵ�
);

-- ������
ALTER TABLE chart
ADD
CONSTRAINT FK_member_TO_chart -- ȸ�� -> ������
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ��ġ�ݰ���
ALTER TABLE payment
ADD
CONSTRAINT FK_reservation_TO_payment -- ���� -> ��ġ�ݰ���
FOREIGN KEY (
fk_reservation_UID -- �����ڵ�
)
REFERENCES reservation ( -- ����
reservation_UID -- �����ڵ�
);

-- ��ġ��
ALTER TABLE deposit
ADD
CONSTRAINT FK_member_TO_deposit -- ȸ�� -> ��ġ��
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ȯ��
ALTER TABLE refund
ADD
CONSTRAINT FK_payment_TO_refund -- ��ġ�ݰ��� -> ȯ��
FOREIGN KEY (
fk_payment_UID -- �����ڵ�
)
REFERENCES payment ( -- ��ġ�ݰ���
payment_UID -- �����ڵ�
);

-- 1:1���
ALTER TABLE consult
ADD
CONSTRAINT FK_member_TO_consult -- ȸ�� -> 1:1���
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- �˸�
ALTER TABLE notification
ADD
CONSTRAINT FK_member_TO_notification -- ȸ�� -> �˸�
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ��ġ�����
ALTER TABLE withdraw
ADD
CONSTRAINT FK_deposit_TO_withdraw -- ��ġ�� -> ��ġ�����
FOREIGN KEY (
fk_deposit_UID -- ��ġ���ڵ�
)
REFERENCES deposit ( -- ��ġ��
deposit_UID -- ��ġ���ڵ�
);

-- ��ġ�� ��볻��
ALTER TABLE dep_use
ADD
CONSTRAINT FK_deposit_TO_dep_use -- ��ġ�� -> ��ġ�� ��볻��
FOREIGN KEY (
fk_deposit_UID -- ��ġ���ڵ�
)
REFERENCES deposit ( -- ��ġ��
deposit_UID -- ��ġ���ڵ�
);

-- ��ġ�� ��볻��
ALTER TABLE dep_use
ADD
CONSTRAINT FK_payment_TO_dep_use -- ��ġ�ݰ��� -> ��ġ�� ��볻��
FOREIGN KEY (
fk_payment_UID -- �����ڵ�
)
REFERENCES payment ( -- ��ġ�ݰ���
payment_UID -- �����ڵ�
);

-- ��ġ�� ��볻��
ALTER TABLE dep_use
ADD
CONSTRAINT FK_reservation_TO_dep_use -- ���� -> ��ġ�� ��볻��
FOREIGN KEY (
fk_reservation_UID -- �����ڵ�
)
REFERENCES reservation ( -- ����
reservation_UID -- �����ڵ�
);

-- ó����
ALTER TABLE prescription
ADD
CONSTRAINT FK_chart_TO_prescription -- ������ -> ó����
FOREIGN KEY (
chart_UID -- ��Ʈ�ڵ�
)
REFERENCES chart ( -- ������
chart_UID -- ��Ʈ�ڵ�
);

-- ȭ�� ���(video advice)
ALTER TABLE video_advice
ADD
CONSTRAINT FK_member_TO_video_advice -- ȸ�� -> ȭ�� ���(video advice)
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ȭ�� ���(video advice)
ALTER TABLE video_advice
ADD
CONSTRAINT FK_biz_info_TO_video_advice -- ���ȸ���� -> ȭ�� ���(video advice)
FOREIGN KEY (
fk_idx_biz -- ����/�౹������ȣ
)
REFERENCES biz_info ( -- ���ȸ����
idx_biz -- ����/�౹������ȣ
);

-- ������(reviewComment)
ALTER TABLE review_comment
ADD
CONSTRAINT FK_review_TO_review_comment -- ���� -> ������(reviewComment)
FOREIGN KEY (
fk_review_UID -- �����ڵ�
)
REFERENCES review ( -- ����
review_UID -- �����ڵ�
);

-- ������(reviewComment)
ALTER TABLE review_comment
ADD
CONSTRAINT FK_member_TO_review_comment -- ȸ�� -> ������(reviewComment)
FOREIGN KEY (
fk_idx -- ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- 1:1��� ���
ALTER TABLE consult_comment
ADD
CONSTRAINT FK_consult_TO_consult_comment -- 1:1��� -> 1:1��� ���
FOREIGN KEY (
fk_consult_UID -- ����ڵ�
)
REFERENCES consult ( -- 1:1���
consult_UID -- ����ڵ�
);

-- 1:1��� ���
ALTER TABLE consult_comment
ADD
CONSTRAINT FK_member_TO_consult_comment -- ȸ�� -> 1:1��� ���
FOREIGN KEY (
fk_idx -- ���ȸ��������ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ���ɾ� �̹���
ALTER TABLE petcare_img
ADD
CONSTRAINT FK_petcare_TO_petcare_img -- �ݷ������ɾ� -> ���ɾ� �̹���
FOREIGN KEY (
fk_care_UID -- �ɾ��ڵ�
)
REFERENCES petcare ( -- �ݷ������ɾ�
care_UID -- �ɾ��ڵ�
);

-- #������� ���� �������� �߰�
-- �Խñ�
ALTER TABLE board_post
ADD
CONSTRAINT FK_board_group_TO_board_post -- �Խ��Ǳ׷� -> �Խñ�
FOREIGN KEY (
fk_brd_id -- �Խ��Ǳ׷��ڵ�
)
REFERENCES board_group ( -- �Խ��Ǳ׷�
brd_id -- �Խ��Ǳ׷��ڵ�
);

-- �Խñ�
ALTER TABLE board_post
ADD
CONSTRAINT FK_member_TO_board_post -- ȸ�� -> �Խñ�
FOREIGN KEY (
fk_idx -- �ۼ��ڰ�����ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ���
ALTER TABLE board_comment
ADD
CONSTRAINT FK_board_group_TO_comment -- �Խ��Ǳ׷� -> ���
FOREIGN KEY (
fk_brd_id -- �Խ��Ǳ׷��ڵ�
)
REFERENCES board_group ( -- �Խ��Ǳ׷�
brd_id -- �Խ��Ǳ׷��ڵ�
);

-- ���
ALTER TABLE board_comment
ADD
CONSTRAINT FK_board_post_TO_comment -- �Խñ� -> ���
FOREIGN KEY (
fk_post_id -- �Խñ۰�����ȣ
)
REFERENCES board_post ( -- �Խñ�
post_id -- �Խñ۰�����ȣ
);

-- ���
ALTER TABLE board_comment
ADD
CONSTRAINT FK_member_TO_comment -- ȸ�� -> ���
FOREIGN KEY (
fk_idx -- ����ۼ��ڰ�����ȣ
)
REFERENCES member ( -- ȸ��
idx -- ȸ��������ȣ
);

-- ���⵿���Ŀ��̹���
--ALTER TABLE funding_img
--	ADD
--	CONSTRAINT FK_funding_TO_funding_img -- ���⵿���Ŀ� -> ���⵿���Ŀ��̹���
--	FOREIGN KEY (
--	fk_fd_id -- �Ŀ��ڵ�
--	)
--	REFERENCES funding ( -- ���⵿���Ŀ�
--	fd_id -- �Ŀ��ڵ�
--	);

-- �ݵ�����
--ALTER TABLE funding_payment
--	ADD
--	CONSTRAINT FK_funding_TO_funding_payment -- ���⵿���Ŀ� -> �ݵ�����
--	FOREIGN KEY (
--	fk_fd_id -- �Ŀ��ڵ�
--	)
--	REFERENCES funding ( -- ���⵿���Ŀ�
--	fd_id -- �Ŀ��ڵ�
--	);

-- �ݵ�ȯ��
--ALTER TABLE funding_refund
--	ADD
--	CONSTRAINT FK_funding_payment_TO_funding_refund -- �ݵ����� -> �ݵ�ȯ��
--	FOREIGN KEY (
--	fk_payment_UID -- �����ڵ�
--	)
--	REFERENCES funding_payment ( -- �ݵ�����
--	payment_UID -- �����ڵ�
--	);





insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','1','���ͱ�','605-17-38838', '47258', '�λ걤���� �λ����� ������ 87 (������)', '1�� ���鵿������',''
,'','seomyun_medical.jpg','��~��',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 18:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 14:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),'��',1,1,0,'������������','�ȳ��ϼ���. 
���鵿�������Դϴ�. Tel. 051-809-8092  ��ġ : ���鿪 7�� �ⱸ ����2�� �ֹμ��� �α� ������������������ (��10000���� �̻��� �ٳⰣ�� ��������)')


insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','2','�����','106-23-35564', '06239', '����� ������ ���ﵿ 828-7���� �ѵ����� 1��', '���ε�������',''
,'','hyemin_medical.jpg','��~��',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 18:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 14:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),'��',1,1,1,'��ġ��ġ������ �ѹ��Ƿ��','��ġ��ġ������ ���ε������� with �ѱ������ѹ��Ƿ�� �Դϴ�.')

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','3','�ֱ���','825-18-00234', '14549', '��⵵ ��õ�� ����� 190 �����������Ʈ', '1������ 2�� 214-216ȣ',''
,'','headeun_medical.jpg','365�� 24�ð� ����',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 21:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 12:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 21:00:00','yyyy-mm-dd hh24:mm:ss'),'�Ƚ�',1,1,1,'��ɰ�����','���� 24�� �ص絿�������� �׻� ģ���ϰ� ������ ������ ��ġ�� �ݷ��������� �����̰� ��ȣ�ںе���� �Ÿ��� ���� ������ �Ǳ� ���� ����ϰڽ��ϴ�. 24�ð� ��� �⺻���� 365�� �Ϸ絵 ������ �ʰ� �ּ��� ���ؼ� ��������� �ݷ�������� �׸��� �����е�� �Բ��ϰڽ��ϴ�. �����մϴ�.')


insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','4','������, ����ȣ','133-24-07642', '05612', '����Ư���� ���ı� ���л�� 88 1��', '24�� ����Ʈ �����޵��ü���',''
,'','best_medical.jpg','365�� 24�ð� ����',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 12:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),'�Ƚ�',1,1,0,'�����Ưȭ����','������ ���ϴ� �ݷ������� �󸶳�, ���, �� ������,��� �ؾ� ������� �ູ�ϰ� �� �� �ִ���.... �װ͵��� ��ȣ�ںе鲲 ��Ȯ�� �˷��帮�� �ݷ������� ���� �ּ��� ���� ã���ִ� ���� ���� ������ ����̶�� �����մϴ�.�� �������� ��� �� ���� �⻵���ְ�, ���� �� ���� �����ϸ�,������ ���� �������� �ּ��� ���� �����ڽ��ϴ�.�� ���� ��°� ��÷�� �Ƿ�ý����� �������� ���� ����24�� ��� ����Ʈ �����޵��� ���͸� �����ϰڽ��ϴ�.������ ���� ������ ������ֽô� ��ȣ�ںе鲲 ���� �λ�帮�� �����ε� ������ �Բ��ϰڽ��ϴ�.')

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg, weekday, wdstart, wdend, lunchstart, lunchend, satstart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values('','5','�����,�̵���','489-01-00840', '10387', '��⵵ ���� �ϻ꼭�� �߾ӷ� 1455', ' 116ȣ(�ֿ���, ����Ƽ������)',''
,'','ilsanwoori_medical.jpg','365�� 24�ð� ����',to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 12:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 13:00:00','yyyy-mm-dd hh24:mm:ss'),
to_date('2019-01-07 09:00:00','yyyy-mm-dd hh24:mm:ss'),to_date('2019-01-07 22:00:00','yyyy-mm-dd hh24:mm:ss'),'�Ƚ�',1,1,0,'������Ż������','���� �߿��� ���� ������ �ŷڶ�� �����մϴ�. �������� �ݷ������� �Ƴ��� ����ϴ� ��ȣ�� �е��� ������ �������� �� �˱⿡ ������ �ݷ��������� �ǰ�, ������ �ŷ� �׸��� �Ƿ����� �����帮�ڽ��ϴ�. �����е��� ������ ���� ������ �����ִ� 24�� �ϻ�츮 �����ǷἾ�Ͱ� �ǰڽ��ϴ�^^')


insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'dongnimmun', 'qwer1234$', 'ȫ�浿', '��������������', '19700812', 1, '01075369514', 'dongnimmun.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(3, 1, '�̰���', '123-45-88890', '03735', '���� ���빮�� ���Ϸ� 171-1', '��õ�� 195', '37.569342', '126.963168'
    , 'dongnimmunHos.png', '��,ȭ,��,��,��', '09:00', '18:00', '12:00', '13:00', '09:00', '15:00', '����', 1, 1, 1
    , 0, '5ȣ�� ���빮���� ��������Ÿ� �߰��� ���� ��ȭ�ʵ��б� ���� ���� ��ġ�մϴ�.', '�������<br>- ����, �ܰ�, �����ܰ�, �Ǻΰ� �� ����� ���� ġ�ưǰ��� ���� ġ�� ���� ���񽺸� �����մϴ�. <br>- ������ ġ�Ẹ�ٴ� �����ϴ� ���� �߿��ϱ� ������ �������а� �. ���� �����ֻ� ���α׷� �� ������ ������ �����˻�, �������� �˻� �� ���� ���α׷�, ġ�� ��ȯ ���� ���α׷� ��մϴ�.<br>- ���� ġ�Ḧ ���ؼ��� ��Ȯ�� ������ �߿��ϱ⿡ ��Ȯ�� ������ ���� ���̰� ���׺м���, ������ �˻� �� ���� ��� �����Ͽ� �ӻ󺴸����� ��ϰ� ����ġ�ᰡ �ʿ��� ȯ�ڸ� ���� .�Կ����� ��մϴ�. <br>- ������ �Ӹ� �ƴ϶� �����, �䳢, �ܽ���,����� ���� ���������ϰ� �ֽ��ϴ�.<br>- �ְ߹̿���� ��ϰ� �ֽ��ϴ�.'
    ); -- note�� ã�ƿ��±�� �ٲٱ�

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(3, 3, '����ģȭ��');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(3, 3, 'ģ����');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(3, 12, '������');

-- 4
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'baekseul', 'qwer1234$', '�ּ���', '�齽��������', '19790625', 1, '01095183654', 'baekseul.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(4, 1, '�ּ���', '123-45-67890', '04501', '����Ư���� �߱� ������� 177', '���￪�Ѷ��ߵ�Ʈ�� 105ȣ', '37.554747', '126.965442'
    , 'baekseulHos.png', 'ȭ,��,��,��', '10:00', '20:00', '12:00', '13:00', '10:00', '15:00', '����', 1, 0, 0
    , 0, '���� : �ձ���ü�������Ա� ����������, �ձ���ü������ ����������<br>��ö : ������ 1�� �ⱸ�� �����ż� �Ե���Ʈ&�ƿ﷿�� �հ� �ǳʿ��ø� ���� ���� �� �ֽ��ϴ�.', '���￪ �齽���������� ������ ������Ż�� �������� ���������Դϴ�.<br>�۳� 2017�⵵ ������Ż�� ���� 1,000���� ������ �Ƿ��ִ� ���������Դϴ�.<br>������ ������� ����Ǹ�, ��߾��� ������ ���� �ּ���������� 3��Ģ���� ġ�Ḧ �����մϴ�.<br>���� ������Ż�� ������� �̺�Ʈ�� �����ϰ� ������ ���� ���� ��Ź�帳�ϴ�. �����մϴ�.'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 7, '�������ͳ�');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 8, '����');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 10, '������');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(4, 15, '����������');

-- 5
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'gwanghwamun', 'qwer1234$', '�̱���', '��ȭ����������', '19860905', 2, '01037651258', 'gwanghwamun.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(5, 1, '���翵', '367-05-00209', '03027', '����Ư���� ���α� ������9�� 6-1', '������ �ֹμ��� ��', '37.576761', '126.968757'
    , 'gwanghwamunHos.png', '��,ȭ,��,��,��', '09:00', '20:30', '12:00', '13:00', '10:00', '15:00', '����', 1, 1, 0
    , 0, '3ȣ�� �溹�ÿ� �������ֹμ��� ��', '������ ġ���� ����ü'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 7, '�������ͳ�');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 8, '����');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 17, '�߼�ȭ��������');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(5, 34, '�̿�');

-- 6
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'gwanghwamun', 'qwer1234$', '��Ǫ��', 'Ǫ���´����౹', '19950930', 2, '01034683514', 'blueOnNuri.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(5, 2, '�´���', '623-07-51312', '03181', '����Ư���� ���α� �����ȷ� 19', '����������ȸ��', '37.567609', '126.967876'
    , 'blueOnNuriHos.png', '��,ȭ,��,��,��', '08:30', '19:30', '12:00', '13:00', '08:30', '14:00', '����', 1, 1, 0
    , 0, '���빮��(5ȣ��) 4�� �ⱸ ���� 2��<br>�����ο�(2ȣ��,5ȣ��) 9�� �ⱸ ���� 14��<br>��ȭ����(5ȣ��) 1�� �ⱸ ���� 15��<br>��û��(1ȣ��,2ȣ��) 10�� �ⱸ ���� 16��', '���ǿ� ó������ �� �����Ǿ�ǰ ���'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(6, 1, '������');

-- 7
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype)
values(seq_member.nextval, 'gyeonghuigung', 'qwer1234$', '�����', '������޻�౹', '19901216', 2, '01015379583', 'gyeonghuigung.png', 2);

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude
    , prontim, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani
    , etc, note, intro)
values(7, 2, '�����', '957-02-51384', '03165', '����Ư���� ���α� �ۿ��� 99', '��������� �� 203�� 2�� ������޻�౹', '37.570986', '126.964416'
    , 'gyeonghuigungHos.png', '��, ȭ,��,��,��', '09:00', '19:00', '12:00', '13:00', '09:00', '19:00', '09:00~14:00', 1, 0, 0
    , 0, '���빮��(5ȣ��) 4�� �ⱸ ���� 10��<br>��������(3ȣ��) 3�� �ⱸ ���� 10��', '���ǿ� ó������ �Ϲ��Ǿ�ǰ �ǰ���ɽ�ǰ ���빮�� �����౹ ���α� �����౹ ��õ���� �ǳ��� ��������� �� 2�� �౹ ưư�Ҿư� �� ������޻�౹�Դϴ�.'
    );

insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(7, 7, '�������ͳ�');
insert into have_tag(fk_tag_UID, fk_idx, fk_tag_name)
values(7, 8, '����');


-- ���ȸ�� insert 5��
insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'youjs', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '���缮', '�޶ѱ�', '19981212', 1, 'spTAeO5ydUaLRUSt9gs4NQ==', 'youjs.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'haha', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '����', '������', '19880213', 1, 'spTAeO5ydUaLRUSt9gs4NQ==', 'haha.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'parkms', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '�ڸ��', '������', '20010312', 2, 'spTAeO5ydUaLRUSt9gs4NQ==', 'parkms.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'yangsh', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '�缼��', '�缼�ٸ�', '19930618', 2, 'spTAeO5ydUaLRUSt9gs4NQ==', 'yangsh.jpg', 2, default, default, default, default);

insert into member(idx, userid, pwd, name, nickname, birthday, gender, phone, profileimg, membertype, fk_level_UID, point, totaldeposit, noshow, registerdate)
values (seq_member.nextval, 'jungjh', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '������', '�Ľ�', '20020331', 2, 'spTAeO5ydUaLRUSt9gs4NQ==', 'jungjh.jpg', 2, default, default, default, default);


-- ���ȸ�� �� insert 5��
insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 1, '���缮', '3828839198', '23123', '����Ư���� ���빮�� ����1��', '����õ�纴��', '37.576869', '127.047577', 'dail.jpg'
, '��,ȭ,��,��,��', '2019-01-17 08:00:00', '2019-01-17 18:00:00', '2019-01-17 12:00:00', '2019-01-17 13:00:00', '2019-01-17 09:00:00', '2019-01-17 15:00:00', '��', 1, 0, 0, 0, '������', '������� ����õ�纴���Դϴ�. ���������������̿���.');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 1, '����', '2948162923', '04057', '����Ư���� ���빮�� ȫ��2��', '�Ѽֵ�������', '37.586140', '126.948811', 'hansol.jpg'
, '��,ȭ,��,��,��', '2019-01-17 09:00:00', '2019-01-17 21:00:00', '2019-01-17 12:00:00', '2019-01-17 13:00:00', '2019-01-17 09:00:00', '2019-01-17 15:00:00', '��', 1, 0, 0, 0, '�������', '�ȳ��ϼ��� �Ѽֵ��������Դϴ�.');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 1, '�ڸ��', '2917293817', '02720', '����Ư���� ���� ���ϵ�', '24�ý���Ʈ�����޵��ü���', '37.600714', '126.918242', 'medical.jpg'
, '��,ȭ,��,��,��', '2019-01-17 09:00:00', '2019-01-17 20:00:00', '2019-01-17 13:00:00', '2019-01-17 14:00:00', '2019-01-17 09:00:00', '2019-01-17 14:00:00', '������', 1, 0, 0, 0, '24�ð�', '�ȳ��ϼ��� 24�ð� ������ ����Ʈ�����޵��� �����Դϴ�. �δ���� ������~');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 2, '�缼��', '9583738495', '23123', '����Ư���� ������ ��ȣ1����', '��ȣ�����౹', '37.559677', '127.024500', 'geumho.jpg'
, '��,ȭ,��,��,��', '2019-01-17 08:00:00', '2019-01-17 20:00:00', '2019-01-17 12:00:00', '2019-01-17 13:00:00', '2019-01-17 08:00:00', '2019-01-17 15:00:00', '������', 1, 0, 0, 0, '24�ð�', 'ó�� Ȯ���ϰ� �ص帮�ڽ��ϴ�!!');

insert into biz_info(idx_biz, biztype, repname, biznumber, postcode, addr1, addr2, latitude, longitude, prontimg
, weekday, wdstart, wdend, lunchstart, lunchend, satstrart, satend, dayoff, dog, cat, smallani, etc, note, intro)
values ( , 2, '������', '4827394837', '01025', '����Ư���� �߱� ȸ����3��', '�ѱ�ȭ���ڵ�����ǰ', '37.565859', '126.984498', 'korea.jpg'
, '��,ȭ,��,��,��', '2019-01-17 10:00:00', '2019-01-17 18:00:00', '2019-01-17 13:00:00', '2019-01-17 14:00:00', '2019-01-17 09:00:00', '2019-01-17 15:00:00', '������', 1, 0, 0, 0, '24�ð�', '�ȳ��ϼ��� �ѱ�ȭ���ڵ�����ǰ�Դϴ�.��);


