
#sql 계정 생성 , 권한 부여
create user semiadmin identified by semiadmin;
grant resource, connect to semiadmin;
GRANT CREATE VIEW TO semiadmin;


#member 회원 테이블 ,sequence 
create table member(
member_no number primary key,
member_id varchar2(20) not null,
member_pw varchar2(20) not null,
member_name varchar(21) not null,
member_birth date not null,
member_gender char(1) check(member_gender in ('M', 'F')),
member_email varchar2(50) not null,
member_address varchar2(300) not null,
member_point number default 0 not null check(member_point >= 0),
member_phone varchar2(11) not null,
member_admin char(1) default 'N' not null check(member_admin in ('Y', 'N')),
member_join date default sysdate not null
);

create sequence member_seq nocache;


#qna_board 고객센터 테이블 ,sequence 
create table qna_board(
qna_board_no number(19) primary key,
qna_board_header varchar2(15) check(qna_board_header in('주문/결제','배송','환불/교환','기타')) not null,
qna_board_title varchar2(300) not null,
qna_board_content varchar2(4000) not null,
qna_board_writer references member(member_no) on delete cascade,
qna_board_time date default sysdate not null,
qna_board_reply number default 0 not null
);

create sequence qna_board_seq nocache;


#qna_reply 고객센터 답변 테이블 ,sequence
CREATE TABLE qna_reply(
qna_reply_no NUMBER(19) PRIMARY KEY,
qna_reply_content varchar2(4000),
qna_reply_time DATE DEFAULT sysdate NOT NULL,
qna_reply_writer REFERENCES member(member_no) ON DELETE SET NULL,
qna_reply_origin REFERENCES qna_board(qna_board_no) ON DELETE CASCADE
);

CREATE SEQUENCE qna_reply_seq nocache;


#qna_reply , member 고객센터 답변 & 회원 view 
CREATE VIEW qna_reply_member AS
SELECT 
	R.qna_reply_no, R.qna_reply_content, R.qna_reply_time, R.qna_reply_writer, R.qna_reply_origin,
	M.member_no, M.member_id, M.member_admin
FROM qna_reply R
	LEFT OUTER JOIN MEMBER M ON R.qna_reply_writer = M.member_no;

#notice 공지사항 테이블 ,sequence 
create table notice_board(
notice_board_no number(19) primary key,
notice_board_header varchar2(15) check(notice_board_header in('공지','이벤트')) not null,
notice_board_title varchar2(300) not null,
notice_board_content varchar2(4000) not null,
notice_board_writer references member(member_no) on delete cascade,
notice_board_time date default sysdate not null,
notice_board_read number default 0 not null
);

CREATE SEQUENCE notice_seq nocache;


#book 책 테이블 ,sequence 
create table book(
book_no number(10) primary key,
book_name varchar2(150) not null,
book_writer varchar2(50) not null,
book_publisher varchar2(50) not null,
book_genre varchar2(30) not null,
book_nation varchar2(30) not null,
book_price number(10) not null,
book_info varchar(4000) ,
book_img varchar2(100),
book_table varchar2(4000),
book_start date  default sysdate not null
);

ALTER TABLE book ADD book_view number(19) DEFAULT 0 NOT NULL CHECK (book_view >= 0);

create sequence book_seq;

#genre 장르 테이블 
create table genre(
genre_no number(38) primary key,
genre_name varchar2(30) not null,
genre_parents references genre(genre_no)
);

#book_like 좋아요 테이블 
create table book_like( 
member_no references member(member_no), 
book_origin references book(book_no), 
like_time date default sysdate not null, 
constraint book_like_pk primary key(member_no, book_origin) 
);


#purchase 구매기록 테이블 ,sequence 
create table purchase(
purchase_pk number(10) primary key,
purchase_no number(38),
purchase_state varchar2(50) default '결제완료' not null check(purchase_state in ('결제완료','주문확인','배송중','배송완료')) ,
purchase_book references book(book_no) not null,
purchase_member references member(member_no) not null,
purchase_date date default sysdate not null,
purchase_recipient varchar2(100) not null,
purchase_phone varchar2(11) not null,
purchase_address varchar2(400) not null,
purchase_amount number(10) default 1 not null
);

create sequence purchase_pk_seq;

CREATE SEQUENCE purchase_seq;

#review 책 상품 리뷰 테이블,sequence
create table review(
review_no number(18) primary key,
review_content varchar2(4000) not null,
review_rate number(5) , 
review_time date default sysdate,
review_book number(18) not null,
review_member number(18) not null
);

CREATE SEQUENCE review_seq;


#cart 장바구니 테이블 ,sequence
create table cart(
cart_no number primary key,
member_no number not null,
book_no number(10) not null,
cart_amount number(10) not null,
cart_time date default sysdate
);
alter table cart add CONSTRAINT cart_member_no_fk FOREIGN key(member_no) REFERENCES member(member_no);
alter table cart add CONSTRAINT cart_book_bo_fk FOREIGN key(book_no) REFERENCES book(book_no);

create SEQUENCE cart_seq NOCACHE;

#cart , book 장바구니 & 책 view
create view cart_view as
select
    B.book_no, B.book_title, B.book_image, B.book_author, B.book_price, B.book_discount,
    C.cart_no, C.cart_amount, C.cart_time, C.member_no
from book B
     inner join cart C on B.book_no = C.book_no;

select * from cart_view;
