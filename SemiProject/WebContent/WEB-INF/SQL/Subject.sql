select *
from tab;

select *
from tbl_member;

select *
from USER_TAB_COLUMNS
where table_name = 'TBL_NOTICE_BOARD';

alter table tbl_notice_comment
modify comment_content Nvarchar2(50);
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.

select *
from user_constraints
where table_name = 'TBL_NOTICE_COMMENT';



select userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday, nvl(referral, '추천인 없음') AS referral, point, registerday, lastpwdchangedate, status, idle
from tbl_member
order by registerday asc;

select case gender when '1' then '남자' else '여자' end AS gender
from tbl_member;

select *
from user_constraints
where table_name = 'TBL_MEMBER';

alter table tbl_member
drop constraint UQ_TBL_MEMBER_EMAIL;
-- Table TBL_MEMBER이(가) 변경되었습니다.

alter table TBL_MEMBER
add constraint UQ_TBL_MEMBER_EMAIL unique (EMAIL);
-- Table TBL_MEMBER이(가) 변경되었습니다.

alter table tbl_member
add total_bought number(8) default 0;
-- Table TBL_MEMBER이(가) 변경되었습니다.

update tbl_member set status = 0, idle = 1
where userid = '성현';
-- 1 행 이(가) 업데이트되었습니다.

commit;
-- 커밋 완료.


select *
from tab;

select seq_tbl_notice.nextval
from dual;


create sequence seq_tbl_notice
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_NOTICE이(가) 생성되었습니다.

create table tbl_notice_board(
boardno     number not null,
fk_writer   varchar2(40),
title       Nvarchar2(100) not null,
content     Nvarchar2(200) not null,
writetime   date default sysdate,
viewcnt     number default '0',
constraint PK_TBL_NOTICE_BOARD_BOARDNO primary key(boardno),
constraint FK_TBL_NOTICE_BOARD_FK_WRITER foreign key (fk_writer) REFERENCES tbl_member(userid)
);
-- Table TBL_NOTICE_BOARD이(가) 생성되었습니다.

select to_char(writetime, 'yyyy-mm-dd hh24:mi') AS writetime
from tbl_notice_board;

alter table tbl_notice_board
modify viewcnt number default 0;
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.

alter table tbl_notice_board
modify boardno number;
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.

alter table tbl_notice_board
modify boardno number not null;
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.

alter table tbl_notice_board
modify title varchar2(100) not null;
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.

alter table tbl_notice_board
modify content varchar2(300) not null;
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.


insert into tbl_notice_board(boardno, fk_writer, title, content)
values(seq_tbl_notice.nextval, 'admin', 'test1', 'test1');
-- 1 행 이(가) 삽입되었습니다.

commit;
-- 커밋 완료.

select *
from tbl_notice_board;

create table tbl_notice_comment(
commentno           number,
fk_boardno          number,
fk_commenter        varchar2(40),
comment_content     Nvarchar2(50),
constraint FK_TBL_NOTICE_COMMENT_FK_BNO foreign key (fk_boardno) REFERENCES tbl_notice_board(boardno),
constraint FK_TBL_NOTICE_COMMNET_FK_CT  foreign key (fk_commenter)  REFERENCES tbl_member(userid),
constraint PK_TBL_NOTICE_COMMENT primary key(commentno)
);
-- Table TBL_NOTICE_COMMENT이(가) 생성되었습니다.

insert into tbl_notice_comment(fk_boardno, fk_commenter, comment_content)
values(2, 'kangkc', '댓글테스트');
-- 1 행 이(가) 삽입되었습니다.

commit;
-- 커밋 완료.

alter table tbl_notice_comment
rename column content to comment_content;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

select *
from tbl_notice_comment;

alter table tbl_notice_comment
modify comment_content varchar2(50) not null;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

alter table tbl_notice_comment
drop constraint FK_TBL_NOTICE_COMMENT_FK_BNO;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

alter table tbl_notice_comment
add constraint FK_TBL_NOTICE_COMMENT_FK_BNO foreign key (fk_boardno) REFERENCES tbl_notice_board(boardno) on delete cascade;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

alter table tbl_notice_comment
drop constraint FK_TBL_NOTICE_COMMNET_FK_WT;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

alter table tbl_notice_comment
rename COLUMN fk_writer to fk_commenter;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

