CREATE DEFINER=`root`@`localhost` PROCEDURE `transfers`(in senderId bigint, in recipientId bigint, in money decimal(12,0), out message varchar(255))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SET message = "chuyen tien that bai";
	END;
	START TRANSACTION;
	if not exists(select id from customers where id = senderId) then set message = "tai khoan nguoi gui khong ton tai";
    ROLLBACK;
    elseif not exists(select id from customers where id = recipientId) then set message = "tai khoan nguoi nhan khong ton tai";
    ROLLBACK;
    elseif money > (select balance from customers where id = senderId) then set message = "tai khoan nguoi gui khong du de thuc hien giao dich";
    ROLLBACK;
    else
		update customers set balance = balance - money*1.1 where id = senderId and balance > money*1.1;
        if  ROW_COUNT() = 0 THEN SET message = "chuyen tien that bai";
        rollback;
        else
			update customers set balance = balance + money where id = recipientId;
            if  ROW_COUNT() = 0 THEN  SET message = "chuyen tien that bai";
            rollback;
            else
				insert into transfers(`created_at`, `fees`, `fees_amount`, `transaction_amount`, `transfer_amount`, `recipient_id`, `sender_id`) value(now(), 10, money * 0.1, money * 1.1, money, recipientId, senderId);
				set message = "chuyen tien thanh cong";
			end if;
		end if;
    end if;
    COMMIT;
END