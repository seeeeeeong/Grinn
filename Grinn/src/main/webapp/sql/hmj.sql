----플리마켓----
--플리마켓 정보
create table market(
  market_num number, -- 플리마켓 번호
  market_title varchar2(150) not null, -- 플리마켓 제목
  market_detail clob, -- 플리마켓 상세정보
  market_startDate varchar2(10) not null, -- 플리마켓 시작일
  market_endDate varchar2(10) not null, -- 플리마켓 종료일
  place_name varchar2(300) not null, -- 개최장소 번호
  market_type number(1) not null, -- 플리마켓 예약 유형(1:부스 예약, 2:입장 예약)
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

--부스 위치
/*create table boothLocation(
  location_num number, -- 위치 번호
  market_num number not null, -- 플리마켓 번호
  location_row number not null, -- 부스 위치 행(배열)
  location_column number not null, -- 부스 위치 열(배열)
  booth_comp number(1) not null, -- 부스 예약 완료 여부(1:미완료, 2:완료)
  location_regDate date default sysdate not null, -- 위치 등록일
  location_updateDate date, -- 위치 수정일
  constraint boothLocation_pk primary key (location_num),
  constraint boothLocation_fk foreign key (market_num) references market (market_num) ON DELETE CASCADE
);

create sequence boothLocation_seq;*/

--부스 예약 등록 
/*create table boothReservation(
  boothRes_num number, -- 부스 예약 등록 번호
  location_row number not null, -- 부스 행 번호
  location_column number not null, -- 부스 열 번호
  boothRes_regDate date default sysdate not null, -- 부스 예약 등록일
  constraint boothReservation_pk primary key (boothRes_num)
);

create sequence boothReservation_seq;*/

--부스 예약 정보**
create table booking(
  book_num number, -- 부스 예약 번호
  book_regDate date default sysdate not null, -- 예약한 시간
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
--회원별 페널티 요약**
create table penalty(
  pe_num number, -- 회원 페널티 고유번호
  mem_num number not null, -- 회원번호
  pe_total number(3) not null, -- 회원 페널티 총합
  mem_auth number(1) not null, -- 회원 등급
  constraint penalty_pk primary key (pe_num),
  constraint penalty_fk foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
  constraint penalty_fk2 foreign key (mem_auth) references member (mem_auth) ON DELETE CASCADE
);

create sequence penalty_seq;

--회원별 게시판 페널티
create table penalty_board(
  peBoard_num number, -- 게시판 페널티 고유번호
  mem_num number not null, -- 회원번호
  peBoard_score number(3) not null, -- 게시판 신고 페널티 점수
  rep_type number(1) not null, -- 페널티 유형
  peBoard_date date default sysdate not null, -- 게시판 페널티 부여일
  rst_num number not null, -- 게시물 신고 번호
  constraint penalty_board_pk primary key (peBoard_num),
  constraint penalty_board_fk foreign key (mem_num) references member (mem_num) ON DELETE CASCADE,
  constraint penalty_board_fk2 foreign key (rst_num) references report_st (rst_num) ON DELETE CASCADE
);

create sequence penalty_board_seq;

--회원별 거래 페널티
create table penalty_trade(
  peTrade_num number, -- 거래 페널티 고유번호
  mem_num number not null, -- 회원번호
  peTrade_score number(3) not null, -- 거래 신고 페널티 점수
  peTrade_type number(1) not null, -- 페널티 유형
  peTrade_date date default sysdate not null, -- 거래 페널티 부여일
  constraint penalty_trade_pk primary key (peTrade_num),
  constraint penalty_trade_fk foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);

create sequence penalty_trade_seq;

----프로모션----
--프로모션 등록 정보
create table promotion(
  pro_num number, -- 프로모션 번호
  pro_name varchar2(150) not null, -- 프로모션 제목
  pro_content clob not null, -- 프로모션 내용
  pro_photo1 blob not null, -- 프로모션 사진1
  pro_photo2 blob, -- 프로모션 사진2
  pro_hit number(9) not null, -- 프로모션 조회수
  pro_regDate date default sysdate not null, -- 프로모션 등록일
  pro_openDate date not null, -- 프로모션 시작일
  pro_cloDate date not null, -- 프로모션 종료일
  pro_ing number(1) not null, -- 프로모션 진행 여부(1:진행중, 2:종료)
  pro_hide number(1) not null, -- 프로모션 숨김 여부(1:숨김, 2:공개)
  constraint promotion_pk primary key (pro_num)
);

create sequence promotion_seq;