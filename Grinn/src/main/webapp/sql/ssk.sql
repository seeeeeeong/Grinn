-- 거래 테이블
create table trade(
 trade_num number,
 item_num number not null,
 buyer_num number not null,
 seller_num number not null,
 constraint trade_pk primary key (trade_num),
 constraint trade_fk1 foreign key (item_num) references item (item_num) ON DELETE CASCADE,
 constraint trade_fk2 foreign key (buyer_num) references member (mem_num) ON DELETE CASCADE,
 constraint trade_fk3 foreign key (seller_num) references member (mem_num) ON DELETE CASCADE
);
create sequence trade_seq;

-- 거래 상세 테이블
create table trade_detail(
	trade_num number,
	item_num number not null,
	trade_state number(1) default 0 not null,
	trade_regDate date default sysdate not null,
	item_sizenum number not null,
	trade_price number(9) not null,
	trade_zipcode varchar2(100) not null,
	trade_address1 varchar2(100) not null,
	trade_address2 varchar2(100) not null,
	constraint trade_detail_pk (trade_num),
	constraint trade_detail_fk1 (trade_num) references trade (trade_num) ON DELETE CASCADE,
	constraint trade_detail_fk2 (item_num) references item (item_num) ON DELETE CASCADE,
	constraint trade_detail_fk3 (item_sizenum) references size (item_sizenum) ON DELETE CASCADE
);

-- 구매 입찰 정보 테이블
create table purchase_bid(
	purchase_num number,
	mem_num number not null,
	item_num number not null,
	item_sizenum number not null,
	purchase_price number(40) not null,
	purchase_regDate date default sysdate not null,
	purchase_deadline date not null,
	constraint purchase_bid_pk (purchase_num),
	constraint purchase_bid_fk1 (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint purchase_bid_fk2 (item_num) references item (item_num) ON DELETE CASCADE,
	constraint purchase_bid_fk3 (item_sizenum) references size (item_sizenum) ON DELETE CASCADE
);
create sequence purchase_bid_seq;

-- 판매 입찰 정보 테이블 
create table sale_bid(
	sale_num number,
	mem_num number not null,
	item_num number not null,
	item_sizenum number not null,
	sale_price number(40) not null,
	sale_regDate date default sysdate not null,
	sale_deadline date not null,
	constraint sale_bid_pk (sale_num),
	constraint sale_bid_fk1 (mem_num) references member (mem_num) ON DELETE CASCADE,
	constraint sale_bid_fk2 (item_num) references item (item_num) ON DELETE CASCADE,
	constraint sale_bid_fk3 (item_sizenum) references size (item_sizenum) ON DELETE CASCADE
);
create sequence sale_bid_seq;