UPDATE SilverStripe_Example_ArticlePage SET
    RegionID = FLOOR(RAND() * (SELECT COUNT(*) FROM SilverStripe_Example_Region)) + 1;

UPDATE SilverStripe_Example_ArticlePage_Live
    SET RegionID = (
        SELECT RegionID
          FROM SilverStripe_Example_ArticlePage
         WHERE
            SilverStripe_Example_ArticlePage.ID = SilverStripe_Example_ArticlePage_Live.ID
    );

UPDATE SilverStripe_Example_ArticlePage_Versions SET
    RegionID = (
        SELECT RegionID
          FROM SilverStripe_Example_ArticlePage
         WHERE
            SilverStripe_Example_ArticlePage.ID = RecordID
    )
WHERE
    Version = (
        SELECT MAX(Version)
          FROM (SELECT RecordID "Rec", Version FROM SilverStripe_Example_ArticlePage_Versions) AS v
         WHERE Rec = RecordID
    );