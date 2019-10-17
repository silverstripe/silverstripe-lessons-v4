<?php

namespace SilverStripe\Example;

use PageController;    

class HomePageController extends PageController 
{
    public function LatestArticles($count = 3)
    {
        return ArticlePage::get()
            ->sort('Created', 'DESC')
            ->limit($count);
    }
}
