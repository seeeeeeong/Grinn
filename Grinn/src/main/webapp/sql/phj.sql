--상품
create table item(
 item_num number, --상품번호
 item_brand varchar2(50) not null, --브랜드명
 item_name varchar2(50) not null, --상품이름
 item_detail varchar2(50) not null, --상품 설명
 item_date varchar2(10) not null, --상품 출시일
 item_price number(15) not null, --상품 정가
 item_photo1 blob not null, --상품 사진1
 item_photo1name varchar2(100) not null, --상품 사진1 이름
 item_photo2 blob, --상품 사진2
 item_photo2name varchar2(100), --상품 사진2 이름
 item_keyword1 varchar2(30), --상품 검색 키워드1
 item_keyword2 varchar2(30), --상품 검색 키워드2
 item_keyword3 varchar2(30), --상품 검색 키워드3
 item_cate number(1) not null, --상품 분류(1:신발, 2,상의, 3:하의, 4:기타)
 item_gender number(1) not null, --성별(1:남성, 2:여성, 3:기타)
 item_status number(1) not null, --상품판매가능여부(1:표시, 2:미표시)
 constraint item_pk primary key (item_num)
);
create sequence item_seq;

--상품후기
create table review(
 review_num number, --후기글번호
 review_content varchar2(500) not null, --후기 내용
 review_photo blob, --후기사진
 review_photoname varchar2(50),
 review_date date default sysdate not null,
 review_modifydate date,
 review_star number(1) not null,
 review_status number(1) not null,
 item_num number not null,
 mem_num number not null,
 constraint review_pk primary key (review_num),
 constraint review_fk1 foreign key (item_num) references item (item_num) ON DELETE CASCADE,
 constraint review_fk2 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);
create sequence review_seq;

--관심상품
create table item_fav(
 item_favnum number,
 item_num number not null,
 mem_num number not null,
 constraint item_fav_pk primary key (item_favnum),
 constraint item_fav_fk1 foreign key (item_num) references item (item_num) ON DELETE CASCADE,
 constraint item_fav_fk2 foreign key (mem_num) references member (mem_num) ON DELETE CASCADE
);
create sequence itemfav_seq;

--상품사이즈
create table item_size(
 item_sizenum number,
 item_cate number(1) not null,
 item_size varchar2(15),
 constraint size_pk primary key (item_sizenum)
);
create sequence itemsize_seq;