<?php

namespace SilverStripe\Example;

use Page;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;

class ArticleHolder extends Page
{
    private static $allowed_children = [
        ArticlePage::class
    ];

    private static $has_many = [
        'Categories' => ArticleCategory::class
    ];

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields->addFieldToTab('Root.Categories', GridField::create(
            'Categories',
            'Article categories',
            $this->Categories(),
            GridFieldConfig_RecordEditor::create()
        ));

        return $fields;
    }
}
