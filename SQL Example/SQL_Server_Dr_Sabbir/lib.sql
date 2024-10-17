create database library
use library

create table books
(
  book_id char(6)primary key check(book_id like "B[0-9][0-9][0-9][0-9]"),
  book_title char(15)not null,
  auther char(15)not null,
  catagory char(4)check(catagory in("tech","busi","arts")),
  book_price float check(book_price>=0),
  book_qoh int check(book_qoh>=0),
)