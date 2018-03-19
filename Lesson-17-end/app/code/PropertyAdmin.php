<?php

namespace SilverStripe\Lessons;

use SilverStripe\Admin\ModelAdmin;

class PropertyAdmin extends ModelAdmin
{

    private static $menu_title = 'Properties';

    private static $url_segment = 'properties';

    private static $managed_models = [
        Property::class,
    ];

    private static $menu_icon = 'mysite/icons/property.png';
}
