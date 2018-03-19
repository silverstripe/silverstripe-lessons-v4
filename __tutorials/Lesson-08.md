The ORM provides a layer of abstraction between your PHP code and the contents of the database. Any time you're reading or manipulating records, the ORM is most likely going to be involved.

### ORM Basics

Here's an easy way to conceptualise the ORM:

*   **Classes** refer to tables
*   **Instances** of classes refer to records
*   **Properties** of objects refer to columns

For a class to follow this paradigm, it must be a descendant of `SilverStripe\ORM\DataObject`. So far, we've been dealing only with subclasses of `Page`, which is itself a DataObject (SilverStripe\ORM\DataObject -> SilverStripe\CMS\Model\SiteTree -> Page). For generic data types that do not need page functionality, you can go further up the inheritance chain and simply subclass DataObject directly. We'll be talking a lot more about non-page database content in the next tutorial.

### Dealing with individual records

Let's imagine we have the following simple DataObject class:

```php
use SilverStripe\ORM\DataObject;

class Product extends DataObject 
{
    private static $db = [
      'Title' => 'Varchar(100)',
      'Price' => 'Currency',
    ];
 }
```

The DataObject class gives us four properties to start with:

*   **ID** - primary key
*   **ClassName** - a hint to ORM what class should be created for the record. In this case its default value is “Product.”
*   **Created** - a timestamp of when the record was stored in the database first time
*   **LastEdited** - a timestamp that is updated every time the record is written to the database.

In adherence to the ORM pattern, creating a record is as simple as creating an instance of your DataObject subclass.

```php
    $product = Product::create();
```

Keep in mind that DataObjects do not optimistically write to the database.

```php
    echo $product->ID; // 0
```

In order to persist the record, we need to invoke its `write()` method.

```php
    $product->write();
    echo $product->ID; // 442
```

For convenience, the `write()` method returns the record's ID.

```php
    echo Product::create()->write(); // 443
```

Further, the `create()` method can populate the object with data if passed an array.

```php
    $product = Product::create(['Title' => 'My first product']);
```

To delete a record, call `delete()`.

```php
    $product->delete();echo $product->ID; // 0
```

To update it, just modify the properties of the object, then invoke `write()`.

```php
    $product->Price = 2.49;
    $product->write();
```

This should all feel very natural once you become acquainted with it.

### Dealing with aggregate data

ORMs are essentially just APIs for writing SQL queries. If you've ever worked on a project where SQL was written inline with PHP code, you probably don't have to struggle to see the value in such a tool. In general, database queries and controller/view logic do not mix. We try to avoid this as much as we can, as it can become really redundant. Just look at how much repetition exists between these three queries:

```php
$sql = “SELECT ID, Created, LastEdited, Title, Price FROM Product”;

$sql = “SELECT ID, Created, LastEdited, Title, Price FROM Product WHERE Price > 100”;

$sql = “SELECT ID, Created, LastEdited, Title, Price FROM Product WHERE Price > 100 LIMIT 5”;
```

On top of that, you need to deal with the boilerplate of suppressing SQL injection and other foundational elements of database integration. Further, if you ever change database platform, the code doesn't ship well.

You might create helper functions to assemble queries like this, but ultimately, this approach doesn't scale. Frameworks unanimously prefer to hand off database all database work to its own layer.

Because database queries are about lists of records, not individual records, the methods we're going to use are all scoped to the class definition. As stated before, a class is essentially a reference to a table, so this should make sense. In object-oriented programing, methods invoked not against an instance of a class, but rather the class itself, are referred to as **static methods**. Let's take a look at how this works.

First, we'll get all of our products.

```php
$products = Product::get();
```

Now, let's get all products that cost $100.

```php
$products = Product::get()->filter([
  'Price' => 100
)];
```

Now, let's get the top five most expensive products under $100:

```php
$products = Product::get()
               ->filter([
                 'Price:LessThan' => 100
               ])
               ->sort('Price','DESC')
               ->limit(5);
```
As you can see, all these methods are chainable, with one important caveat: they are immutable. That means that each one of these methods returns a new list. Once you store the list in a variable, you cannot update it. You can only overwrite the previous variable.

```php
$products = Product::get();
$products->limit(5);

echo $products->sql(); // does not contain a limit clause
```

