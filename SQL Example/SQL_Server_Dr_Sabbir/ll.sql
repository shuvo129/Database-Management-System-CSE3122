create database L
use L

create table books
(
  book_id char(10)primary key check(book_id like"B[0-9][0-9][0-9][0-9]"),
  book_title char (15)not null,
  author char (15) not null,
  catagory char (4)check(catagory in("tech","busi","arts")),
  book_price float check(book_price>=0),
  book_qoh int check(book_qoh>=0)
)


select *from books

insert books values("B0001","computer","jaksman","tech","10000",12)
insert books values("B0002","RAM","saifur","arts","3000",22)
insert books values("B0003","Microprocessor","raju","tech","500",30)
insert books values("B0004","DVD","sujon","busi","100",90)
insert books values("B0005","CDROM","mony","arts","6000",12)


create table members

(
  member_id char (6)primary key check(member_id like "S[0-9][0-9][0-9][0-9][0-9]"),
  fname char(15)not null,
  lname varchar(15),
  address text,
  noofcurrentissue int check(noofcurrentissue>=0),
  issue_ceiling int check(issue_ceiling>=0)
)

select *from members


insert members values("S00001","tulu","rahman","motherbox","12",3)
insert members values("S00002","vulu","rahman","habibur","102",5)
insert members values("S00003","gazi","rahman","latif","120",15)
insert members values("S00004","janu","rahman","joha","34",50)
insert members values("S00005","mony","rahman","amir","90",30)


create table transactions
(
  tran_id char(10)primary key check(tran_id like "T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"),
  book_id char (10)foreign key references books(book_id),
  member_id char(6)foreign key references members (member_id),
  tran_type char(1)check(tran_type in("i","r")),
  tran_date datetime
)

  insert transactions values("T000000001","B0001","S00001","i",12-07-08)
  insert transactions values("T000000002","B0002","S00002","i",12-07-08)
  insert transactions values("T000000003","B0001","S00003","i",12-07-08)
  insert transactions values("T000000004","B0004","S00001","i",12-07-08)
  insert transactions values("T000000005","B0002","S00005","i",12-07-08)

select *from transactions
drop table transactions

 create proc p1
 as
 begin
 select catagory ,"no of book"=sum(book_qoh),"average price"=avg(book_price) from books group by catagory
 end
 exec p1


create proc p5(@desiredavgprice float)
as
begin
select catagory,"noofbooks"=sum(book_qoh),"avg_price"=avg(book_price) from books group by catagory having avg(book_price)>@desiredavgprice
end
exec p5 5000

create proc p7(@desired_avg_issue_ceiling float)
as
begin
 declare @current_avg_issue_ceiling float
 select @current_avg_issue_ceiling=(select avg(issue_ceiling)from members)
 print @current_avg_issue_ceiling

 while(@current_avg_issue_ceiling<=@desired_avg_issue_ceiling)
 begin
 update members set issue_ceiling=issue_ceiling+1
 select @current_avg_issue_ceiling=(select avg(issue_ceiling)from members)
 print @current_avg_issue_ceiling
end
end

exec p7 60

create trigger trg1 on transactions for insert
as
begin
declare @mem_id char(6),@tr_type char(1),@bk_id char(10)
select @mem_id=member_id,@tr_type=tran_type,@bk_id=book_id from inserted
if(@tr_type="i")
 begin
  update books set book_qoh=book_qoh+2 where book_id=@bk_id
  update members set noofcurrentissue=noofcurrentissue+2 where member_id=@mem_id
 end
else
begin
  update books set book_qoh=book_qoh-2 where book_id=@bk_id
  update members set noofcurrentissue=noofcurrentissue+2 where member_id=@mem_id
 end
end

 insert transactions values("T000000007","B0002","S00005","i",12-07-08)

 select *from members
 select *from books
 select *from transactions

