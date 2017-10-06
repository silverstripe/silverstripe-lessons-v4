## What we'll cover
* Setting expectations: Searching vs. filtering
* Making minor updates to the Property object
* Creating a new search results page
* Building a search form
* Applying filters to a DataList
* Pulling the results into the template

## Setting expectations: Searching vs. filtering
Before we begin, it's important that we set a baseline for what we're looking to accomplish in this tutorial, because search, as you may know, is a real can of worms.

Search is an inexact science. It seeks to deliver to the user the most accurate results per his or her input. It's highly subjective, and it is therefore always being tuned to increase the likelihood of it satisfying the largest volume of users. It is never perfect. To this end, there are many third-party search tools available that do a lot of the work for you, and you can integrate them into just about any database-driven project. Some popular options include [Solr](http://lucene.apache.org/solr/), [Sphinx](http://sphinxsearch.com/), and [Elastic Search](https://www.elastic.co/). Even MySQL itself has some [basic search functionality](https://dev.mysql.com/doc/refman/5.0/en/fulltext-search.html) that is often all you need.

High-powered, intelligent keyword searching is perhaps a topic for another tutorial, because in this lesson, while we will be covering "search" in the academic sense, what we're really talking about is *filtering*. Unlike searching, filtering should provide expected results 100% of the time, because all you're doing is objectively matching key/value pairs in the user's input to key/value pairs stored on individual records that are part of a collection. Since this is an introductory lesson, we'll be dealing mostly with simple filtering of records, but we will do a bit of keyword matching, as well. Just understand that it won't be the optimal free text search solution for most projects.

On an unrelated note, please raise your tolerance level for imperfect visual design. The forms we'll create will not render markup that is compatible with our stylesheet. We have a whole tutorial on customising forms coming up very soon, and in the interest of maintaining a single focus, that step has been omitted from this tutorial.

## Making a minor update the Property object

Let's look at the search form on the home page. We have four parameters we can use in our search:
* Date of arrival
* Number of nights
* Bedrooms (minimum)
* Keywords

The last two are pretty straightforward, but as for the first two, we have not made any accommodations for the availability of the rentals. That will come in the future, when we add functionality that allows users to book rentals for a given span of dates.

In the interest of teaching the concept over meeting the requirements of an imaginary website, we're going to create some temporary fields on the `Property` objects that store this data natively on the record. Once users can book rentals, we'll remove these fields, but for now, we just want to get our search form working, so let's add the following:

*mysite/code/Property.php*
```php
//...
class Property extends DataObject
{

  private static $db = [
	    //...
      'AvailableStart' => 'Date',
      'AvailableEnd'=> 'Date'
	];
```

We should also add some fields to the CMS so these can be edited.

```php
public function getCMSFields()
{
  //...
  DateField::create('AvailableStart', 'Date available (start)'),
  DateField::create('AvailableEnd', 'Date available (end)'),
  //...    
```

Run `dev/build` and see that we get some new fields.

We'll spare you the trouble of populating those values for 100 records, so now is a good time to execute the `__assets/set_property_dates.sql` file in this lesson, so that we have some data to search on. It populates the `AvailableStart` and `AvailableEnd` columns with a random date between now and a year from now. The end date is a random value of 1-14 days after the start date.

For reference, the queries are as follows:

```sql
UPDATE SilverStripe_Lessons_Property SET AvailableStart = FROM_UNIXTIME(
        UNIX_TIMESTAMP(NOW()) + FLOOR(0 + (RAND() * 31536000))
);
UPDATE SilverStripe_Lessons_Property SET AvailableEnd = FROM_UNIXTIME(
        UNIX_TIMESTAMP(AvailableStart) + FLOOR(1 + (RAND() * 1209600))
);

UPDATE SilverStripe_Lessons_Property_Live SET AvailableStart = (
  SELECT AvailableStart
    FROM SilverStripe_Lessons_Property
    WHERE
      SilverStripe_Lessons_Property.ID = SilverStripe_Lessons_Property_Live.ID
);
UPDATE SilverStripe_Lessons_Property_Live SET AvailableEnd = (
  SELECT AvailableEnd
    FROM SilverStripe_Lessons_Property
    WHERE
      SilverStripe_Lessons_Property.ID = SilverStripe_Lessons_Property_Live.ID
);
```

