<?php

namespace SilverStripe\Lessons;

use SilverStripe\ORM\PaginatedList;
use SilverStripe\Control\HTTPRequest;
use PageController;

class ArticleHolderController extends PageController
{
    private static $allowed_actions = [
        'category',
        'region',
        'date'
    ];

    protected $articleList;

    protected function init ()
    {
        parent::init();

        $this->articleList = ArticlePage::get()->filter([
            'ParentID' => $this->ID
        ])->sort('Date DESC');
    }

    public function category (HTTPRequest $r)
    {
        $category = ArticleCategory::get()->byID(
            $r->param('ID')
        );

        if(!$category) {
            return $this->httpError(404,'That category was not found');
        }

        $this->articleList = $this->articleList->filter([
            'Categories.ID' => $category->ID
        ]);

        return [
            'SelectedCategory' => $category
        ];
    }

    public function region (HTTPRequest $r)
    {
        $region = Region::get()->byID(
            $r->param('ID')
        );

        if(!$region) {
            return $this->httpError(404,'That region was not found');
        }

        $this->articleList = $this->articleList->filter([
            'RegionID' => $region->ID
        ]);

        return [
            'SelectedRegion' => $region
        ];
    }

    public function PaginatedArticles ($num = 10)
    {
        return PaginatedList::create(
            $this->articleList,
            $this->getRequest()
        )->setPageLength($num);
    }
}
