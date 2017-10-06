### What we'll cover

*   Creating a DataObject for our $many_many
*   Adding interface for $many_many
*   Pulling the data into the template

### Creating a DataObject for $many_many

Let's turn our focus back to the `ArticlePage` now and see that each article is associated with many categories. We can imagine that in the CMS, we want a list of selectable categories, perhaps checkboxes, that are offered to each article. The first thing we'll need to do is set up a place to manage the categories. There are several different ways you can do this. It really depends on what kind of user experience you want to create, but for now, let's stick them on the ArticleHolder object, so that, conceivably, another `ArticleHolder` page could provide its own set of distinct categories.

#### Managing the ArticleCategory objects

_mysite/code/ArticleHolder.php_

```php
//...
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;

class ArticleHolder extends Page {
    
    //...
    private static $has_many = [
        'Categories' => ArticleCategory::class,
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
```
Next, let's create that `ArticleCategory` object. It's going to be really simple.

_mysite/code/ArticleCategory.php_
```php
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

    public function getCMSFields()
    {
        return FieldList::create(
            TextField::create('Title')
        );
    }
}
```

Notice once again that we have the reciprocal `$has_one` back to the `ArticleHolder`. 

Also take note that we won't use versioning for this DataObject. This is a deliberate decision based on the knowledge that there are no views where all of the categories will be listed. We know that the only way a category will appear on the frontend is when it is associated with an article. So based on that, we don't need to worry about the published state of categories.

Run `dev/build` again and see that we get a new table. Edit the "Travel Guides" page in the CMS and add a few sample categories.

#### Relating Articles to Categories

Now that we have some categories to work with, let's relate them to the articles. Articles have many categories, as we can see on the template, so it's reasonable to assume we'll be using another `$has_many`, right?

In this case, a `$has_many` is not what we want. Remember that reciprocal `$has_one` we used with `$has_many`? That declares that each related object can only belong to one parent. Once that relation is created, it can't be used anywhere else. We don't want that behaviour with categories. Once a category is claimed by an article, it should still be available to other articles. Therefore, articles have many categories, and categories have many articles. This is a `$many_many` relationship.

_mysite/code/ArticlePage.php_

```php
//...
class ArticlePage extends Page {
    //...
    private static $many_many = [
        'Categories' => ArticleCategory::class,
    ];
    //...
}
```

Run `dev/build` and see that we get a new table, `SilverStripe_Lessons_ArticlePage_Categories`.

#### Reciprocating the $many_many

Optional, but strongly recommended is a reciprocation of this relationship on the `ArticleCategory` object, using `$belongs_many_many`. This variable does not create any database mutations, but will provide an magic method to the object for getting its parent records. In this case, we know that we'll need any `ArticleCategory` object to get its articles, because our design includes a filter by category in the sidebar, so this is quite important.

_mysite/code/ArticleCategory.php_
```php
//...
class ArticleCategory extends DataObject {
    //...
    private static $belongs_many_many = [
        'Articles' => ArticlePage::class,
    ];
    //...
}
```

We changed a static variable, so run `?flush`.

#### $many_many vs $belongs_many_many

So if both sides of the relationship have many associated records, how do you know which one gets the `$many_many` and which one is `$belongs_many_many`? Typically, the object that contains the interface gets the `$many_many`. In this case, we'll add categories to the articles using checkboxes, so that's where our `$many_many` goes. Again, the `$belongs_many_many` just provides the convenience of an accessor method for getting the articles from within a category.

### Adding interface for $many_many

Speaking of interface, we need to add some to the `ArticlePage` object. Let's introduce `CheckboxSetField`.

_mysite/code/ArticlePage.php_
```php
//...
use SilverStripe\Forms\CheckboxSetField;

class ArticlePage extends Page {
    //...
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();
        //...
        $fields->addFieldToTab('Root.Categories', CheckboxSetField::create(
            'Categories',
            'Selected categories',
            $this->Parent()->Categories()->map('ID','Title')
        ));
        return $fields;
    }
}
```
Let's take a look at the argument signature of `CheckboxSetField`:

*   **'Categories'**: The name of the `$many_many` relation we're managing.
*   **'Selected categories'**: A label for the checkboxes
*   **$this->Parent()->Categories()**: The categories are stored on the parent `ArticleHolder` page, so we need to invoke `Parent()` first.
*   **->map('ID', 'Title')**: Using the resulting list of categories, create an array that maps each category's ID to its Title. This tells the checkboxes to save the ID to the relation, but present the `Title` field as a label. Note that `Title` can be any public method executable on the object, which is useful if you want a computed value or concatenation of multiple fields. 99% of the time, you will want to use `ID` as the first argument here, as relational data is all held together by unique identifiers.

Go into the CMS and edit an article under "Travel Guides." Check off some categories and make sure they save.

`CheckboxSetField` is a good go-to UI for most `$many_many` relations, but it doesn't scale very well. If we had 100 categories, this wouldn't be a pleasant experience for the user. For larger data sets there is also `ListboxField`, which provides a typeahead UI for associating records without displaying them all at once.

### Pulling the data into the template

Now let's look at adding the comma-separated category list to the articles.

_themes/one-ring/templates/Layout/ArticlePage.ss, line 22_
```html
<li><i class="fa fa-tags"></i> 
     <% loop $Categories %>$Title<% if not $Last %>, <% end_if %><% end_loop %>
</li>
```
We can use the global template variable `$Last` to tell us whether we're in the last iteration of the loop, which will determine whether or not we show the comma. Also available are `$First`, `$Even`, `$Odd`, and many others.

#### Using a custom getter

If we reload the page, this all looks great, but we're not done yet. The categories are also displayed on `ArticleHolder.ss` and `HomePage.ss`. This is a lot of template syntax to keep replicating. We could put this into an include, but it would be better if the `ArticlePage` objects could render a comma-separated list of categories themselves. Let's create a new method that does this.

_mysite/code/ArticlePage.php_
```php
//...
class ArticlePage extends Page {
    //...
    public function CategoriesList()
    {
        if($this->Categories()->exists()) {
            return implode(', ', $this->Categories()->column('Title'));
        }
        
        return null;
    }
}
```

We check the existence of categories with the `exists()` method. Simply checking the result of `Categories()` will not work, because it will at worst return an empty `DataList` object. It will never return false. We use `exists()` to check truthiness.

Invoking `column()` on the list of `ArticleCategory` objects will get an array of all the values for the given column, which saves us the trouble of looping through the list just to get one field.

Now update `HomePage.ss`, `ArticleHolder.ss`, and `ArticlePage.ss` to use the `$CategoriesList` method.

_themes/one-ring/templates/Layout/ArticlePage.ss, line 22_
```html
<li><i class="fa fa-tags"></i> $CategoriesList</li>
```
_themes/one-ring/templates/Layout/ArticleHolder.ss, line 25_
```html
<li><i class="fa fa-tags"></i> $CategoriesList</li>
```
_themes/one-ring/templates/Layout/HomePage.ss, line 289_
```html
<li><i class="fa fa-tags"></i> $CategoriesList</li>
```