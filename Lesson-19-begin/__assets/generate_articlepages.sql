DELIMITER $$

DROP PROCEDURE IF EXISTS GenerateProperties;
CREATE PROCEDURE GenerateProperties()
BEGIN
    DECLARE i INT;
    DECLARE author INT;
    DECLARE photo INT;
    DECLARE brochure INT;
    SET i = 0;

    WHILE i <= 200 DO
        SET author = FLOOR(RAND() * 3);
        SET photo = FLOOR(RAND() * 2);
        SET brochure = FLOOR(RAND() * 2);
        INSERT INTO SilverStripe_Example_ArticlePage
        VALUES (
            NULL,
            FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) + FLOOR(0 + (RAND() * 31536000))),
            CONCAT('Teaser of sample article ', i + 4),
            CASE author
                WHEN 0 THEN 'Scrooge McDuck'
                WHEN 1 THEN 'John Doe'
                WHEN 2 THEN 'Jane Doe'
                WHEN 3 THEN 'Nathan Drake'
            END,
            CASE photo
                WHEN 0 THEN 3
                WHEN 1 THEN 5
                WHEN 2 THEN 7
            END,
            CASE brochure
                WHEN 0 THEN 4
                WHEN 1 THEN 6
                WHEN 2 THEN 8
            END);

        SET @id = LAST_INSERT_ID();

        INSERT INTO SilverStripe_Example_ArticlePage_Live
        SELECT * FROM SilverStripe_Example_ArticlePage WHERE ID = @id;

        INSERT INTO SilverStripe_Example_ArticlePage_Versions
        SELECT
            NULL,
            ID,
            1,
            NOW(),
            Teaser,
            ArticleAuthor,
            PhotoID,
            BrochureID
          FROM SilverStripe_Example_ArticlePage
        WHERE ID = @id;
        SET i = i + 1;
    END WHILE;
END; $$

DELIMITER ;

CALL GenerateProperties();
DROP PROCEDURE GenerateProperties;