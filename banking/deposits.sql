CREATE DEFINER=`root`@`localhost` PROCEDURE `deposits`(in money decimal(12,0), in cusid bigint, out message varchar(225))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET message = "gui tien that bai";
END;
START TRANSACTION;
if (!exists(select id from customers where id= cusId)) then set message = "tai khoan khong ton tai"; 
ROLLBACK;
else
update customers set balance =  balance + money where id= cusId;
if ROW_COUNT() = 0 THEN  
SET message = "gui tien that bai";
rollback;
else
insert into deposits(`created_at`, `customer_id`, `transaction_amount`) value (now(), cusid, money);
set message = "gửi tiền thành công";
end if;
end if;
END