Our keyword search will need to search a property description. We'll add that field, as well.

*mysite/code/Property.php*
```php
//...
class Property extends DataObject
{

	private static $db = [
     //...
		'Description' => 'Text',
		'AvailableStart' => 'Date',
		'AvailableEnd'=> 'Date'
	];

  //...
	public function getCMSFields()
	{
		$fields = FieldList::create(TabSet::create('Root'));
		$fields->addFieldsToTab('Root.Main', array(
			TextField::create('Title'),
			TextareaField::create('Description'),
      //...
```

Run `dev/build`, and we're ready to roll!

## Creating a search results page

The page that renders the search results for property is pretty distinct. In the assets for this lesson, you'll find the HTML for a new template in `__assets/property-search-results.html`. Let's import that into our project.

Copy the contents of the file into *themes/one-ring/templates/SilverStripe/Lessons/Layout/PropertySearchPage.ss*.

Then, create new classes for the Page.

*mysite/code/PropertySearchPage.php*
```php
namespace SilverStripe\Lessons;

use Page;

class PropertySearchPage extends Page
{

}
```

*mysite/code/PropertySearchPageController.php*
```php
namespace SilverStripe\Lessons;

use PageController;

class PropertySearchPageController extends PageController
{

}
```

Run `dev/build?flush`, as we're modifying the database *and* introducing a new template.

Next, go into the CMS and change the *Find a Rental* page to a *Property Search Page*. Browse to the page on the frontend and confirm that our template is showing.

## Building the search form

There are two search forms currently in our project -- one on the home page, and one on our new `PropertySearchResults` page. Let's just work on the search results page for now.

We'll create a new method called `PropertySearchForm`, and we'll do our best to recreate the fields that are in the template.

*mysite/code/PropertySearchPageController.php*
```php
namespace SilverStripe\Lessons;

use PageController;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FormAction;
use SilverStripe\ORM\ArrayLib;

class PropertySearchPageController extends PageController
{

	public function PropertySearchForm()
	{
		$nights = [];
		foreach(range(1,14) as $i) {
			$nights[$i] = "$i night" . (($i > 1) ? 's' : '');
		}
		$prices = [];
		foreach(range(100, 1000, 50) as $i) {
			$prices[$i] = '$'.$i;
		}

		$form = Form::create(
			$this,
			'PropertySearchForm',
			FieldList::create(
				TextField::create('Keywords')
					->setAttribute('placeholder', 'City, State, Country, etc...')
					->addExtraClass('form-control'),
				TextField::create('ArrivalDate','Arrive on...')				
					->setAttribute('data-datepicker', true)
					->setAttribute('data-date-format', 'DD-MM-YYYY')
					->addExtraClass('form-control'),
				DropdownField::create('Nights','Stay for...')					
					->setSource($nights)
					->addExtraClass('form-control'),
				DropdownField::create('Bedrooms')					
					->setSource(ArrayLib::valuekey(range(1,5)))
					->addExtraClass('form-control'),
				DropdownField::create('Bathrooms')					
					->setSource(ArrayLib::valuekey(range(1,5)))
					->addExtraClass('form-control'),
				DropdownField::create('MinPrice','Min. price')
					->setEmptyString('-- any --')
					->setSource($prices)
					->addExtraClass('form-control'),
				DropdownField::create('MaxPrice','Max. price')
					->setEmptyString('-- any --')
					->setSource($prices)
					->addExtraClass('form-control')				
			),
			FieldList::create(
				FormAction::create('doPropertySearch','Search')
					->addExtraClass('btn-lg btn-fullcolor')
			)
		);

		return $form;
	}
}
```

