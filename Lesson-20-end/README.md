In the previous tutorial, we activated most of the sidebar filters for our Travel Guides section. We left out the date archive filter, however, because it introduced some complexity. Let's now dive into that complexity and get it working.

### Adding date filter links to the template

Looking at the template, we first have to generate a list of all the distinct month/year combinations for all the articles. Let's start by working backwards, and we want the end result to be on the template.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/ArticleHolder.ss*
```html
  <!-- BEGIN ARCHIVES ACCORDION -->
	<h2 class="section-title">Archives</h2>
	<div id="accordion" class="panel-group blog-accordion">
		<div class="panel">
		<!--
			<div class="panel-heading">
				<div class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="">
						<i class="fa fa-chevron-right"></i> 2014 (15)
					</a>
				</div>
			</div>
		-->
			<div id="collapseOne" class="panel-collapse collapse in">
				<div class="panel-body">
					<ul>
					<% loop $ArchiveDates %>
						<li><a href="$Link">$MonthName $Year ($ArticleCount)</a></li>
					<% end_loop %>
					</ul>
				</div>
			</div>
		</div>	
	</div>
	<!-- END  ARCHIVES ACCORDION -->

```
First off, these dates were grouped by year. We've commented that out for now. We can address that in a future tutorial on grouped lists. In the loop, each date entry has a `$Link` method that will go to the filtered article list, `$MonthName` and `$Year` properties, and an `$ArticleCount` property.

This is all well and good, but what are these objects?

In the previous tutorial, we discussed dealing with arbitrary template data, and this is a perfect use case. These date archive objects need to be iterable in a loop, and they need dynamic properties. We'll need to define them as simple `ArrayData` objects.

Let's build that list in the model of our `ArticleHolder` page type.

*mysite/code/ArticleHolder.php*
```php
//...
use SilverStripe\ORM\ArrayList;
class ArticleHolder extends Page
{
	//...

	public function ArchiveDates()
	{
		$list = ArrayList::create();

		return $list;
	}
```
### Running a custom SQL query

We're going to need to run a pretty specific query against the database to get all of the distinct month/year pairs, and this actually pushes the boundaries and practicality of the ORM. In rare cases such as this one, we can execute arbitrary SQL using `DB::query()`.

*mysite/code/ArticleHolder.php*
```php
//...
use SilverStripe\ORM\ArrayList;
use SilverStripe\Versioned\Versioned;
use SilverStripe\ORM\Queries\SQLSelect;

class ArticleHolder extends Page
{
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
```
To work outside the ORM, we can use the `SilverStripe\ORM\Queries\SQLSelect` class to procedurally build a string of selecting SQL. We pass an empty array to the constructor, because by default it will select `*`. We then just build the query using self-descriptive, chainable methods.

The main advantage to this layer of abstraction is that it's platform agnostic, so that if someday you change database platforms, you don't need to update any syntax. All select queries end up in `SQLSelect` eventually. `SiteTree::get()` is just a higher level of abstraction that builds an `SQLSelect` object. To build a really custom query, we're just going further down the food chain, so to speak.

We get the name of the table for `ArticlePage` from the `DataObjectSchema` class. This class contains a lot of valuable information for introspecting the abstractions of the ORM. You can ask it for the table name for a given class, get the database column for a given field, get all the database fields for a given class, and much more. In this case, we get the table name from the schema. Table names are user-configurable, but by default it follows the simple pattern of replacing the backslashes in the fully-qualified class name to underscores. In this case, `SilverStripe_Lessons_ArticlePage` is returned by the `tableName` function.

One major drawback of working outside the ORM is that we can no longer take versioning for granted. We have to be explicit about what table we want to select from. It is therefore imperative to check the current stage, and apply the necessary suffix to the table, e.g. *ArticlePage_Live*. Again, it's rare that you have to deal with stuff like this.

Don't worry too much if this query is over your head. It's not often that we have to do things like this. What this query is doing is creating a SKU for each article that contains its year, month number, and month name, separated by underscores, like this:

```
2015_05_May
```

We then use the `setDistinct()` method to ensure we only get one of each.

If you're wondering why we need the month name *and* the month number. The year and month number are enough to satisfy the `DISTINCT` flag on their own. The answer is, we don't really *need* it, but it will help us out later. We're getting the month name only for semantic purposes, to save time when we create the links on the template. The friendly month name is needed for the link text, but the month number is what we need for the URL.

Now all we have to do is loop through that database result to create our final list of date objects.

*mysite/code/ArticleHolder.php*
```php
		if ($result) {
			while($record = $result->nextRecord()) {
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
```

We loop through each record using the `nextRecord()` method. For each record, we explode the SKU into its component variables -- the year, the month number, and the month name -- and assign them to properties of an `ArrayData` object. We also create a link to the `date/$year/$monthNumber` route that we created in `ArticleHolder`. Lastly, we run a query against `ArticlePage` to get the number of articles that match this date SKU. Notice that in this case, we can safely just match the year and month number.

