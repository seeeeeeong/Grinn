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
  constraint boothLocation_fk foreign key (place_num) references market (place_num)
);

create sequence boothLocation_seq;