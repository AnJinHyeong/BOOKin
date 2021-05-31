
#sql 계정 생성 , 권한 부여
create user semiadmin identified by semiadmin;

grant resource, connect to semiadmin;



#member 테이블 생성,sequence 생성
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


#qna_board 테이블 생성 , sequence 생성
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

#book 테이블 생성, sequence 생성
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
create sequence book_seq;

#장르 테이블
create table genre(
genre_no number(38) primary key,
genre_name varchar2(30) not null,
genre_parents references genre(genre_no)
);



#qna_reply 테이블 생성 , sequence생성(qna 답글 기능)
CREATE TABLE qna_reply(
qna_reply_no NUMBER(19) PRIMARY KEY,
qna_reply_content varchar2(4000),
qna_reply_time DATE DEFAULT sysdate NOT NULL,
qna_reply_writer REFERENCES member(member_no) ON DELETE SET NULL,
qna_reply_origin REFERENCES qna_board(qna_board_no) ON DELETE CASCADE
);

CREATE SEQUENCE qna_reply_seq nocache;

#장르추가 sql문
set define off;
alter system set open_cursors = 1000;
insert into genre values(270,'여행/지도',null);
insert into genre values(270010,'국내여행',270);
insert into genre values(270010010,'전국여행',270010);
insert into genre values(270010020,'강원/영동',270010);
insert into genre values(270010030,'충청도',270010);
insert into genre values(270010040,'경상도/영남',270010);
insert into genre values(270010050,'전라도/호남',270010);
insert into genre values(270010060,'제주도',270010);
insert into genre values(270010070,'서울/경기',270010);
insert into genre values(270020,'해외여행',270);
insert into genre values(270020010,'세계여행',270020);
insert into genre values(270020020,'유럽여행',270020);
insert into genre values(270020030,'미국/캐나다/중남미',270020);
insert into genre values(270020040,'일본여행',270020);
insert into genre values(270020050,'중국여행',270020);
insert into genre values(270020060,'인도/아시아여행',270020);
insert into genre values(270020070,'기타여행',270020);
insert into genre values(270030,'테마여행',270);
insert into genre values(270030010,'역사/문학기행',270030);
insert into genre values(270030020,'배낭여행',270030);
insert into genre values(270030030,'맛집여행',270030);
insert into genre values(270030040,'체험학습/가족여행',270030);
insert into genre values(270030050,'기타',270030);
insert into genre values(270040,'지도/지리',270);
insert into genre values(270040010,'지리일반/지리학',270040);
insert into genre values(270040020,'국내지도',270040);
insert into genre values(270040030,'해외지도',270040);
insert into genre values(160,'경제/경영',null);
insert into genre values(160010,'경제',160);
insert into genre values(160010010,'쉽게읽는 경제',160010);
insert into genre values(160010020,'경제전망',160010);
insert into genre values(160010030,'경제사상/이론',160010);
insert into genre values(160010040,'한국경제',160010);
insert into genre values(160010050,'국제경제',160010);
insert into genre values(160010060,'금융/재정/화폐',160010);
insert into genre values(160020,'경영',160);
insert into genre values(160020010,'경영일반/이론',160020);
insert into genre values(160020020,'경영전략/혁신',160020);
insert into genre values(160020030,'기업/경영자스토리',160020);
insert into genre values(160020040,'경영실무',160020);
insert into genre values(160020040010,'인사/총무',160020);
insert into genre values(160020040020,'회계/재무',160020);
insert into genre values(160020040030,'생산/품질관리',160020);
insert into genre values(160020040040,'무역',160020);
insert into genre values(160020040050,'교통/통신/해운',160020);
insert into genre values(160020040060,'관광/호텔',160020);
insert into genre values(160020040070,'유통/물류',160020);
insert into genre values(160030,'마케팅/세일즈',160);
insert into genre values(160030010,'마케팅일반',160030);
insert into genre values(160030020,'마케팅전략',160030);
insert into genre values(160030030,'광고/홍보',160030);
insert into genre values(160030040,'영업/세일즈',160030);
insert into genre values(160030050,'트렌드/미래예측',160030);
insert into genre values(160040,'재테크/투자',160);
insert into genre values(160040010,'재테크일반',160040);
insert into genre values(160040020,'부동산/경매',160040);
insert into genre values(160040030,'주식/증권',160040);
insert into genre values(160050,'창업/취업',160);
insert into genre values(160050010,'창업/장사',160050);
insert into genre values(160050020,'취업',160050);
insert into genre values(280,'컴퓨터/IT',null);
insert into genre values(280010,'웹/컴퓨터입문/활용',280);
insert into genre values(280010010,'웹/홈페이지',280010);
insert into genre values(280010020,'컴퓨터입문/활용',280010);
insert into genre values(280010030,'컴퓨터게임',280010);
insert into genre values(280020,'IT 전문서',280);
insert into genre values(280020010,'개발/OS/데이터베이스',280020);
insert into genre values(280020020,'프로그래밍언어',280020);
insert into genre values(280020030,'네트워크보안',280020);
insert into genre values(280020040,'컴퓨터공학',280020);
insert into genre values(280030,'그래픽/멀티미디어',280);
insert into genre values(280030010,'3DS/MAX',280030);
insert into genre values(280030020,'그래픽일반/자료집 ',280030);
insert into genre values(280030030,'그래픽툴/저작툴 ',280030);
insert into genre values(280030040,'기타',280030);
insert into genre values(280040,'오피스활용도서',280);
insert into genre values(280040010,'MS Excel',280040);
insert into genre values(280040020,'MS Word',280040);
insert into genre values(280040030,'MS PowerPoint',280040);
insert into genre values(280040040,'기타',280040);
insert into genre values(280050,'컴퓨터수험서',280);
insert into genre values(280050010,'정보처리',280050);
insert into genre values(280050020,'컴퓨터활용능력',280050);
insert into genre values(280050030,'워드프로세스',280050);
insert into genre values(280050040,'컴퓨터수험서기타',280050);
insert into genre values(330,'만화',null);
insert into genre values(33001000,'교양만화',330);
insert into genre values(33002000,'드라마',330);
insert into genre values(33003000,'성인만화',330);
insert into genre values(33004000,'순정만화',330);
insert into genre values(33005000,'스포츠만화',330);
insert into genre values(33006000,'SF/판타지',330);
insert into genre values(33007000,'액션/무협만화',330);
insert into genre values(33008000,'명랑/코믹만화',330);
insert into genre values(33009000,'공포/추리',330);
insert into genre values(33010000,'학원만화',330);
insert into genre values(33011000,'웹툰/카툰에세이',330);
insert into genre values(33012000,'기타만화',330);
insert into genre values(33013000,'일본어판 만화',330);
insert into genre values(33014000,'영문판 만화',330);
insert into genre values( 100,'소설',null);
insert into genre values( 100010,'나라별 소설',100);
insert into genre values( 100010010,'한국소설',100010);
insert into genre values( 100010020,'영미소설',100010);
insert into genre values( 100010030,'일본소설',100010);
insert into genre values( 100010040,'중국소설',100010);
insert into genre values( 100010050,'러시아소설',100010);
insert into genre values( 100010060,'프랑스소설',100010);
insert into genre values( 100010070,'독일소설',100010);
insert into genre values( 100010080,'기타나라소설',100010);
insert into genre values( 100020,'고전/문학',100);
insert into genre values( 100020010,'한국고전소설',100020);
insert into genre values( 100020020,'세계문학',100020);
insert into genre values( 100020030,'세계고전',100020);
insert into genre values( 100030,'장르소설',100);
insert into genre values( 100030010,'SF/판타지',100030);
insert into genre values( 100030020,'추리',100030);
insert into genre values( 100030030,'전쟁/역사',100030);
insert into genre values( 100030040,'로맨스',100030);
insert into genre values( 100030050,'무협',100030);
insert into genre values( 100030060,'공포/스릴러',100030);
insert into genre values( 100040,'테마소설',100);
insert into genre values( 100040010,'인터넷소설',100040);
insert into genre values( 100040020,'영화/드라마소설',100040);
insert into genre values( 100040030,'가족/성장소설',100040);
insert into genre values( 100040040,'어른을 위한 동화',100040);
insert into genre values( 100040050,'라이트 노벨',100040);
insert into genre values( 110,'시/에세이',null);
insert into genre values( 11001000,'한국시',110);
insert into genre values( 11002000,'외국시',110);
insert into genre values( 11003000,'인물 에세이',110);
insert into genre values( 11004000,'여행 에세이',110);
insert into genre values( 11005000,'성공 에세이',110);
insert into genre values( 11006000,'독서 에세이',110);
insert into genre values( 11007000,'명상 에세이',110);
insert into genre values( 11008000,'그림/포토 에세이',110);
insert into genre values( 11009000,'연애/사랑 에세이',110);
insert into genre values( 11010000,'삶의 지혜/명언',110);
insert into genre values( 210,'예술/대중문화',null);
insert into genre values( 210010,'예술일반',210);
insert into genre values( 210010010,'예술이야기',210010);
insert into genre values( 210010020,'예술론/예술사',210010);
insert into genre values( 210010030,'미학/예술철학',210010);
insert into genre values( 210010040,'예술사전/잡지',210010);
insert into genre values( 210020,'미술',210);
insert into genre values( 210020010,'미술이야기',210020);
insert into genre values( 210020020,'미술론/미술사',210020);
insert into genre values( 210020030,'미술실기/기법',210020);
insert into genre values( 210020040,'공예/서예',210020);
insert into genre values( 210020050,'디자인',210020);
insert into genre values( 210030,'음악',210);
insert into genre values( 210030010,'음악이야기',210030);
insert into genre values( 210030020,'음악이론/음악사',210030);
insert into genre values( 210030030,'장르별음악',210030);
insert into genre values( 210030040,'악기/악보집',210030);
insert into genre values( 210040,'건축',210);
insert into genre values( 210040010,'건축이야기',210040);
insert into genre values( 210040020,'건축이론/건축사',210040);
insert into genre values( 210040030,'건축가',210040);
insert into genre values( 210050,'만화/애니메이션',210);
insert into genre values( 210050010,'만화 일반',210050);
insert into genre values( 210050020,'만화 작법/기법',210050);
insert into genre values( 210050030,'애니메이션 일반',210050);
insert into genre values( 210060,'사진',210);
insert into genre values( 210060010,'사진일반',210060);
insert into genre values( 210060020,'사진작가/사진집',210060);
insert into genre values( 210060030,'사진이론과 실기',210060);
insert into genre values( 210070,'연극/영화',210);
insert into genre values( 210070010,'연극일반',210070);
insert into genre values( 210070020,'연극이론/비평',210070);
insert into genre values( 210070030,'연극사/연극이론',210070);
insert into genre values( 210070040,'영화사/영화이론',210070);
insert into genre values( 210070050,'희곡/시나리오',210070);
insert into genre values( 210070060,'영화제작/비평',210070);
insert into genre values( 210080,'TV/대중문화',210);
insert into genre values( 210080010,'미디어/광고',210080);
insert into genre values( 210080020,'드라마 극본',210080);
insert into genre values( 210080030,'시나리오/희곡 작법',210080);
insert into genre values( 210080040,'문화비평',210080);
insert into genre values( 290,'잡지',null);
insert into genre values( 290010,'여성/패션/리빙',290);
insert into genre values( 290010010,'여성/패션',290010);
insert into genre values( 290010020,'건강/요리',290010);
insert into genre values( 290010030,'리빙/인테리어',290010);
insert into genre values( 290010040,'결혼/육아',290010);
insert into genre values( 290020,'인문/사회/종교',290);
insert into genre values( 290020010,'시사/사회',290020);
insert into genre values( 290020020,'경제/경영',290020);
insert into genre values( 290020030,'종교',290020);
insert into genre values( 290020040,'행정/고시/정치',290020);
insert into genre values( 290030,'문예/교양지',290);
insert into genre values( 290030010,'문예',290030);
insert into genre values( 290030020,'출판',290030);
insert into genre values( 290030030,'교양',290030);
insert into genre values( 290040,'자연/공학',290);
insert into genre values( 290040010,'기계/자동차',290040);
insert into genre values( 290040020,'의학/건강',290040);
insert into genre values( 290040030,'농학/원예',290040);
insert into genre values( 290040040,'자연과학',290040);
insert into genre values( 290040050,'기타',290040);
insert into genre values( 290050,'컴퓨터/게임/그래픽',290);
insert into genre values( 290050010,'그래픽',290050);
insert into genre values( 290050020,'컴퓨터',290050);
insert into genre values( 290050030,'웹',290050);
insert into genre values( 290050040,'게임(Game)',290050);
insert into genre values( 290060,'어학/교육',290);
insert into genre values( 290060010,'아동학습',290060);
insert into genre values( 290060020,'중고학습',290060);
insert into genre values( 290060030,'어학',290060);
insert into genre values( 290060040,'방송교재',290060);
insert into genre values( 290070,'예술/대중문화',290);
insert into genre values( 290070010,'영화/공연',290070);
insert into genre values( 290070020,'사진',290070);
insert into genre values( 290070030,'음악/미술',290070);
insert into genre values( 290070040,'방송/연예',290070);
insert into genre values( 290070050,'기타',290070);
insert into genre values( 290080,'취미/여행',290);
insert into genre values( 290080010,'레저/스포츠',290080);
insert into genre values( 290080020,'여행',290080);
insert into genre values( 290080030,'바둑/낚시/등산',290080);
insert into genre values( 290080050,'기타',290080);
insert into genre values( 290090,'외국잡지',290);
insert into genre values( 290090010,'Fashion & Living',290090);
insert into genre values( 290090020,'Entertainment',290090);
insert into genre values( 290090030,'News & Economy',290090);
insert into genre values( 290090040,'Art & Design',290090);
insert into genre values( 290090050,'기타외국잡지',290090);
commit;

#notice_board 테이블 생성 , sequence생성(공지사항 기능)
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

#좋아요 테이블 생성
create table book_like(
member_no references member(member_no),
book_origin references book(book_no),
like_time date default sysdate not null,
constraint book_like_pk primary key(member_no, book_origin)
);