We've seen forms before, so most of this shouldn't be new to you. The one new concept we've introduced here is that we're first building a couple of arrays we'll need for our dropdown fields. Typically executing all of this before constructing the form is a good idea. If you ever find yourself needing access to those lists beyond the scope of the form, it's often advisable to create them in a separate method.

Let's add the form to the template now. Remove the entire `<form>` tag representing the static form, and replace it with `$PropertySearchForm`. It should render nicely. It's not as nice as the design, but at least it's usable. We'll clean up the markup later.

### Go GET it: Handling the search form

You may have noticed that we left out a very important step in building a form. We never updated our `$allowed_actions` array to permit the `PropertySearchForm` method. That's because we actually don't need it!

Think about what we want from our search form. The user should be able to create a filtered view of results and send it off to a friend, paste it into another browser, or refresh the page. In short, these results need to have their own URL.

By default, forms submit through the `POST` method, which works great for handling user input that mutates data on the backend, but all we really want from our form here is a glorified URL builder. All the form really has to do is redirect us off to a URL that passes all of its parameters into a query string (GET request), and allow the controller to take it from there. Therefore, for this form, we'll use the `GET` method. Let's update the form object to do that.

*mysite/code/PropertySearchPageController.php*
```php
public function PropertySearchForm()
{
    //...
    $form->setFormMethod('GET');

    return $form;
}
```

Next, we need to make sure the form doesn't submit to its handler, `doPropertySearch`, and rather, just redirects to the default view in the controller.

*mysite/code/PropertySearchPageController.php*
```php
public function PropertySearchForm()
{
    //...
	$form->setFormMethod('GET')
	     ->setFormAction($this->Link());

    return $form;
}
```

Now let's test it out. Put some data into the form, and hit *Search*. Needless to say, it shouldn't update the results, which are still static, but take note of the URL. It looks pretty good, but there's one problem. The `SecurityID` parameter doesn't belong in our URL. Normally, this is used to thwart CSRF (Cross-Site Request Forgery) attacks, but since this is a simple `GET` form, we don't need, nor do we want that security measure (it would deny another user access to the URL). Let's remove the security token.

*mysite/code/PropertySearchPageController.php*
```php
public function PropertySearchForm()
{
    //...
	$form->setFormMethod('GET')
	     ->setFormAction($this->Link())
	     ->disableSecurityToken();

    return $form;
}
```

Refresh the page, and give the search another try. The URL should look a bit cleaner now. If the `SecurityID` parameter is still in the URL, try removing the entire query string from the address bar and try again.

## Applying filters to a DataList

Now that we have search parameters coming in through the request, we can start applying them as filters to a `SilverStripe\ORM\DataList`. Recall from our tutorial on the ORM that these lists are *lazy-loaded*, which lends it self nicely for applying a variable number of filters. Rather than build a filter clause all in one go, we can take our time and apply each filter independently, without having to worry about executing a query.

We're going to do execute all of this in the `index` action of our controller. Every controller fires the `index` action by default, so it is not necessary to add this to the `$allowed_actions` array.

By default, if no search is applied, we want to return all the Property records, so let's start with that.

We don't have pagination set up yet, so let's limit the result set to 20, so we don't have to pull down all 100 properties by default.

*mysite/code/PropertySearchPageController.php*
```php
//...
use SilverStripe\Control\HTTPRequest;

class PropertySearchPageController extends PageController
{

	public function index(HTTPRequest $request)
	{
		$properties = Property::get()->limit(20);

		return [
			'Results' => $properties
		];
	}
     
  //...
}
```

This should be pretty straightforward. We get all the records, and eventually, we'll be looping through a custom variable called `$Results` on the template.

Now let's start inspecting the `GET` request. We'll check each parameter, and apply the necessary filter for each one. For this section, we'll be using a lot of `SearchFilter` classes that may be new to you. For a full list of available filters, see *framework/src/ORM/Filters* or read the [API docs](http://api.silverstripe.org).

