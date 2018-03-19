<?php

namespace SilverStripe\Lessons;

use SilverStripe\ORM\DataObject;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;

class ArticleCategory extends DataObject {

    private static $db = [
        'Title' => 'Varchar',
    ];

    private static $has_one = [
        'ArticleHolder' => ArticleHolder::class,
    ];

    private static $belongs_many_many = [
        'Articles' => ArticlePage::class,
    ];

    public function getCMSFields()
    {
        return FieldList::create(
            TextField::create('Title')
        );
    }
}