Notice that the `where()` method affords us parameterised queries. The shorthand of `'fieldName' => 'value'` should be used whenever possible to ensure your queries are safe from injection.

Here's the complete `ArchiveDates()` function:

*mysite/code/ArticleHolder.php*
```php
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
			while($record = $result->nextRecord()) {
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
```

Alright, get up, walk around. Have a (non-alcoholic) drink. Then refresh the page to see the fruits of your labour.

### Applying the date filter in the controller

The last thing we need to do to make the date archive work is set up that controller action to deal with the incoming `date/$year/$month` routes.

*mysite/code/ArticleHolderController.php*
```php
class ArticleHolderController extends PageController
{
	
	//...

	public function date(HTTPRequest $r)
	{
		$year = $r->param('ID');
		$month = $r->param('OtherID');

		if (!$year) return $this->httpError(404);

		$startDate = $month ? "{$year}-{$month}-01" : "{$year}-01-01";
		
		if (strtotime($startDate) === false) {
			return $this->httpError(404, 'Invalid date');
		} 
	}
```

We'll start by running a sanity check to ensure that we at least have a year in the URL. Then, we'll create a start date of either the first of the month or the first of the year. If for some reason the year or month values are invalid, and don't pass the `strtotime()` test, we throw an HTTP error.

Now, we'll create the boundary for the end date, and run the query.

*mysite/code/ArticleHolderController.php*
```php
		$adder = $month ? '+1 month' : '+1 year';
		$endDate = date('Y-m-d', strtotime(
		    $adder, 
				strtotime($startDate)
		));

		$this->articleList = $this->articleList->filter([
			'Date:GreaterThanOrEqual' => $startDate,
			'Date:LessThan' => $endDate 
		]);

		return [
			'StartDate' => DBField::create_field('Datetime', $startDate),
			'EndDate' => DBField::create_field('Datetime', $endDate)
		];
```

A really key detail of this function is that we return proper `SilverStripe\ORM\FieldType\DBField` objects to the template. If you'll remember from the early tutorials, controllers don't just return scalar values to the template. They're actually first-class, intelligent objects. By default, they're cast as `Text` objects, so we'll be more explicit and ensure that `StartDate` and `EndDate` are cast as dates. This will afford us the option to format them on the template.

You can achieve the same result more declaratively using the `$casting` setting on in your controller. We'll discuss that in a future tutorial and clean this up a bit.

For now, here is the complete `date()` controller action:

*mysite/code/ArticleHolderController.php*
```php
//...
use SilverStripe\ORM\FieldType\DBField;

class ArticleHolderController extends PageController
{
	
	//...

	public function date(HTTPRequest $r)
	{
		$year = $r->param('ID');
		$month = $r->param('OtherID');

		if (!$year) return $this->httpError(404);

		$startDate = $month ? "{$year}-{$month}-01" : "{$year}-01-01";
		
		if (strtotime($startDate) === false) {
			return $this->httpError(404, 'Invalid date');
		}

		$adder = $month ? '+1 month' : '+1 year';
		$endDate = date('Y-m-d', strtotime(
		    $adder, 
				strtotime($startDate)
		));

		$this->articleList = $this->articleList->filter([
			'Date:GreaterThanOrEqual' => $startDate,
			'Date:LessThan' => $endDate 
		]);

		return [
			'StartDate' => DBField::create_field('Datetime', $startDate),
			'EndDate' => DBField::create_field('Datetime', $endDate)
		];

	}

	//...
```

Refresh the browser and try clicking on some of the date archive links, and see that you're getting the expected results.

The last thing we need to do is pull our filter headers into the listings to show the user the state of the list. Each controller action returns its own custom template variables that we can check.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/ArticleHolder.ss*
```html
	<div id="blog-listing" class="list-style clearfix">
		<div class="row">
			<% if $SelectedRegion %>
				<h3>Region: $SelectedRegion.Title</h3>
			<% else_if $SelectedCategory %>
				<h3>Category: $SelectedCategory.Title</h3>
			<% else_if $StartDate %>
				<h3>Showing $StartDate.Date to $EndDate.Date</h3>
			<% end_if %>

```

We'll also add the dates to the articles themselves, removing the static dates that are there now.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/ArticleHolder.ss*
```html
  <div class="info-blog">
    <ul class="top-info">
      <li><i class="fa fa-calendar"></i> $Date.Nice</li>
      <li><i class="fa fa-comments-o"></i> 2</li>
      <li><i class="fa fa-tags"></i> $CategoriesList</li>
    </ul>
```

This is where having proper `SilverStripe\ORM\FieldType\Datetime` objects comes in really handy, as we can format the date right on the template.