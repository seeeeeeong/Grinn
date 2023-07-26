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
	mem_num number,
	st_num number,
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
	mem_num number,
	st_num number,
	constraint style_comment_pk primary key (com_num),
	constraint style_comment_fk1 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint style_comment_fk2 foreign key (st_num) references style (st_num) ON DELETE CASCADE
);

CREATE sequence style_comment_seq;

--스타일 해시태그 연결
CREATE TABLE style_tag_map(
	map_num number,
	tag_num number,
	st_num number,
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