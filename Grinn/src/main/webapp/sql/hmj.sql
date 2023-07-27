--플리마켓 정보
create table market(
  market_num number,
  market_title varchar2(150) not null,
  market_detail clob,
  market_startDate date not null,
  market_endDate date not null,
  place_num number(3) default 1 not null,
  market_type number(1) not null,
  booth_count number(3) not null,
  user_count number(2) not null,
  booth_fee number(6),
  market_poster blob not null,
  market_posterName varchar2(100) not null,
  market_thumbNail blob not null,
  market_thumbNailName varchar2(100) not null,
  market_regDate date default sysdate not null,
  market_updateDate date,
  constraint market_pk primary key (market_num)
);

create sequence market_seq;

--부스 위치
create table boothLocation(
  location_num number,
  place_num number not null,
  location_row number not null,
  location_column number not null, 
  booth_comp number(1) not null,
  location_regDate date default sysdate not null,
  location_updateDate date,
  constraint boothLocation_pk primary key (location_num),
  constraint boothLocation_fk foreign key (place_num) references market (place_num) ON DELETE CASCADE
);

create sequence boothLocation_seq;

--부스 예약 정보
create table booking(
  book_num number,
  market_type number(1) not null,
  book_time date default sysdate not null,
  book_day date not null,
  market_num number not null,
  location_num number not null,
  book_status number(1) default 1 not null,
  booth_fee number(6) not null,
  booth_discount number(1),
  constraint booking_pk primary key (book_num),
  constraint booking_fk foreign key (market_type) references market (market_type) ON DELETE CASCADE,
  constraint booking_fk2 foreign key (market_num) references market (market_num) ON DELETE CASCADE,
  constraint booking_fk3 foreign key (location_num) references boothLocation (location_num) ON DELETE CASCADE,
);

create sequence booking_seq;

--플리마켓 예약 정보
create table reservation(
  res_seq number,
  res_num varchar2(10) unique,
  market_type number(1) not null,
  res_time date default sysdate not null,
  mem_num number not null,
  market_num number not null,
  entrance_time date not null,
  res_count number(1) default 1 not null ,
  res_status number(1) default 2 not null,
  constraint reservation_pk primary key (res_seq),
  constraint reservation_fk (market_type) references market (market_type) ON DELETE CASCADE,
  constraint reservation_fk2 (mem_num) references member (mem_num) ON DELETE CASCADE,
  constraint reservation_fk3 (market_num) references market (market_num) ON DELETE CASCADE,
);

create reservation_seq;