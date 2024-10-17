create database porna
use porna


create table customer
(
  cu_id char (6)primary key check(cu_id like "c[a-z][0-9][0-9][0-9][0-9]"),
  cu_fname char(15) not null,
  cu_lname varchar(15),
  cu_address text,
  cu_telno char(12)check(cu_telno like "[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"),
  cu_city char(12) default 'Rajshahi',
  sales_amnt money check(sales_amnt>=0)
)

select *from customer
drop table customer
  insert customer values ("ca0001","tulu","sak","motherbox","017-22225547","Dhaka",1000)
  insert customer values ("ca0002","mony","sak","sorowardy","017-11225547","Fhaka",2000)
  insert customer values ("ca0003","eva","sak","motherbox","017-33335547","khulna",4000)
  insert customer values ("ca0004","janu","sak","amir","017-44445547","vula",6000)
  insert customer values ("ca0005","mana","sak","Hobibur","019-46225547","Dhaka",9000)
  insert customer values ("ca0006","kana","sak","latif","017-22225547","chittagong",7000)
  insert customer values ("ca0007","bana","sak","joha","017-22225547","Rangpur",5000)
  insert customer values ("ca0008","farid","sak","Zia","017-22225547","sylet",10000)


create table item

(
  item_id char(6)primary key check(item_id like "[a-z][0-9][0-9][0-9][0-9]"),
  item_name char(12),
  item_price float(12)check(item_price>=0),
  item_qoh int check(item_qoh>=0),
  item_last_sold datetime
)

  select *from item

  insert item values("a0001","ram","1000","12",12-5-08)
  insert item values("a0002","cd","2000","5",13-5-08)
  insert item values("a0003","dvd","5000","13",17-5-08)
  insert item values("a0004","hdd","10000","56",1-5-08)
  insert item values("a0005","processor","6000","9",12-5-08)
  insert item values("a0006","battery","500","34",6-5-08)
  insert item values("a0007","fan","2000","22",10-5-08)
  insert item values("a0008","glass","100","10",11-5-08)
  insert item values("a0009","mobile","12000","15",18-5-08)


create table transactions

(
  tran_id char(10)primary key check(tran_id like"T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"),
  item_id char (6) foreign key references item(item_id),
  cust_id char(6) foreign key references customer(cu_id),
  tran_type char(1)check(tran_type in("s","o")), 
  tran_quantity int check(tran_quantity>=0),
  tran_date datetime
)

drop table transactions
select *from transactions

insert transactions values("T000000001","a0001","ca0001","s","12",12-06-08)
insert transactions values("T000000002","a0001","ca0001","s","12",12-06-08)
insert transactions values("T000000003","a0001","ca0001","s","12",12-06-08)
insert transactions values("T000000004","a0001","ca0001","s","12",12-06-08)
insert transactions values("T000000005","a0001","ca0001","s","12",12-06-08)
insert transactions values("T000000006","a0001","ca0001","s","12",12-06-08)



create proc test3
as
begin
  select "customer city"=cu_city,"no of customer"=count(cu_city),"Total Sold"=sum(sales_amnt) from customers group by cu_city
end
exec test3

create proc test4(@desiredavgprice float)
as
begin
  declare @currentavgprice float
  select @currentavgprice=(select avg(item_price)from item)
  print @currentavgprice
  while
    (@currentavgprice<=@desiredavgprice)
      begin
        update item set item_price=item_price+100
          select @currentavgprice=(select avg(item_price)from item)
          print @currentavgprice
      end
end
exec test4 6000


 create trigger trg2 on transactions for insert

  as
  begin
     declare @tr_type char(1),@tr_quan int,@it_id char(6),@item_pri float,@item_qh int,@c_id char(6)

   select
        @tr_type=tran_type,@tr_quan=tran_quantity,@it_id=item_id,@c_id=cust_id from inserted

   select @item_qh=item_qoh from item where item_id=@it_id
   select @item_pri=item_price from item where  item_id=@it_id

    if(@tr_type='s')
     begin
        update item set item_qoh=item_qoh - @tr_quan where item_id=@it_id
     end
    else
     begin
      update item set item_qoh=item_qoh+@tr_quan where item_id=@it_id
     end
end

  insert transactions values("T000000005","a0001","ca0001","s","12",12-06-08)
