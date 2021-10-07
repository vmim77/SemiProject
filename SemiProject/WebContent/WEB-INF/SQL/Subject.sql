select userid, referral
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

select userid,pwd
from tbl_member
where userid='소녀장현걸' and pwd='9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382';

