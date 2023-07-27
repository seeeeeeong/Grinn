--스타일(게시물)
CREATE TABLE style(
	st_num number,
	st_phrase varchar2(500),
	st_photo1 varchar2(200) not null,
	st_photo2 varchar2(200),
	st_photo3 varchar2(200),
	st_photo4 varchar2(200),
	st_regdate DATE DEFAULT SYSDATE not null,
	st_mdate DATE,
	mem_num number,
	item_num1 number,
	item_num2 number,
	item_num3 number,
	constraint style_pk primary key (st_num),
	constraint style_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
    constraint style_fk2 foreign key (item_num1) references item (item_num) ON DELETE CASCADE,
    constraint style_fk3 foreign key (item_num2) references item (item_num) ON DELETE CASCADE,
	constraint style_fk4 foreign key (item_num3) references item (item_num) ON DELETE CASCADE
);

CREATE sequence style_seq;

--스타일 좋아요
CREATE TABLE style_fav(
	stfav_num number,
	mem_num number not null,
	st_num number not null,
	constraint style_fav_pk primary key (stfav_num),
	constraint style_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
    constraint style_fk2 foreign key (st_num) references style (st_num) ON DELETE CASCADE
);

CREATE sequence style_fav_seq;

--스타일 댓글
CREATE TABLE style_comment(
	com_num number,
	comment varchar2(400) not null,
	com_regdate DATE DEFAULT SYSDATE not null,
	com_mdate DATE,
	mem_num number not null,
	st_num number not null,
	constraint style_comment_pk primary key (com_num),
	constraint style_comment_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint style_comment_fk2 foreign key (st_num) references style (st_num) ON DELETE CASCADE
);

CREATE sequence style_comment_seq;

--스타일 해시태그 연결
CREATE TABLE style_tag_map(
	map_num number,
	tag_num number not null,
	st_num number not null,
	constraint style_tag_map_pk primary key (map_num),
	constraint style_tag_map_fk1 foreign key (tag_num) references style_tag (tag_num) ON DELETE CASCADE,
	constraint style_tag_map_fk2 foreign key (st_num) references style (st_num) ON DELETE CASCADE
);

CREATE sequence style_tag_map_seq;

--해시태그
CREATE TABLE style_tag(
	tag_num number,
	tag_name varchar2(300) not null,
	tag_count number DEFAULT 1 not null,
	constraint style_tag_pk primary key (tag_num)
);

CREATE sequence style_tag_seq;

--게시물 신고
CREATE TABLE report_st(
	rst_num number,
	rep_type numer(1) not null,
	rep_com varchar2(800),
	rep_hide number(1) default 0 not null,
	rep_status number(1) default 0 not null,
	rep_regdate date default sysdate not null,
	st_num number not null,
	report_mem number not null,
	reported_mem number not null,
	constraint report_st_pk primary key (rst_num),
	constraint report_st_fk1 foreign key (st_num) references style (st_num) ON DELETE CASCADE,
	constraint report_st_fk2 foreign key (report_mem) references member (mem_num) ON DELETE CASCADE,
	constraint report_st_fk3 foreign key (reported_mem) references member (mem_num) ON DELETE CASCADE
	
);

CREATE sequence report_st_seq;

--댓글 신고
CREATE TABLE report_com(
	rcom_num number,
	rep_type numer(1) not null,
	rep_com varchar2(800),
	rep_hide number(1) default 0 not null,
	rep_status number(1) default 0 not null,
	rep_regdate date default sysdate not null,
	com_num number not null,
	report_mem number not null,
	reported_mem number not null,
	constraint report_com_pk primary key (rcom_num),
	constraint report_com_fk1 foreign key (com_num) references style_comment (com_num) ON DELETE CASCADE,
	constraint report_com_fk2 foreign key (report_mem) references member (mem_num) ON DELETE CASCADE,
	constraint report_com_fk3 foreign key (reported_mem) references member (mem_num) ON DELETE CASCADE
);

CREATE sequence report_com_seq;