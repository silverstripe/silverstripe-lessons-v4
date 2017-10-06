UPDATE SilverStripe_Lessons_Property SET AvailableStart = FROM_UNIXTIME(
        UNIX_TIMESTAMP(NOW()) + FLOOR(0 + (RAND() * 31536000))
);
UPDATE SilverStripe_Lessons_Property SET AvailableEnd = FROM_UNIXTIME(
        UNIX_TIMESTAMP(AvailableStart) + FLOOR(1 + (RAND() * 1209600))
);

UPDATE SilverStripe_Lessons_Property_Live SET AvailableStart = (
  SELECT AvailableStart
    FROM SilverStripe_Lessons_Property
    WHERE
      SilverStripe_Lessons_Property.ID = SilverStripe_Lessons_Property_Live.ID
);
UPDATE SilverStripe_Lessons_Property_Live SET AvailableEnd = (
  SELECT AvailableEnd
    FROM SilverStripe_Lessons_Property
    WHERE
      SilverStripe_Lessons_Property.ID = SilverStripe_Lessons_Property_Live.ID
);
