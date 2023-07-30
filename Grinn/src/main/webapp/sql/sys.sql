create table member(
	mem_num number,
	mem_id varchar2(12) unique not null,
	mem_nickname varchar2(30),
	mem_auth number(1) default 2 not null,
	constraint member_pk primary key (mem_num)
);
create sequence member_seq;

create table member_detail(
	mem_num number,
	au_id varchar2(36) unique,
	mem_name varchar2(30) not null,
	mem_passwd varchar2(15) not null,
	mem_phone varchar2(15) not null,
	mem_email  varchar2(50) not null,
	mem_zipcode varchar2(5) not null,
	mem_address1 varchar2(200) not null,
	mem_address2 varchar2(200) not null,
	mem_photo varchar2(500) not null,
	mem_int varchar2(100),
	mem_date date default sysdate not null,
	mem_mdate date,
	mem_point number(20),
	constraint member_detail_pk primary key (mem_num),
	constraint member_detail_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);

create table vote(
	vote_num number,
	board_num number not null,
	mem_num number not null,
	item_num number not null,
	vote_date date default sysdate not null,
	constraint vote_pk primary key (vote_num),
	constraint vote_fk2 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint vote_fk3 foreign key (item_num) references item (item_num) ON DELETE CASCADE
);
create sequence vote_seq;

create table vote_board(
	board_num number,
	board_title varchar2(50) not null,
	board_content varchar2(300),
	item_num1 number not null,
	item_num2 number not null,
	item_num3 number not null,
	item_num4 number not null,
	item_photo1 blob not null,
	item_photo2 blob not null,
	item_photo3 blob,
	item_photo4 blob,
	board_date date default sysdate not null,
	vote_num number not null,
	mem_num number not null,
	constraint vote_board_pk primary key (board_num),
	constraint vote_board_fk1 foreign key (vote_num) references vote (vote_num) ON DELETE CASCADE,
	constraint vote_board_fk2 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);
create sequence vote_board_seq;

create table vote_reply(
	re_num number,
	re_content varchar2(100) not null,
	re_date date default sysdate not null,
	re_mdate date,
	mem_num number not null,
	board_num number not null,
	constraint vote_reply_pk primary key (re_num),
	constraint vote_reply_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint vote_reply_fk2 foreign key (board_num) references vote_board (board_num) ON DELETE CASCADE
);
create sequence vote_reply_seq;









