CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `transfersview` AS
    SELECT 
        `t`.`id` AS `id`,
        `t`.`sender_id` AS `sender_id`,
        `c1`.`full_name` AS `sender_name`,
        `t`.`recipient_id` AS `recipient_id`,
        `c2`.`full_name` AS `recipient_name`,
        `t`.`fees` AS `fees`,
        `t`.`fees_amount` AS `fees_amount`,
        `t`.`transaction_amount` AS `transaction_amount`,
        `t`.`transfer_amount` AS `transfer_amount`,
        `t`.`created_at` AS `created_at`
    FROM
        ((`transfers` `t`
        JOIN `customers` `c1` ON ((`c1`.`id` = `t`.`sender_id`)))
        JOIN `customers` `c2` ON ((`c2`.`id` = `t`.`recipient_id`)))