First, let's use the `PartialMatchFilter` to match a keyword in the title.
```php
if ($search = $request->getVar('Keywords')) {
	$properties = $properties->filter([
		'Title:PartialMatch' => $search				
	]);
}
```
Keep in mind, `PartialMatch` only checks for a sequence of characters in the field (case insensitive). It won't perform any language transformations or parse phrases. A search for *sea views* will not match against a title containing *sea view*.

Next, we'll parse the date and create our filter for `AvailableStart` and `AvailableEnd`.

```php
if ($arrival = $request->getVar('ArrivalDate')) {
	$arrivalStamp = strtotime($arrival);						
	$nightAdder = '+'.$request->getVar('Nights').' days';
	$startDate = date('Y-m-d', $arrivalStamp);
	$endDate = date('Y-m-d', strtotime($nightAdder, $arrivalStamp));

	$properties = $properties->filter([
		'AvailableStart:GreaterThanOrEqual' => $startDate,
		'AvailableEnd:LessThanOrEqual' => $endDate
	]);

}
```

This gets a bit tricky. In an ideal world, the date would come through the GET request in proper Y-m-d format, the way a database prefers to deal with them, but our calendar widget doesn't submit its value that way. A more configurable widget might let us provide two formats -- one for the display to the user, and one for the form data, but unfortunately, that option isn't available, so we need to take the date in DD-MM-YYYY format and parse it out.
```php
if ($arrival = $request->getVar('ArrivalDate')) {
	$arrivalStamp = strtotime($arrival);						
	$nightAdder = '+'.$request->getVar('Nights').' days';
	$startDate = date('Y-m-d', $arrivalStamp);
	$endDate = date('Y-m-d', strtotime($nightAdder, $arrivalStamp));

	$properties = $properties->filter([
		'AvailableStart:LessThanOrEqual' => $startDate,
		'AvailableEnd:GreaterThanOrEqual' => $endDate
	]);

}
```
Using the `strtotime()` method, we add the number of nights to the Unix timestamp of the arrival date. If you haven't used `strtotime()` before, you should acquaint yourself with it at the [PHP documentation page](http://php.net/strtotime). It allows you to pass human-readable manipulation phrases to timestamps, such as `strtotime('+3 weeks', $timestamp)`. It's invaluable for date manipulation.

Using two computed Y-m-d dates for the start and end, we apply a `GreaterThanOrEqualFilter` and a `LessThanOrEqualFilter` to search in a range.

** Important note about user-friendly dates **

The use of hyphens to separate the date values is of critical importance, here. PHP's `strtotime()` method disambiguates DMY and MDY dates through the character that is used to separate the values. Hyphens are assumed to indicate DMY and slashes are assumed to be MDY.
```php
date('F j Y', strtotime('7/3/2015')); // July 3 2015
date('j F Y', strtotime('7-3-2015')); // 7 March 2015
```

The next four filters are pretty straightforward. We'll use `GreaterThanOrEqualFilter` and `LessThanOrEqualFilter` to filter by bedrooms, bathrooms, and price.

```php
if ($bedrooms = $request->getVar('Bedrooms')) {
	$properties = $properties->filter([
		'Bedrooms:GreaterThanOrEqual' => $bedrooms
	]);
}
```

A few more of those, and here we have all of our filters:

*mysite/code/PropertySearchPageController.php*
```php
public function index(HTTPRequest $request)
{
	$properties = Property::get();
	
	if ($search = $request->getVar('Keywords')) {
		$properties = $properties->filter(array(
			'Title:PartialMatch' => $search				
		));
	}

	if ($arrival = $request->getVar('ArrivalDate')) {
		$arrivalStamp = strtotime($arrival);						
		$nightAdder = '+'.$request->getVar('Nights').' days';
		$startDate = date('Y-m-d', $arrivalStamp);
		$endDate = date('Y-m-d', strtotime($nightAdder, $arrivalStamp));

		$properties = $properties->filter([
			'AvailableStart:GreaterThanOrEqual' => $startDate,
			'AvailableEnd:LessThanOrEqual' => $endDate
		]);

	}

	if ($bedrooms = $request->getVar('Bedrooms')) {
		$properties = $properties->filter([
			'Bedrooms:GreaterThanOrEqual' => $bedrooms
		]);
	}

	if ($bathrooms = $request->getVar('Bathrooms')) {
		$properties = $properties->filter([
			'Bathrooms:GreaterThanOrEqual' => $bathrooms
		]);
	}

	if ($minPrice = $request->getVar('MinPrice')) {
		$properties = $properties->filter([
			'PricePerNight:GreaterThanOrEqual' => $minPrice
		]);
	}

	if ($maxPrice = $request->getVar('MaxPrice')) {
		$properties = $properties->filter([
			'PricePerNight:LessThanOrEqual' => $maxPrice
		]);
	}

	return [
		'Results' => $properties
	];
}
```

