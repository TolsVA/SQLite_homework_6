-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP FUNCTION date_form;

DELIMITER $$
CREATE FUNCTION date_form(ms INT)
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
	DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    DECLARE temp INT DEFAULT 60 * 60 * 24;
    DECLARE res VARCHAR(45) DEFAULT '';
    
    IF ms = 0 THEN
        SET res = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
	ELSE
		WHILE ms > temp DO
			SET days = days + 1;
            SET ms = ms - temp;
		END WHILE;
        SET temp = temp / 24;
		WHILE ms > temp DO
			SET hours = hours + 1;
            SET ms = ms - temp;
		END WHILE;
        SET temp = temp / 60;
        WHILE ms > temp DO
			SET minutes = minutes + 1;
            SET ms = ms - temp;
		END WHILE;
        SET seconds = ms;
		SET res = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
    END IF;
	RETURN res;
END $$
DELIMITER ;

SELECT date_form(123456);

-- 2. Выведите только чётные числа от 1 до 10. Пример: 2,4,6,8,10
DROP PROCEDURE show_even;

DELIMITER $$ 
CREATE PROCEDURE show_even(from_number INT, to_number INT)
BEGIN
	DECLARE res VARCHAR(100) DEFAULT '';
    DECLARE counter INT DEFAULT 0;
    IF from_number > to_number THEN 
		SET res = 'Не верный диапазон первое число не может быть больше второго';
    ELSE 
		WHILE from_number = to_number OR from_number < to_number DO
			IF to_number % 2 = 0 THEN
				SET counter = counter + 1;
                IF counter = 1 THEN 
					SET res = CONCAT(to_number);
                ELSE 
					SET res = CONCAT(to_number, ', ', res);
                END IF;
            END IF;
            SET to_number = to_number - 1;
		END WHILE;
    END IF;
    SELECT res;
END $$
DELIMITER ;

CALL show_even(-5, 5);

