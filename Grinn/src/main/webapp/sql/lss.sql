--팔로우
create table follow (
    follow_id number not null, -- 팔로우번호 PK
    to_user number(12), -- 팔로잉(팔로우를 하는 쪽), FK
    from_user number(12), -- 팔로워(팔로우를 받는 쪽), FK
   	constraint follow_pk primary key (follow_id),
    constraint follow_fk1 foreign key (to_user) references member (mem_num) ON DELETE CASCADE,
    constraint follow_fk2 foreign key (from_user) references member (mem_num) ON DELETE CASCADE
);
create sequence follow_seq;