<?php

namespace {

    use SilverStripe\CMS\Controllers\ContentController;
    use SilverStripe\View\Requirements;

    class PageController extends ContentController
    {
        /**
         * An array of actions that can be accessed via a request. Each array element should be an action name, and the
         * permissions or conditions required to allow the user to access it.
         *
         * <code>
         * [
         *     'action', // anyone can access this action
         *     'action' => true, // same as above
         *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
         *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
         * ];
         * </code>
         *
         * @var array
         */
        private static $allowed_actions = [];

        protected function init()
        {
            parent::init();
            Requirements::themedCSS('css/bootstrap.min.css');
            Requirements::themedCSS('css/style.css');
            Requirements::themedJavascript('javascript/common/modernizr.js');
            Requirements::themedJavascript('javascript/common/jquery-1.11.1.min.js');
            Requirements::themedJavascript('javascript/common/bootstrap.min.js');
            Requirements::themedJavascript('javascript/common/bootstrap-datepicker.js');
            Requirements::themedJavascript('javascript/common/chosen.min.js');
            Requirements::themedJavascript('javascript/common/bootstrap-checkbox.js');
            Requirements::themedJavascript('javascript/common/nice-scroll.js');
            Requirements::themedJavascript('javascript/common/jquery-browser.js');
            Requirements::themedJavascript('javascript/scripts.js');
        }
    }
}