Looking at this code, there's a lot of repetition, and we're teetering on the edge of breaking our DRY princples. Let's tidy it up a bit by creating a map of the filters and looping through them.

*mysite/code/PropertySearchPageController.php*
```php
public function index(HTTPRequest $request)
{
  //...
	if ($arrival = $request->getVar('ArrivalDate')) {
    //...
	}
  
  $filters = [
    ['Bedrooms', 'Bedrooms', 'GreaterThanOrEqual'],
    ['Bathrooms', 'Bathrooms', 'GreaterThanOrEqual'],
    ['MinPrice', 'PricePerNight', 'GreaterThanOrEqual'],
    ['MaxPrice', 'PricePerNight', 'LessThanOrEqual'],
  ];
  
  foreach($filters as $filterKeys) {
    list($getVar, $field, $filter) = $filterKeys;
    if ($value = $request->getVar($getVar)) {
      $properties = $properties->filter([
        "{$field}:{$filter}" => $value
      ]);
    }
  }

	return [
		'Results' => $properties
	];
}
```

### Persisting state on the search form

Try searching using our new applied filters. We should still see static results, but notice that the form loses its state on page refresh. That's not good enough. We'll need to render the form populated with any filter parameters in the request. Since all of our form field names match request parameters, this is exceedingly simple.

*mysite/code/PropertySearchPageController.php*
```php
public function PropertySearchForm()
{
  //...
	$form->setFormMethod('GET')
	     ->setFormAction($this->Link())
	     ->disableSecurityToken()
	     ->loadDataFrom($this->request->getVars());

    return $form;
}
```
We load all the variables in the `GET` request using the `getVars` method of the `HTTPRequest` object. Also available are `postVars()` and the all-inclusive `requestVars()`. Keep in mind, this magic only works if your form fields share names with request parameters. If our form field was named *MinBedrooms* and the request contained a variable called *Bedrooms* we would have to assign the value explicitly, using `setValue($this->request->getVar('MinBedrooms')` on the form field.

Refresh the page and see that the form now saves its state.

## Pulling the results into the template

Now that we have our `$Results` list being passed to the template, we'll loop through the results.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/PropertySearchPage.ss* (line 38)
```html
<% loop $Results %>
<div class="item col-md-4">
	<div class="image">
		<a href="$Link">
			<span class="btn btn-default"><i class="fa fa-file-o"></i> Details</span>
		</a>
		$PrimaryPhoto.Fill(760,670)
	</div>
	<div class="price">
		<span>$PricePerNight.Nice</span><p>per night<p>
	</div>
	<div class="info">
		<h3>
			<a href="$Link">$Title</a>
			<small>$Region.Title</small>
			<small>Available $AvailableStart.Nice - $AvailableEnd.Nice</small>
		</h3>
		<p>$Description.LimitSentences(3)</p>
	
		<ul class="amenities">
			<li><i class="icon-bedrooms"></i> $Bedrooms</li>
			<li><i class="icon-bathrooms"></i> $Bathrooms</li>
		</ul>
	</div>
</div>
<% end_loop %>
```

To help with debugging, we've added the `$AvailableStart` and `$AvailableEnd` values to confirm that our date search is working.

Give the search a try and see how the filters work. 