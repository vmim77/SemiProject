select * 
from tbl_member;

select *
from USER_TAB_COLUMNS
where table_name = 'TBL_MEMBER';

select userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday, nvl(referral, '추천인 없음') AS referral, point, registerday, lastpwdchangedate, status, idle
from tbl_member
order by registerday asc;
