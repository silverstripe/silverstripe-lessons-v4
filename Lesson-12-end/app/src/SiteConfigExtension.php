<?php

namespace SilverStripe\Example;

use SilverStripe\ORM\DataExtension;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\TextareaField;

class SiteConfigExtension extends DataExtension
{
    private static $db = [
        'FacebookLink' => 'Varchar',
        'TwitterLink' => 'Varchar',
        'YouTubeLink' => 'Varchar'
    ];

    public function updateCMSFields(FieldList $fields)
    {
        $fields->addFieldsToTab('Root.Social', array(
            TextField::create('FacebookLink','Facebook'),
            TextField::create('TwitterLink','Twitter'),
            TextField::create('YouTubeLink','YouTube')
        ));
    }
}
