create database pagli
use pagli

create table customers

(

  cu_id char(6)primary key check(cu_id like "c[a-z][0-9][0-9][0-9][0-9]"),
  cu_fname char(15)not null,
  cu_lname varchar(15),
  cu_address text,
  cu_telno char(12)check(cu_telno like "[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"),
  cu_city char(12)default "Rahshahi",
  sales_amnt money check(sales_amnt>=0),
  order_amnt money check(order_amnt>=0)
)

drop table customers
select *from customers

insert customers values("ca0001","saifur","Rahman","kajla","017-22225547","Rajshahi","1000",10)
insert customers values("ca0002","saif","Rahman","danmondi","017-11225547","commila","4000",10)
insert customers values("ca0003","Raifur","Rahman","gulshan","017-55225547","khulna","6000",10)
insert customers values("ca0004","Daifur","Rahman","polashpara","017-99225547","jessore","2000",10)
insert customers values("ca0005","fur","Rahman","kajla","019-00225547","Ranpur","2000",10)
insert customers values("ca0006","rony","Rahman","motherbox","018-22220547","Rajshahi","9000",10)



select *from items
create table items

(
  item_id char(6)primary key check(item_id like "[a-z][0-9][0-9][0-9][0-9]"),
  item_name char(12),
  item_price float(12)check(item_price>=0),
  item_qoh int check(item_qoh>0),
  item_last_sold datetime
)
drop table items
insert items values("a0001","CPU","1000","10",19-5-08)
insert items values("a0002","Ram","5000","5",23-5-08)
insert items values("a0003","HDD","10000","30",12-5-08)
insert items values("a0004","CDROM","500","50",11-5-08)
insert items values("a0005","DVD","1000","60",09-5-08)
insert items values("a0006","processor","2000","70",23-5-08)





select *from transactions
create table transactions

(
  tran_id char(10)primary key check(tran_id like "T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9[0-9]"),
  item_id char(6) foreign key references items (item_id),
  cust_id char(6) foreign key references customers(cu_id),
  tran_type char(1) check(tran_type in("s","o")),
  tran_quantity int check(tran_quantity>0),
  tran_date datetime
)

drop table transactions

insert transactions values("T000000001","a0001","ca0001","s",2,19-04-2008)
insert transactions values("T000000002","a0001","ca0002","s",10,19-04-2008)
insert transactions values("T000000003","a0003","ca0003","s",100,19-04-2008)
insert transactions values("T000000004","a0003","ca0004","s",50,19-04-2008)
insert transactions values("T000000005","a0006","ca0007","s",80,19-04-2008)
insert transactions values("T000000006","a0006","ca0006","s",32,19-04-2008)
insert transactions values("T000000007","a0004","ca0001","s",12,19-04-2008)