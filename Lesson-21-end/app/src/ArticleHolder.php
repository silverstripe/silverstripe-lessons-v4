<?php

namespace SilverStripe\Example;

use Page;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Versioned\Versioned;
use SilverStripe\View\ArrayData;
use SilverStripe\ORM\Queries\SQLSelect;

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

    public function ArchiveDates()
    {
        $list = ArrayList::create();
        $stage = Versioned::get_stage();
        $baseTable = ArticlePage::getSchema()->tableName(ArticlePage::class);
        $tableName = $stage === Versioned::LIVE ? "{$baseTable}_Live" : $baseTable;

        $query = SQLSelect::create()
            ->setSelect([])
            ->selectField("DATE_FORMAT(`Date`,'%Y_%M_%m')", "DateString")
            ->setFrom($tableName)
            ->setOrderBy("DateString", "ASC")
            ->setDistinct(true);

        $result = $query->execute();

        if ($result) {
            foreach($result as $record) {
                list($year, $monthName, $monthNumber) = explode('_', $record['DateString']);

                $list->push(ArrayData::create([
                    'Year' => $year,
                    'MonthName' => $monthName,
                    'MonthNumber' => $monthNumber,
                    'Link' => $this->Link("date/$year/$monthNumber"),
                    'ArticleCount' => ArticlePage::get()->where([
                            "DATE_FORMAT(\"Date\",'%Y_%m')" => "{$year}_{$monthNumber}",
                            "\"ParentID\"" => $this->ID
                        ])->count()
                ]));
            }
        }

        return $list;
    }

    public function Regions()
    {
        $page = RegionsPage::get()->first();

        if ($page) {
            return $page->Regions();
        }
    }
}
