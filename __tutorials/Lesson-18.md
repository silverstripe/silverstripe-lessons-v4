## What we'll cover
* What are we working towards?
* Updating the template: Working backwards
* Updating the controller to use generic data

## What are we working towards?

Up until now, the data on our templates has been pretty one-sided. It's sourced from the database, and we render the fields from one or many returned records on the template. However, the template and the database are not so tightly coupled. There's no rule saying that all template data has to come from the database

Ultimately what we're teaching in this lesson is the concept of *composable UI elements*. As you may know, composable components are a rapidly accelerating trend in application development as developers and designers seek to maintain a high level of agility and reusability.

Being composable, these components are essentially "dumb" and only really know how to do one thing, which is render some UI based on the configuration that has been passed to them, which is what we'll call a *composition*.

In the context of our project, we'll be lighting up the search filter toggle buttons in the sidebar of our property search page. The purpose of these buttons is to show the user what search filters have been applied, and to offer an option to remove them and refresh the search page.

## Updating the template: Working backwards

A lot of developers, including myself, find it easier to work backwards with problems like this, which means starting from the template and adding the backend afterward. Let's look at these filter buttons and try to abtract them into something we can use.

As we can see, they're all statically contained in a `ul` tag at the moment.

```html
<ul class="chzn-choices">
   <li class="search-choice"><span>New York</span><a href="#" class="search-choice-close"></a></li>
   <li class="search-choice"><span>Residential</span><a href="#" class="search-choice-close"></a></li>
   <li class="search-choice"><span>3 bedrooms</span><a href="#" class="search-choice-close"></a></li>
   <li class="search-choice"><span>2 bathrooms</span><a href="#" class="search-choice-close"></a></li>
   <li class="search-choice"><span>Min. $150</span><a href="#" class="search-choice-close"></a></li>
   <li class="search-choice"><span>Min. $400</span><a href="#" class="search-choice-close"></a></li>
</ul>
```

### The wrong way to do it

One approach that may come to mind is using a long series of display logic to output all of the possible options, like so:

```html
<ul class="chzn-choices">
<% if $LocationFilter %>
   <li class="search-choice"><span>$LocationFilter</span><a href="#" class="search-choice-close"></a></li>
<% end_if %>

<% if $BedroomFilter %>
   <li class="search-choice"><span>$BedroomFilter bedrooms</span><a href="#" class="search-choice-close"></a></li>
<% end_if %>

<!-- etc... -->
</ul>
```

This might look reasonable at first, it's going to lead to nothing but problems. There are a number of things wrong with this approach.

* It pollutes your template with syntax, and a lot of repeated markup
* It pollutes your controller with a lot of repetative property assignments and/or methods
* It creates more parity between your controller and your template. If you ever want to add or remove a new search option, you have to remember to update the template.
* We have to repurpose the *value* of the filter as its *label*, e.g. `$BedroomFilter bedrooms`, and at some point that's just not going to work. Search filters are often not human-readable, such as IDs.

### A better approach

If the sight of `li` tags nested in a `ul` is becoming almost synonymous with the `<% loop %>` control to you, that's a good sign. We're definitely going to need a loop here. This will keep the UI template much cleaner, and it will give us more control over the output, as we'll have a chance to *compose* each member of the loop. Let's add that now, and make up the rest as we go.

```html
<ul class="chzn-choices">
   <% loop $ActiveFilters %>
     	<li class="search-choice"><span>New York</span><a href="#" class="search-choice-close"></a></li>
   <% end_loop %>
</ul>
```

Make sense so far? Again, we're working backwards, so the `$ActiveFilters` piece is merely semantic right now. 

Let's now just go through brainstorm some property names for all the dynamic content.

```html
<% if $ActiveFilters %>
<div class="chzn-container-multi">
  <ul class="chzn-choices">
     <% loop $ActiveFilters %>
        <li class="search-choice"><span>$Label</span><a href="$RemoveLink" class="search-choice-close"></a></li>
     <% end_loop %>
  </ul>
</div>
<% end_if %>
```

We've added the properties `$Label` and `$RemoveLink`, which we can assume are the only two distinguishing traits of each filter button.

## Updating the controller

Now that our template syntax is in place, we need to configure the controller to feed this data to the template. We could write a new method called `ActiveFilters()` (or `getActiveFilters()`) that inspects the request and returns something, but given that there's only one endpoint for our search page, I think it makes more sense at this point in the project to create the filter UI elements as they're being applied to the list.

