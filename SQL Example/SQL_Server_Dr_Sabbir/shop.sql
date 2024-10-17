create database shops
use shops
create table customers
(
cu_id char(6) primary key check(cu_id like "c[a-z][0-9][0-9][0-9][0-9]"),
cu_fname char(15) not null,
cu_lname varchar(15) ,
cu_address text,
cu_telno char(12) check(cu_telno like "[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"),
cu_city char(12)default "Rajshahi",
sales_amnt money check(sales_amnt>0)
)
drop table customers
insert customers values("ca0001","Ashraful","Haque","356 Suharawardi","017-24666730","jassor",10000)
insert customers values("ca0002","Rafiqul","Islam","378 Suharawardi","017-38593820","jassor",50000)
insert customers values("ca0003","Sifur","Rahman","322 Suharawardi","017-23536730","chuadanga",60000)
insert customers values("ca0004","Nayan","Hasan","447 Mother box","017-54656853","chuadanga",90000)
insert customers values("ca0005","Abul","Hasan","Amir Ali","017-34545320","Rajshahi",40000)
insert customers values("ca0006","Selim","Reza","S.M","017-26766730","Chapi",40000)
insert customers values("ca0007","Selina","Akter","Munnujan","017-16172325","Chuadanga",20000)
insert customers values("ca0008","Sakir","Hosan","Lathif","017-45436730","Rajshahi",100000)
insert customers values("ca0009","Fuad","Khan","Possim Para","017-23266730","Rajshahi",80000)
insert customers values("ca0010","Julfiker","Ali","NASA","987-56326730","Rajshahi",90000000)
select *from customers
delete from customers
create table items
(
item_id char(10) primary key check(item_id like "[a-z][0-9][0-9][0-9][0-9]"),
item_name char(12),
item_price float check(item_price>0),
item_qoh int check(item_qoh>0),
item_last_sold datetime
)
drop table items
insert items values("a0001","computer",3000,23,19-04-2008)
insert items values("a0002","Monitor",5000,30,19-04-2008)
insert items values("a0003","Sperer",2000,20,19-04-2008)
insert items values("a0004","Harddisk",3000,23,19-04-2008)
insert items values("a0005","RAM",1000,23,19-04-2008)
insert items values("a0006","Keybord",4000,25,19-04-2008)
insert items values("a0007","Mause",1000,100,19-04-2008)
insert items values("a0008","pendrive",5000,50,19-04-2008)
insert items values("a0009","Motherbord",6000,22,19-04-2008)
insert items values("a0010","CPU",4000,10,19-04-2008)
select *from items
delete from items
create table transactions
(
tran_id char(10) primary key check(tran_id like "T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"),
item_id char(10) foreign key references items(item_id),
cust_id char(6) foreign key references customers(cu_id),
tran_type char(1)check(tran_type in("s","o")),
tran_quantity int check(tran_quantity>0),
tran_date datetime
)
insert transactions values("T000000001","a0001","ca0001","s",2,19-04-2008)
insert transactions values("T000000002","a0001","ca0002","s",10,19-04-2008)
insert transactions values("T000000003","a0003","ca0003","s",100,19-04-2008)
insert transactions values("T000000004","a0003","ca0004","s",50,19-04-2008)
insert transactions values("T000000005","a0006","ca0007","s",80,19-04-2008)
insert transactions values("T000000006","a0006","ca0006","s",32,19-04-2008)
insert transactions values("T000000007","a0004","ca0001","s",12,19-04-2008)
insert transactions values("T000000008","a0005","ca0002","s",22,19-04-2008)
insert transactions values("T000000009","a0007","ca0008","s",25,19-04-2008)
insert transactions values("T000000010","a0008","ca0009","s",29,19-04-2008)
insert transactions values("T000000011","a0009","ca0009","s",30,19-04-2008)
insert transactions values("T000000012","a00010","ca0005","s",33,19-04-2008)
insert transactions values("T000000013","a00010","ca00010","s",72,19-04-2008)
insert transactions values("T000000014","a0004","ca0005","s",23,19-04-2008)
insert transactions values("T000000015","a0007","ca0003","s",20,19-04-2008)
delete from transactions
select *from transactions
drop table transactions

select cu_fname from customers where cu_city="Rajshahi"

select "Customers first name"=cu_fname from customers where cu_city="Rajshahi"


delete transactions where cust_id="ca0001"

update transactions set tran_quantity=7 where tran_id="T000000001"

select "Customers first name"=cu_fname from customers where 
cu_id=(select cust_id from transactions where tran_id="T000000005")

select "Customers first name"=cu_fname from customers where 
cu_id in(select cust_id from transactions where tran_quantity>50)

select "Customers first name"=cu_fname from customers where 
cu_id in(select cust_id from transactions)
 
select "Customers first name"=cu_fname from customers join transactions 
on customers.cu_id=transactions.cust_id

select distinct "Customers first name"=cu_fname from customers join transactions 
on customers.cu_id=transactions.cust_id

select "customers city"=cu_city,"no. of customers"=count(cu_city),"total sold"=sum(sales_amnt) 
from customers group by cu_city 
select "customers city"=cu_city,"no. of customers"=count(cu_city),"total sold"=sum(sales_amnt) 
from customers group by cu_city having sales_amnt>20000
 
select "Customers first name"=cu_fname,item_name,tran_quantity from customers join transactions 
on customers.cu_id=transactions.cust_id join items on items.item_id=transactions.item_id

create proc test1(@city char(10)) 
As
begin
select * from customers where cu_city=@city
end

exec test1 'rajshahi'

create proc test2(@desiredavg float)
As
begin
declare @currentavgprice float
select @currentavgprice= (select avg(item_price) from items)
print @currentavgprice
while(@currentavgprice<=@desiredavg)
begin
update items set item_price=item_price+100
set @currentavgprice=(select avg(item_price) from items)
print @currentavgprice
end
end
drop proc test2

exec test2 4000.0


create trigger trg_transactions on transactions for insert
 as
   begin
     declare @tr_type char(1),@it_id char(10),@tr_quan int,@item_qh int
     select @tr_type=tran_type,@it_id=item_id,@tr_quan=tran_quantity from inserted
     select @item_qh=item_qoh from items where item_id=@it_id
     if(@item_qh-@tr_quan>0)
        begin
          if(@tr_type='s')
            begin
              update items set item_qoh=item_qoh-@tr_quan where item_id=@it_id
            end
          else
             update items set item_qoh=item_qoh+@tr_quan where item_id=@it_id
        end
    else
        print('Sorry there are not available for selse')
  end
drop trigger trg_transactions

insert transactions values("T000000019","a0008","ca0010","s",20,19-04-2008)




