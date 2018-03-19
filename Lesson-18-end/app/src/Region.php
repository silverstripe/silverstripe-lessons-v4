<?php

namespace SilverStripe\Lessons;

use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Versioned\Versioned;
use SilverStripe\Control\Controller;

class Region extends DataObject
{

    private static $db = [
        'Title' => 'Varchar',
        'Description' => 'HTMLText',
    ];

    private static $has_one = [
        'Photo' => Image::class,
        'RegionsPage' => RegionsPage::class,
    ];

    private static $summary_fields = [
        'GridThumbnail' => '',
        'Title' => 'Title',
        'Description' => 'Description'
    ];

    private static $owns = [
        'Photo',
    ];

    private static $extensions = [
        Versioned::class,
    ];

    private static $versioned_gridfield_extensions = true;

    public function getGridThumbnail()
    {
        if($this->Photo()->exists()) {
            return $this->Photo()->ScaleWidth(100);
        }

        return "(no image)";
    }

    public function getCMSFields()
    {
        $fields = FieldList::create(
            TextField::create('Title'),
            HtmlEditorField::create('Description'),
            $uploader = UploadField::create('Photo')
        );

        $uploader->setFolderName('region-photos');
        $uploader->getValidator()->setAllowedExtensions(['png','gif','jpeg','jpg']);

        return $fields;
    }

    public function Link()
    {
        return $this->RegionsPage()->Link('show/'.$this->ID);
    }

    public function LinkingMode()
    {
        return Controller::curr()->getRequest()->param('ID') == $this->ID ? 'current' : 'link';
    }

}
