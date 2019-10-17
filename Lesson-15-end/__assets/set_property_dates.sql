UPDATE SilverStripe_Example_Property SET AvailableStart = FROM_UNIXTIME(
        UNIX_TIMESTAMP(NOW()) + FLOOR(0 + (RAND() * 31536000))
);
UPDATE SilverStripe_Example_Property SET AvailableEnd = FROM_UNIXTIME(
        UNIX_TIMESTAMP(AvailableStart) + FLOOR(1 + (RAND() * 1209600))
);

UPDATE SilverStripe_Example_Property_Live SET
  AvailableStart = (
    SELECT AvailableStart
      FROM SilverStripe_Example_Property
     WHERE
        SilverStripe_Example_Property.ID = SilverStripe_Example_Property_Live.ID
  ),
  AvailableEnd = (
  SELECT AvailableEnd
    FROM SilverStripe_Example_Property
   WHERE
      SilverStripe_Example_Property.ID = SilverStripe_Example_Property_Live.ID
  );

UPDATE SilverStripe_Example_Property_Versions SET
  AvailableStart = (
    SELECT AvailableStart
      FROM SilverStripe_Example_Property
     WHERE
        SilverStripe_Example_Property.ID = RecordID
  ),
  AvailableEnd = (
  SELECT AvailableEnd
    FROM SilverStripe_Example_Property
   WHERE
      SilverStripe_Example_Property.ID = RecordID
  )
WHERE
  Version = (
    SELECT MAX(Version)
      FROM (SELECT  RecordID "Rec", Version FROM SilverStripe_Example_Property_Versions) AS v
     WHERE Rec = RecordID
  );