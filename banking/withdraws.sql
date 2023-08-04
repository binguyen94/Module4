CREATE DEFINER=`root`@`localhost` PROCEDURE `withdraws`(in money decimal(12,0), in cusID bigint, out message varchar(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET message = "rut tien that bai";
END;
START TRANSACTION;
if NOT exists(select id from customers where id= cusId) then set message = "tai khoan khong ton tai";
ROLLBACK;
elseif money > (select balance from customers where id = cusId) then set message = "tai khoan khong du de thuc hien giao dịch";
ROLLBACK;
else
update customers set balance = balance - money where id = cusId and balance >= money;
if  ROW_COUNT() = 0 then SET message = "rut tien that bai";
rollback;
else
insert into withdraws (`created_at", "customer_id`, `transaction_amount`) value (now(), cusId, money);
set message = "rut tien thanh cong";
end if;
end if;
commit;
End