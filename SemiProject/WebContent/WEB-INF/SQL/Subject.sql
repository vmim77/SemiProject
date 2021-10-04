select *
from tbl_member;

select *
from USER_TAB_COLUMNS
where table_name = 'TBL_MEMBER';

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
title       varchar2(100) not null,
content     varchar2(300) not null,
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
fk_boardno          number,
fk_commenter           varchar2(40),
comment_content     varchar2(50),
constraint FK_TBL_NOTICE_COMMENT_FK_BNO foreign key (fk_boardno) REFERENCES tbl_notice_board(boardno),
constraint FK_TBL_NOTICE_COMMNET_FK_CT  foreign key (fk_commenter)  REFERENCES tbl_member(userid)
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
from tbl_notice_comment;

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