> Note: the `sql()` method is rarely needed. It is typically only used for debugging.`

This is a very common mistake that people make with the ORM. If we were writing jQuery, the above approach would have applied both methods to the instance, but the ORM does not follow that pattern. [Immutable data structures](http://en.wikipedia.org/wiki/Persistent_data_structure) are becoming increasingly more common in web frameworks.

Let's update that code so that both clauses apply.

```php
$products = Product::get()->sort('Price', 'DESC');
$products = $products->limit(5);

echo $products->sql(); // contains a sort clause and a limit clause
```

Notice that we can either chain the methods on creation or overwrite the variable each time. Both achieve the same result.

### About lazy loading... meh, maybe later.

Perhaps one of the strongest features of the SilverStripe ORM is its lazy loading of data. This is to say that a query is not executed until it absolutely has to be, resulting in not only fewer queries, but also more efficient queries.

Let's look at the following example:
```php
    $products = Product::get();
```

Common thinking would tell us that the get() method we invoked would execute a query similar to this:
```php
    “SELECT ID, Created, LastEdited, Title, Price FROM Product”
```

In actuality, no query is run when this method is called. Rather, SilverStripe just makes a note that at some point, you may be interested in getting all the products.

Let's take it a step further:

```php
    $products = Product::get();
    foreach($products as $product) {
        echo $product->Title;
    }
```

Now we have run a query, because the foreach loop has told the ORM that the we need the records, and it's time to act. Up until then, the list of products was merely an idea.

What's so great about this? Several things. One is that we have far fewer “wasted” queries. For example:

```php
    $articles = ArticlePage::get();
    $articles = $articles->filter(array('Author' => 'Aaron'));
    $articles = $articles->limit(5);

    foreach($articles as $article) {
      // ...
    }
```

Even though we're invoking several methods on the query, only one is actually executed.

Further, lazy loading presents the ORM with an opportunity to optimise the query just before it executes.

```php
    $products = Product::get();
    echo $products->count();
```

Rather than returning something like a `sizeof()` on the resulting array of records, the ORM is smart enough to see that all you really want is a count, and it executes something like the following:

```php
    “SELECT COUNT(*) FROM Product”
```
Typically in SilverStripe, it is a `<% loop %>` block on your template, if not a `foreach` in your controller, that actually tells the query to run.

### Using the ORM in a controller

Let's now take all of this into practice and add a custom database query to a controller. Looking at the home page, we see there is a section where the latest articles are syndicated. To get these to display, we'll need to write a method in our controller to fetch the list. Let's call it `LatestArticles`.

```php
namespace SilverStripe\Lessons;

use PageController;

class HomePageController extends PageController 
{

  public function LatestArticles() 
  { 
    return ArticlePage::get()
               ->sort('Created', 'DESC')
               ->limit(3);
  } 
}
```
There is no need to pass this method into the template. Because it's in the controller and defined as public, we can access it using `$LatestArticles`. Let's update `HomePage.ss` to loop through the articles.

```html
<h1 class="section-title">Recent Articles</h1>
<div class="grid-style1">
  <% loop $LatestArticles %>
	<div class="item col-md-4">
		<div class="image">
			<a href="$Link">
				<span class="btn btn-default"> Read More</span>
			</a>
			$Photo.Fit(220,148)
		</div>
		<div class="tag"><i class="fa fa-file-text"></i></div>
		<div class="info-blog">
			<ul class="top-info">
				<li><i class="fa fa-calendar"></i> $Date.Format('j F, Y')</li>
				<li><i class="fa fa-comments-o"></i> 2</li>
				<li><i class="fa fa-tags"></i> Properties, Prices, best deals</li>
			</ul>
			<h3>
				<a href="$Link">$Title</a>
			</h3>
			<p><% if $Teaser %>$Teaser<% else %>$Content.FirstSentence<% end_if %></p>
		</div>
	</div>
	<% end_loop %>
</div>
```
There's one minor improvement we can make to this function. Right now, the limit of three records is hardcoded in the controller, which isn't very configurable. The reason we're limiting the result set is due to the constraints imposed by the layout, so it makes more sense to assign this value on the template.

Update the `LatestArticles` function to accept a `$count` parameter, and set its default value to `3`. Pass this parameter into the `limit()` method.

```php
//...
class HomePageController extends PageController {

  public function LatestArticles($count = 3) 
  {
    return ArticlePage::get()
                 ->sort('Created', 'DESC')
                 ->limit($count);
  }
}
```
Now, on the template, simply use `<% loop $LatestArticles(3) %>`.