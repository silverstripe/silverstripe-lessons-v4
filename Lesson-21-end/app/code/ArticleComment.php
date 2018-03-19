<?php

namespace SilverStripe\Lessons;

use SilverStripe\ORM\DataObject;

class ArticleComment extends DataObject
{

    private static $db = [
        'Name' => 'Varchar',
        'Email' => 'Varchar',
        'Comment' => 'Text'
    ];

    private static $has_one = [
        'ArticlePage' => ArticlePage::class,
    ];
}