alter table tbl_notice_comment
add constraint FK_TBL_NOTICE_COMMNET_FK_CT foreign key (fk_commenter) REFERENCES tbl_member(userid);
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

insert into tbl_notice_board(boardno, fk_writer, title, content)
values(seq_tbl_notice.nextval, 'admin', 'test2 글입니다.', '안녕하세요?');
-- 1 행 이(가) 삽입되었습니다.

insert into tbl_notice_comment(fk_boardno, fk_commenter, comment_content)
values(3, 'kangkc', '운영자님안녕하세요');
insert into tbl_notice_comment(fk_boardno, fk_commenter, comment_content)
values(3, '소녀장현걸', '운영자님도 안녕하세요2');
insert into tbl_notice_comment(fk_boardno, fk_commenter, comment_content)
values(3, 'test1', '운영자님 안녕하세요3');
insert into tbl_notice_comment(fk_boardno, fk_commenter, comment_content)
values(3, 'admin', '안녕하세요');

commit;
-- 커밋 완료.

alter table tbl_notice_comment
modify comment_content Nvarchar2(50);
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.


select * 
from tbl_notice_comment
order by registerdate asc;

select count(*)
from tbl_notice_comment
where fk_boardno = 2;

delete from tbl_notice_comment;
-- 12개 행 이(가) 삭제되었습니다.
commit;
--커밋 완료.

alter table tbl_notice_comment
add registerdate date default sysdate;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

select boardno, fk_writer, title, content, writetime, viewcnt, CommentCnt
from
(
    select boardno, fk_writer, title, content, to_char(writetime, 'yyyy-mm-dd hh24:mi') as writetime, viewcnt
    from tbl_notice_board
    order by boardno desc
) A
join 
( 
    select fk_boardno, count(*) AS CommentCnt
    from tbl_notice_comment
    group by fk_boardno
) B
on A.boardno = B.fk_boardno

alter table tbl_notice_board
modify content Nvarchar2(200);
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.

select *
from tbl_notice_board;

update tbl_notice_board set fk_writer = 'admin'
where boardno = 8;
-- 1 행 이(가) 업데이트되었습니다.

commit;
-- 커밋 완료.

select case when length(title) > 20 then substr(title, 1, 10) || '...' else title end AS title 
from tbl_notice_board;


alter table tbl_notice_comment
add commentno number default 0;
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

select *
from tbl_notice_comment;

create sequence seq_notice_comment
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_NOTICE_COMMENT이(가) 생성되었습니다.

alter table tbl_notice_comment
add constraint PK_TBL_NOTICE_COMMENT primary key(commentno);
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.


alter table tbl_notice_comment
modify comment_content Nvarchar2(50);
-- Table TBL_NOTICE_COMMENT이(가) 변경되었습니다.

create table tbl_notice_viewhistory(
fk_boardno     number,
fk_userid      varchar2(40),
viewcheck      number default 1,
viewdate       date default sysdate,
constraint FK_NOTICE_H_BOARDNO foreign key(fk_boardno) references tbl_notice_board(boardno),
constraint FK_NOTICE_H_USERID  foreign key(fk_userid)  references tbl_member(userid),
constraint CK_NOTICE_H_VIEWCHECK check(viewcheck in(1, 2))
)
-- Table TBL_NOTICE_VIEWHISTORY이(가) 생성되었습니다.

alter table tbl_notice_viewhistory
modify viewdate date default sysdate;
-- Table TBL_NOTICE_VIEWHISTORY이(가) 변경되었습니다.

alter table tbl_notice_viewhistory
modify viewcheck number default 1;
-- Table TBL_NOTICE_VIEWHISTORY이(가) 변경되었습니다.

insert into tbl_notice_viewhistory(fk_boardno, fk_userid, viewdate)
values(20, 'kangkc', sysdate);
-- 1 행 이(가) 삽입되었습니다.

commit;
-- 커밋 완료.

select *
from tbl_notice_viewhistory
where fk_boardno = 20 and fk_userid = 'kangkc' and to_char(viewdate, 'yy/mm/dd') = '21/10/06';

select * 
from tbl_member;

update tbl_notice_viewhistory set viewdate = '21/10/05'
where fk_userid = 'kangkc';

commit;

select *
from user_constraints
where table_name = 'TBL_MEMBER';

alter table tbl_member
drop constraint UQ_TBL_MEMBER_EMAIL;
-- Table TBL_MEMBER이(가) 변경되었습니다.



