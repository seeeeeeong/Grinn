--알림
create table alert(
 al_num number,
 mem_num number,
 al_type varchar2(50) not null,
 al_content varchar2(200) not null,
 al_date date default sysdate not null,
 al_read date not null,
 related_num number not null
 constraint alert_pk primary key (al_num)
 constraint alert_fk1 foreign key (mem_num) references member (mem_num)
);
create sequence alert_seq;

--팔로우
create table follow (
    mem_num number not null, -- 팔로우번호, 회원을 식별하는 번호, PK, FK
    to_user number(12), -- 팔로잉(팔로우를 하는 쪽), FK
    from_user number(12), -- 팔로워(팔로우를 받는 쪽), FK
   	constraint follow_pk primary (mem_num),
    constraint follow_fk1 foreign key (to_user) references member (mem_num),
    constraint follow_fk2 foreign key (from_user) references member (mem_num)
);