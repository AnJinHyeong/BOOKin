create view cart_view as
select
    B.book_no, B.book_title, B.book_image, B.book_author, B.book_price, B.book_discount,
    C.cart_no, C.cart_amount, C.cart_time, C.member_no
from book B
     inner join cart C on B.book_no = C.book_no;

select * from cart_view;