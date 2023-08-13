create table member(
	mem_num number, -- 회원번호
	mem_id varchar2(12) unique not null, -- 회원 아이디
	mem_nickname varchar2(30), -- 회원 닉네임
	mem_auth number(1) default 2 not null, -- 회원 등급
	constraint member_pk primary key (mem_num)
);
create sequence member_seq;

create table member_detail(
	mem_num number, -- 회원번호
	au_id varchar2(36) unique, -- 자동 로그인 식별값
	mem_name varchar2(30) not null, -- 회원 이름
	mem_passwd varchar2(15) not null, -- 회원 비밀번호
	mem_phone varchar2(15) not null, -- 회원 전화번호
	mem_email  varchar2(50) not null, -- 회원 이메일
	mem_zipcode varchar2(5) not null, -- 회원 우편번호
	mem_address1 varchar2(200) not null, -- 회원 주소
	mem_address2 varchar2(200) not null, -- 회원 상세주소
	mem_photo blob, -- 회원 프로필 사진
	mem_photo_name varchar2(100), -- 회원 프로필 사진 파일명
	mem_int varchar2(100), -- 회원 한 줄 소개
	mem_date date default sysdate not null, -- 등록일
	mem_mdate date, -- 수정일
	mem_point number(20), -- 회원 포인트
	constraint member_detail_pk primary key (mem_num),
	constraint member_detail_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);

create table poll(
	poll_num number, -- 투표글 번호
	poll_title varchar2(50) not null, -- 투표글 제목
	poll_content varchar2(200) not null, -- 투표글 내용
	poll_item1 varchar2(500) not null, -- 투표 항목1
	poll_item2 varchar2(500) not null, -- 투표 항목2
	poll_item3 varchar2(500), -- 투표 항목3
	poll_item4 varchar2(500), -- 투표 항목4
	poll_total number not null, -- 총 득표수
	poll_date date default sysdate not null, -- 투표글 등록일
	mem_num number not null, -- 회원번호
	item_num number not null, -- 상품번호
	constraint poll_pk primary key (poll_num),
	constraint poll_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint poll_fk2 foreign key (item_num) references item (item_num) ON DELETE CASCADE
);
create sequence poll_seq;

create table pollsub(
	pollsub_num number, -- 투표번호
	poll_acount number not null, -- 투표수
	poll_num number not null, -- 투표글 번호
	item_num number not null, -- 상품번호
	constraint pollsub_pk primary key (pollsub_num),
	constraint pollsub_fk1 foreign key (poll_num) references poll (poll_num) ON DELETE CASCADE,
	constraint pollsub_fk2 foreign key (item_num) references item (item_num) ON DELETE CASCADE
);
create sequence pollsub_seq;

create table voter(
	voter_num number, -- 투표 정보번호
	poll_num number not null, -- 투표글 번호
	pollsub_num number not null, -- 투표번호
	mem_num number not null, -- 회원번호
	polling_date date default sysdate not null, -- 투표일
	constraint voter_pk primary key (voter_num),
	constraint voter_fk1 foreign key (poll_num) references poll (poll_num) ON DELETE CASCADE,
	constraint voter_fk2 foreign key (pollsub_num) references pollsub (pollsub_num) ON DELETE CASCADE,
	constraint voter_fk3 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);
create sequence voter_seq;

create table poll_reply(
	re_num number, -- 투표글 댓글 번호
	re_content varchar2(100) not null, -- 투표글 댓글 내용
	re_date date default sysdate not null, -- 투표 댓글 등록일
	mem_num number not null, -- 회원 번호
	poll_num number not null, -- 게시물 번호
	constraint poll_reply_pk primary key (re_num),
	constraint poll_reply_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint poll_reply_fk2 foreign key (poll_num) references poll (poll_num) ON DELETE CASCADE
);
create sequence poll_reply_seq;









