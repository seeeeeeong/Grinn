--알림
CREATE TABLE alert (
    al_num NUMBER,
    mem_num NUMBER,
    al_type VARCHAR2(50) NOT NULL,
    al_content VARCHAR2(200) NOT NULL,
    al_date DATE DEFAULT SYSDATE NOT NULL,
    al_read DATE NOT NULL,
    related_num NUMBER NOT NULL,
    CONSTRAINT alert_pk PRIMARY KEY (al_num), 
    CONSTRAINT alert_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num) ON DELETE CASCADE
);
create sequence alert_seq;

--팔로우
create table follow (
    mem_num number not null, -- 팔로우번호, 회원을 식별하는 번호, PK, FK
    to_user number(12), -- 팔로잉(팔로우를 하는 쪽), FK
    from_user number(12), -- 팔로워(팔로우를 받는 쪽), FK
   	constraint follow_pk primary key (mem_num),
    constraint follow_fk1 foreign key (to_user) references member (mem_num) ON DELETE CASCADE,
    constraint follow_fk2 foreign key (from_user) references member (mem_num) ON DELETE CASCADE
);

