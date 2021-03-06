DROP TRIGGER RENTS_INSERT;

DELIMITER $$

CREATE TRIGGER RENTS_INSERT AFTER INSERT ON RENTS
FOR EACH ROW
BEGIN 
	insert into RENTS_AUD (EVENT_DATE, EVENT_TYPE, RENT_ID, NEW_BOOK_ID, NEW_READER_ID, NEW_RENT_DATE, NEW_RETURN_DATE)
			VALUES (CURTIME(), "INSERT", NEW.RENT_ID, NEW.BOOK_ID, NEW.READER_ID,
					NEW.RENT_DATE, NEW.RETURN_DATE);
END $$

DELIMITER ;

SELECT * FROM kodilla_course.rents_aud;

INSERT INTO RENTS (BOOK_ID, READER_ID, RENT_DATE, RETURN_DATE)
		VALUES (2, 4, CURDATE()-7, NULL);
        
COMMIT;


DELIMITER $$

CREATE TRIGGER RENTS_DELETE AFTER DELETE ON RENTS
FOR EACH ROW
BEGIN 
	insert into RENTS_AUD (EVENT_DATE, EVENT_TYPE, RENT_ID)
			VALUES (CURTIME(), "DELETE", OLD.RENT_ID);
END $$

DELIMITER ;

DELETE FROM RENTS WHERE RENT_ID = 3;

COMMIT;



DELIMITER $$

CREATE TRIGGER RENTS_UPDATE AFTER UPDATE ON RENTS
FOR EACH ROW
BEGIN 
	insert into RENTS_AUD (EVENT_DATE, EVENT_TYPE, RENT_ID, NEW_BOOK_ID, NEW_READER_ID, NEW_RENT_DATE, NEW_RETURN_DATE,
							OLD_BOOK_ID, OLD_READER_ID, OLD_RENT_DATE, OLD_RETURN_DATE)
			VALUES (CURTIME(), "UPDATE", OLD.RENT_ID, NEW.BOOK_ID, NEW.READER_ID,
					NEW.RENT_DATE, NEW.RETURN_DATE, OLD.BOOK_ID, OLD.READER_ID, OLD.RENT_DATE, OLD.RETURN_DATE);
END $$

DELIMITER ;

UPDATE  RENTS SET RETURN_DATE = CURDATE()
WHERE RENT_ID = 12;

COMMIT;