### Creating an arbitrary list

In order to invoke the `<% loop %>` block we of course will need some kind of iteratable list. So far we've been using `SilverStripe\ORM\DataList`, which represents a list of records associated with a database query. Since our filter UI elements are not coming from the database, we'll need something more primitive. In this case, `SilverStripe\ORM\ArrayList` is an ideal choice.

At the top of our `index()` action, let's instantiate that list.

*mysite/code/PropertySearchPageController.php*
```php
//...
use SilverStripe\ORM\ArrayList;

class PropertySearchPageController extends PageController
{
	public function index(HTTPRequest $request)
	{
		$properties = Property::get();
		$activeFilters = ArrayList::create();
	
		//...
	}
	//...
```
Now, we just need to fill our list with data.

### Remember ViewableData?
To populate the list, we'll revisit our old friend `SilverStripe\View\ViewableData` from the previous tutorial. Just as a recap, `ViewableData` is a primitive object that is ready to be rendered on a template. One type of `ViewableData` is `DataObject`, which we've been using all along to render content from the database.

You will rarely need to use the `ViewableData` class itself, but as its immediate descendant `SilverStripe\View\ArrayData` is very flexible and couldn't be simpler to implement. It's basically just a glorified keyed array. All you have to do is instantiate it with an array of key/value pairs that will translate to `$Variable` template variables, and render their associated values.

Let's add the details for the `Keywords` filter.

*mysite/code/PropertySearchPageController.php*
```php
//...
use SilverStripe\View\ArrayData;
use SilverStripe\Control\HTTP;

class PropertySearchPageController extends PageController
{

	public function index(HTTPRequest $request)
	{
		
		//...
		
		if ($search = $request->getVar('Keywords')) {
			$activeFilters->push(ArrayData::create([
				'Label' => "Keywords: '$search'",
				'RemoveLink' => HTTP::setGetVar('Keywords', null, null, '&'),
			]));

			$properties = $properties->filter([
				'Title:PartialMatch' => $search
			]);
		}
		
		//..

```

Using the `push()` method on `ArrayList`, we add `ArrayData` objects to it. Each one has `Label` and `RemoveLink` properties, as required by the template. The `RemoveLink` property implements an obscure utility method from the `SilverStripe\Control\HTTP` helper class. All it does is take the current URI and set a given query parameter to a given value. In this case, we're setting it to `null` to effectively remove the filter.

The next filter is for the availability date range. It actually doesn't offer a whole lot of utility to the user to display this as a toggleable filter, especially since it's actually a composite filter of `ArrivalDate` and `Nights`, so let's skip this one.

The next several, which are all part of our tidy loop, are pretty straightforward. We'll add another member to the `$filterKeys` list, which will be a `sprintf()` compatible template to generate the label for each filter.

*mysite/code/PropertySearchPageController.php*
```php
	public function index(HTTPRequest $request)
	{
		
		//...

    $filters = [
        ['Bedrooms', 'Bedrooms', 'GreaterThanOrEqual', '%s bedrooms'],
        ['Bathrooms', 'Bathrooms', 'GreaterThanOrEqual', '%s bathrooms'],
        ['MinPrice', 'PricePerNight', 'GreaterThanOrEqual', 'Min. $%s'],
        ['MaxPrice', 'PricePerNight', 'LessThanOrEqual', 'Max. $%s'],
    ];

    foreach($filters as $filterKeys) {
        list($getVar, $field, $filter, $labelTemplate) = $filterKeys;
        if ($value = $request->getVar($getVar)) {
            $activeFilters->push(ArrayData::create([
                'Label' => sprintf($labelTemplate, $value),
                'RemoveLink' => HTTP::setGetVar($getVar, null, null, '&'),
            ]));

            $properties = $properties->filter([
                "{$field}:{$filter}" => $value
            ]);
        }
    }

		//...
	}

```

### Passing the filters to the template

Just like our custom variable `Results`, we'll pass the `ActiveFilters` list to the template through an array.

*mysite/code/PropertySearchPageController.php*
```php
	public function index(HTTPRequest $request)
	{
		
		//...

		$paginatedProperties = PaginatedList::create(
			$properties,
			$request
		)->setPageLength(15)
		 ->setPaginationGetVar('s');

		$data = array (
			'Results' => $paginatedProperties,
			'ActiveFilters' => $activeFilters			
		);

		//...
	}
```

Reload the page, and you should have working filter buttons now!
