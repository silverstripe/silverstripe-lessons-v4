<?php

namespace SilverStripe\Example;

use Page;
use SilverStripe\Forms\DateField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\TextField;

class ArticlePage extends Page
{
    private static $db = [
        'Date' => 'Date',
        'Teaser' => 'Text',
        'Author' => 'Varchar',
    ];

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->addFieldToTab('Root.Main', DateField::create('Date','Date of article'), 'Content');
        $fields->addFieldToTab('Root.Main', TextareaField::create('Teaser')
            ->setDescription('This is the summary that appears on the article list page.'),
            'Content'
        );
        $fields->addFieldToTab('Root.Main', TextField::create('Author','Author of article'),'Content');
        return $fields;
    }
}
