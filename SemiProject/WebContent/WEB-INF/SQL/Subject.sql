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


