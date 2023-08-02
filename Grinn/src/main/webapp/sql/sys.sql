
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
	mem_photo varchar2(500) not null, -- 회원 프로필 사진
	mem_int varchar2(100), -- 회원 한 줄 소개
	mem_date date default sysdate not null, -- 등록일
	mem_mdate date, -- 수정일
	mem_point number(20), -- 회원 포인트
	constraint member_detail_pk primary key (mem_num),
	constraint member_detail_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);

create table vote(
	vote_num number, -- 투표 번호
	board_num number not null, -- 게시물 번호
	mem_num number not null, -- 회원 번호
	item_num number not null, -- 상품 번호
	vote_date date default sysdate not null, -- 투표일
	constraint vote_pk primary key (vote_num),
	constraint vote_fk2 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint vote_fk3 foreign key (item_num) references item (item_num) ON DELETE CASCADE
);
create sequence vote_seq;

create table vote_board(
	board_num number, -- 게시물 번호
	board_title varchar2(50) not null, -- 게시물 제목
	board_content varchar2(300), -- 게시물 내용
	item_num1 number not null, -- 상품번호1
	item_num2 number not null, -- 상품번호2
	item_num3 number not null, -- 상품번호3
	item_num4 number not null, -- 상품번호4
	item_photo1 blob not null, -- 상품사진1
	item_photo2 blob not null, -- 상품사진2
	item_photo3 blob, -- 상품사진3
	item_photo4 blob, -- 상품사진4
	board_date date default sysdate not null, -- 게시물 등록일
	vote_num number not null, -- 투표 번호
	mem_num number not null, -- 회원 번호
	constraint vote_board_pk primary key (board_num),
	constraint vote_board_fk1 foreign key (vote_num) references vote (vote_num) ON DELETE CASCADE,
	constraint vote_board_fk2 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);
create sequence vote_board_seq;

create table vote_reply(
	re_num number, -- 투표 댓글 번호
	re_content varchar2(100) not null, -- 투표 댓글 내용
	re_date date default sysdate not null, -- 투표 댓글 등록일
	re_mdate date, -- 투표 댓글 수정일
	mem_num number not null, -- 회원 번호
	board_num number not null, -- 게시물 번호
	constraint vote_reply_pk primary key (re_num),
	constraint vote_reply_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint vote_reply_fk2 foreign key (board_num) references vote_board (board_num) ON DELETE CASCADE
);
create sequence vote_reply_seq;









