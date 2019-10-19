DELIMITER $$

DROP PROCEDURE IF EXISTS GenerateProperties;
CREATE PROCEDURE GenerateProperties()
BEGIN
    DECLARE i INT;
    SET i = 0;

    WHILE i <= 200 DO
        INSERT INTO SilverStripe_Example_Property
        VALUES (
            NULL,
            'SilverStripe\\Example\\Property',
            NOW(),
            NOW(),
            1,
            CONCAT('Property ', i + 1),
            RAND() * (3000 - 50) + 50,
            (FLOOR(RAND() * (10 - 1)) + 1),
            (FLOOR(RAND() * (10 - 1)) + 1),
            0,
            (FLOOR(RAND() * (4 - 1)) + 1),
            (FLOOR(RAND() * (20 - 15)) + 15),
            NULL,
            NULL,
            CONCAT('Description of Property ', i + 1));

        SET @id = LAST_INSERT_ID();

        INSERT INTO SilverStripe_Example_Property_Live
        SELECT * FROM SilverStripe_Example_Property WHERE ID = @id;

        INSERT INTO SilverStripe_Example_Property_Versions
        SELECT
            NULL,
            ID,
            Version,
            1,
            0,
            0,
            1,
            1,
            ClassName,
            LastEdited,
            Created,
            Title,
            PricePerNight,
            Bedrooms,
            Bathrooms,
            FeaturedOnHomepage,
            RegionID,
            PrimaryPhotoID,
            AvailableStart,
            AvailableEnd,
            Description
          FROM SilverStripe_Example_Property
        WHERE ID = @id;
        SET i = i + 1;
    END WHILE;
END; $$

DELIMITER ;

CALL GenerateProperties();
DROP PROCEDURE GenerateProperties;