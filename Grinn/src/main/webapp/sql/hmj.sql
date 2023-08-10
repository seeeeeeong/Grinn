----플리마켓----
--플리마켓 정보
create table market(
  market_num number, -- 플리마켓 번호
  market_title varchar2(150) not null, -- 플리마켓 제목
  market_detail clob, -- 플리마켓 상세정보
  market_startDate varchar2(10) not null, -- 플리마켓 시작일
  market_endDate varchar2(10) not null, -- 플리마켓 종료일
  place_name varchar2(300) not null, -- 개최장소 번호
  market_type number(1) not null, -- 플리마켓 진행 유형(1:예정, 2:예약 중, 3:종료)
  booth_count number(3) not null, -- 부스 자리수
  booth_fee number(6), -- 부스 예약비용
  market_poster blob not null, -- 플리마켓 포스터
  market_posterName varchar2(100) not null, -- 포스터 이름
  market_thumbNail blob not null, -- 플리마켓 썸네일 
  market_thumbNailName varchar2(100) not null, -- 썸네일 이름
  market_regDate date default sysdate not null, -- 플리마켓 등록일
  market_updateDate date, -- 플리마켓 수정일
  constraint market_pk primary key (market_num)
);

create sequence market_seq;


--부스 예약 정보**
create table booking(
  book_num number, -- 부스 예약 번호
  book_regDate date default sysdate not null, -- 예약한 시간
  book_date1 varchar2(10) not null, -- 예약하려는 날짜1(시작일)
  book_date2 varchar2(10) not null, -- 예약하려는 날짜2(종료일)
  get_count number(1) not null, -- 예약한 자리 수(1회원 1개 제한)
  market_num number not null, -- 플리마켓 번호
  mem_num number not null, -- 회원 번호
--  book_status number(1) default 1 not null, -- 예약 현황(1:미입금, 2:입금완료, 3:취소)
--  booth_fee number(6) not null, -- 부스 예약비용
--  booth_discount number(1), -- 부스 예약비용 할인
  constraint booking_pk primary key (book_num),
  constraint booking_fk foreign key (market_num) references market (market_num) ON DELETE CASCADE,
  constraint booking_fk2 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);

create sequence booking_seq;

----페널티----
--회원별 페널티
create table penalty(
  pe_num number, -- 회원 페널티 고유번호
  mem_num number not null, -- 회원번호
  pe_service_type number(1) not null, -- 페널티 유형(1:게시판, 2:거래)
  pe_score number(3) not null, -- 회원 페널티 점수
  pe_type number(1) not null, -- 페널티 부여 사유(1~3:게시글, 4~6:댓글, 7~9:거래)
  pe_date date default sysdate not null,
  constraint penalty_pk primary key (pe_num),
  constraint penalty_fk foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);

create sequence penalty_seq;


----프로모션----
--프로모션 등록 정보
create table promotion(
  pro_num number, -- 프로모션 번호
  pro_name varchar2(150) not null, -- 프로모션 제목
  pro_content clob not null, -- 프로모션 내용
  pro_photo1 blob not null, -- 프로모션 사진1
  pro_photoName1 varchar2(100) not null, -- 프로모션 사진 이름1
  pro_regDate date default sysdate not null, -- 프로모션 등록일
  pro_openDate varchar2(10) not null, -- 프로모션 시작일
  pro_cloDate varchar2(10) not null, -- 프로모션 종료일
  pro_ing number(1) not null, -- 프로모션 진행 여부(1:진행 예정, 2:진행 중, 3:종료)
  pro_hide number(1) not null, -- 프로모션 숨김 여부(1:숨김, 2:공개)
  constraint promotion_pk primary key (pro_num)
);

create sequence promotion_seq;