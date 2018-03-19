<?php

use SilverStripe\CMS\Controllers\ContentController;

use SilverStripe\View\Requirements;

class PageController extends ContentController
{
    /**
     * An array of actions that can be accessed via a request. Each array element should be an action name, and the
     * permissions or conditions required to allow the user to access it.
     *
     * <code>
     * array (
     *     'action', // anyone can access this action
     *     'action' => true, // same as above
     *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
     *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
     * );
     * </code>
     *
     * @var array
     */
    private static $allowed_actions = array(

    );

    protected function init()
    {
        parent::init();
        Requirements::themedCSS("bootstrap.min");
        Requirements::themedCSS("style");
        Requirements::themedJavascript("common/modernizr");
        Requirements::themedJavascript("common/jquery-1.11.1.min");
        Requirements::themedJavascript("common/bootstrap.min");
        Requirements::themedJavascript("common/bootstrap-datepicker");
        Requirements::themedJavascript("common/chosen.min");
        Requirements::themedJavascript("common/bootstrap-checkbox");
        Requirements::themedJavascript("common/nice-scroll");
        Requirements::themedJavascript("common/jquery-browser");
        Requirements::themedJavascript("scripts");
    }
}