create or replace procedure pcd_member_insert
(p_userid   IN     varchar2
,p_name     IN     varchar2
,p_gender   IN     char)
is
begin
    for i in 1..100 loop
        insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
        values(p_userid||i, '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', p_name||i, 'qiLx8/Odd/4geV1BxitYbZgPX/Y4b6G0cFcMt/t/BU8=', 'h691zYcMu1s+kfHCP/HroA==', '22675', '인천 서구 청마로', '101동 501호', ' (당하동)', p_gender, '1995-09-29');
    end loop;
end pcd_member_insert;
-- Procedure PCD_MEMBER_INSERT이(가) 컴파일되었습니다.

exec pcd_member_insert('iyou', '아이유', '2');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

commit;
-- 커밋 완료.

exec pcd_member_insert('seokj', '서강준', '1');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
commit;
-- 커밋 완료.


insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
values('kimys', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김유신', 'qiLx8/Odd/4geV1BxitYbZgPX/Y4b6G0cFcMt/t/BU8=', 'h691zYcMu1s+kfHCP/HroA==', '22675', '인천 계양구 계산동 한국아파트', '101동 1201호', ' (계산동)', '1', '1995-09-29');

insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
values('youjs', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '유재석', 'qiLx8/Odd/4geV1BxitYbZgPX/Y4b6G0cFcMt/t/BU8=', 'h691zYcMu1s+kfHCP/HroA==', '22675', '인천 계양구 계산동 한국아파트', '101동 1201호', ' (계산동)', '1', '1995-09-29');


select ceil(count(*)/3)
from tbl_member
where userid != 'admin';

select ceil(count(*)/5)
from tbl_member;


select rno, userid, name, gender
from
(
    select rownum AS rno, userid, name, email, gender
    from
    ( 
        select userid, name, email, gender
        from tbl_member
        where userid != 'admin'
        order by registerday desc
    ) V
) T
where rno between 16 and 20;


select *
from USER_TAB_COLUMNS
where table_name = 'TBL_NOTICE_BOARD';

alter table tbl_notice_board
add imgfilename varchar2(200);
-- Table TBL_NOTICE_BOARD이(가) 변경되었습니다.

select * 
from tbl_notice_comment;

select * 
from tbl_member;

delete from tbl_member
where name like '%' || '아이유' || '%';

commit;

delete from tbl_notice_comment
where fk_commenter like '%' || 'iyou' || '%';

---- *** 제품 테이블 : tbl_product *** ----
-- drop table tbl_product purge; 
create table tbl_product
(pnum           number(8) not null       -- 제품번호(Primary Key)
,pname          varchar2(100) not null   -- 제품명
,fk_cnum        number(8)                -- 카테고리코드(Foreign Key)의 시퀀스번호 참조
,pimage1        varchar2(100) default 'noimage.png' -- 제품이미지1   이미지파일명
,pimage2        varchar2(100) default 'noimage.png' -- 제품이미지2   이미지파일명
,pimage3        varchar2(100) default 'noimage.png'
,pimage4        varchar2(100) default 'noimage.png'
,pqty           number(8) default 0      -- 제품 재고량
,price          number(8) default 0      -- 제품 정가
,saleprice      number(8) default 0      -- 제품 판매가(할인해서 팔 것이므로)                                          
,pinputdate     date default sysdate     -- 제품입고일자
,constraint  PK_tbl_product_pnum primary key(pnum)
,constraint  FK_tbl_product_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
);

-----------------------------------------------------------------
create table tbl_category
(cnum    number(8)     not null  -- 카테고리 대분류 번호
,code    varchar2(20)  not null  -- 카테고리 코드
,cname   varchar2(100) not null  -- 카테고리명
,constraint PK_tbl_category_cnum primary key(cnum)
,constraint UQ_tbl_category_code unique(code)
);
-----------------------------------------------------------------
create sequence seq_category_cnum 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-------------------------------------------------------------------
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '10000', 'dubby');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '20000', 'mul');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '30000', 'boots');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '40000', 'loper');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '50000', 'oxpode');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '60000', 'mongk');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '70000', 'sandle');

commit;
-------------------------------------------------------------------------------------------------

select *
from tab;

select *
from tbl_member;

select *
from USER_TAB_COLUMNS
where table_name = 'TBL_CATEGORY';

select * 
from user_constraints
where table_name = 'TBL_PRODUCT';