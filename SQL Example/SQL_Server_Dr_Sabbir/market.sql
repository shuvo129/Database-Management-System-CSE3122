create database market
use market

create table books
(
  book_id char(10)primary key check(book_id like "B[0-9][0-9][0-9][0-9]"),
  book_title char(15)not null,
  author char(15)not null,
  catagory char(4)check(catagory in("tech","arts","busi")),
  book_price float check(book_price>=0),
  book_qoh int check(book_qoh>=0)
)

 select *from books
 drop table books
 
 insert books values("B0001","ram","tulu","tech","1000",40)
 insert books values("B0002","cd","rony","arts","300",25)
 insert books values("B0003","hdd","mony","busi","3000",8)
 insert books values("B0004","dvd","jony","tech","6000",10)
 insert books values("B0005","cat","eva","arts","600",20)
 insert books values("B0006","dog","ronju","busi","900",70)


 create table members
(
  member_id char(6)primary key check(member_id like "s[0-9][0-9][0-9][0-9][0-9]"),
  fname char(15)not null,
  lname varchar(15)null,
  address text,
  noofcurrentissue int check(noofcurrentissue>=0),
  issue_ceiling int check(issue_ceiling>=0)
)
 
 select *from members 
 drop table members

 insert members values("s00001","tulu","rahman","shaid hall","12",20)
 insert members values("s00002","said","sak","motherboxhall","4",45)
 insert members values("s00003","pagli","rahman","amirhall","6",34)
 insert members values("s00004","evan","biswas","joha hall","14",5)
 insert members values("s00005","tan","pagol","latif hall","9",12)
 insert members values("s00006","sagor","bada","sm hall","3",4)
 insert members values("s00007","lin","pondit","zia hall","2",29)


create table transactions
(
  tran_id char(10)primary key check(tran_id like "T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"),
  book_id char(10)foreign key references books(book_id),
  member_id char(6)foreign key references members(member_id),
  tran_type char(1)check (tran_type in("i","r")),
  tran_date datetime
)
 
 select *from transactions
 drop table transactions
 
 create proc t1(@desiredavgprice float)
 as
 begin
 select catagory,"noofbooks"=sum(book_qoh),"avg price"=avg(book_price) from books group by catagory having avg(book_price)>=@desiredavgprice
 end
 exec t1 300
 drop proc t1

 create proc t2(@desiredavg_issue_ceiling float)
 as
 begin
 declare @currentavg_issue_ceiling float
 select @currentavg_issue_ceiling=(select avg(issue_ceiling)from members)
 print @currentavg_issue_ceiling
 while(@currentavg_issue_ceiling<=@desiredavg_issue_ceiling)
  begin
  update members set issue_ceiling=issue_ceiling+10
  select @currentavg_issue_ceiling=(select avg(issue_ceiling)from members)
  print @currentavg_issue_ceiling
  end
 end

 exec t2 70

 create trigger  tr1 on transactions for insert
 as
 begin
 declare @tr_type char (1),@tr_id char(10),@bk_id char(10),@mem_id char(6)
 select @tr_type=tran_type,@tr_id=tran_id,@bk_id=book_id,@mem_id=member_id from inserted
 if(@tr_type="i")
  begin
   update books set book_qoh=book_qoh+20 where book_id=@bk_id
   update members set noofcurrentissue=noofcurrentissue+10 where member_id=@mem_id
  end

 else

  begin
   update books set book_qoh=book_qoh-20 where book_id=@bk_id
   update members set noofcurrentissue=noofcurrentissue-10 where member_id=@mem_id
  end
end

 insert transactions values("T000000001","B0001","s00001","i",12-05-08)
 
 select *from members
 select *from books
 select *from transactions