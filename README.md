## What we'll cover
* A brief overview of lists
* Creating a paginated list
* Adding pagination links to the template
* Customising the paginated list

## A brief overview of lists

So far, we've only been working with `SilverStripe\ORM\DataList` to render a collection of data, but it's important to note that there are all kinds of lists that SilverStripe Framework offers you, each of which addresses some special concern. Here are a few common lists you might use in the `SilverStripe\ORM` namespace:
* `ArrayList`: The most primitive type of list. It contains arbitrary data, and doesn't do anything particularly special.
* `DataList`: Used for data pulled from the database, and provides an API for updating the query that defines its collection of records.
* `PaginatedList`: Assigns a limit and offset to the result set based on a page derived from the request parameter, and exposes an API for determining what page is active and what pages are available.
* `GroupedList`: Allows the result set to be grouped into sub-lists each with their own heading, for example, grouped by a common category or city name.

All of these lists implement the `SilverStripe\ORM\SS_List` interface, which specifies that they all must know how to perform the basic functions of a list, including:

* Iterating over the list
* Adding to the end of the list (`->add()`)
* Getting the first or last member of the list (`->first()`)
* Removing an item of the list (`->remove($item)`)
* Getting a result from the list that matches (`->find($key, $val)`)
* Transforming the list into a simple array (`->toArray()`)
* Getting the size of the list (`->count()`)

As you can see, `PaginatedList` is just one implementation of this specification, and in addition to all of the above functionality, it provides us with very valuable tools for dealing with pagination, and we'll look at all of that next.

## Creating a paginated list

In the previous lesson, we created a search form that produced a list of results. Right now, the results are artificially limited to 20, for performance reasons, since there are more than 100 records in the database. Looking at the template, we already have some static HTML for the pagination, so let's work on activating that.

As said before, SilverStripe's `PaginatedList` class is essentially a wrapper for a `DataList` that does a lot of the legwork for us. It will automatically look at the request and add the correct `LIMIT` clause to the DataList, and it will also provide a public API for determining what page is active and what pages, if any, are available.

Let's look at `PropertySearchPage.php` again and find the return value of our `index()` action. Right now, it's returning a `DataList`. Let's have it return a `PaginatedList` instead.

First things first, let's remove the artificial `->limit()` we've applied.

*mysite/code/PropertySearchPageController.php*
```php
  public function index(HTTPRequest $request)
  {
		$properties = Property::get();

		//...
	}
```

Now, let's wrap the results into a `PaginatedList`.

*mysite/code/PropertySearchPageController.php*
```php
//...
use SilverStripe\ORM\PaginatedList;

class PropertySearchPageController extends PageController
{
	public function index(HTTPRequest $request)
	{
		
		//...
		
		$paginatedProperties = PaginatedList::create(
			$properties,
			$request
		);

		return [
			'Results' => $paginatedProperties
		];
	}
```

It's really that simple. All we do is pass it the `SS_List` instance that we're working with (usually a `DataList`), and in the interest of keeping the list loosely coupled, we pass the request as well. It may seem odd that we have to do that, but if the list were request aware, it would introduce tight coupling, which makes unit testing more difficult and renders the class less extensible.

Thanks to a wealth of default values that come pre-baked into `PaginatedList`, we're actually ready to just render these results on the template.

## Adding pagination links to the template

Let's have a look at our `PropertySearchPage.ss` template, and find the HTML for the pagination.

Up until now, the only syntax we've really used on a list has been `<% loop %>` blocks, but the list itself actually has properties, too, much like a `DataObject`.

Let's use some of the properties we get from `PaginatedList` to render this pagination.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/PropertySearchPage.ss`*
```html
<!-- BEGIN PAGINATION -->
<% if $Results.MoreThanOnePage %>
<div class="pagination">
	<% if $Results.NotFirstPage %>
	<ul id="previous col-xs-6">
		<li><a href="$Results.PrevLink"><i class="fa fa-chevron-left"></i></a></li>
	</ul>
	<% end_if %>
	<ul class="hidden-xs">
		<% loop $Results.Pages %>
		<li <% if $CurrentBool %>class="active"<% end_if %>><a href="$Link">$PageNum</a></li>
		<% end_loop %>
	</ul>
	<% if $Results.NotLastPage %>
	<ul id="next col-xs-6">
		<li><a href="$Results.NextLink"><i class="fa fa-chevron-right"></i></a></li>
	</ul>
	<% end_if %>
</div>
<% end_if %>
<!-- END PAGINATION -->
```

We wrap the whole UI in the condition that `$Results.MoreThanOnePage` returns true. None of this should display if there are only a few results. Then, if we're on anything but the first page, we'll use the `$Results.PrevLink` to provide a link to the previous page. We'll do the same with `$Results.NextLink` if we're on anything but the last page. In the middle, we loop through `$Results.Pages`, where each member of the list provides three properties:

* `$PageNum`: The page number
* `$CurrentBool`: True if the page is current
* `$Link`: The link to the page

Try out the pagination and see how it works. Notice that it's injecting a request parameter called `start` into the URL. Also note that the search parameters persist through the pagination.

Let's use some more properties of the paginated list to create a summary of the results.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/PropertySearchPage.ss*
```html
<% if $Results %>
	<h3>Showing $Results.PageLength results ($Results.getTotalItems total)</h3>					
	<% loop $Results %>
```

Lastly, if we have a lot of pages, it might break the UI. Instead of `$Results.Pages`, let's use `$Results.PaginationSummary`, which will just show us some of the nearby pages to the active one. In other words, we don't need to see page 17 of 30 if we're on page 2.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/PropertySearchPage.ss`
```html
<ul class="hidden-xs">
	<% loop $Results.PaginationSummary %>
		<% if $Link %>
			<li <% if $CurrentBool %>class="active"<% end_if %>><a href="$Link">$PageNum</a></li>
		<% else %>
			<li>...</li>
		<% end_if %>
	<% end_loop %>
</ul>
```
Notice that we have to check if `$Link` returns anything. If it doesn't, we know this item is the empty result that is intended to show the existence of suppressed pages.

Futher, you can customise how much context you would like by passing an integer to `PaginationSummary`. By default, it shows 4 pages of context.

## Customising the paginated list

This all works great, but the pagination is still configured with default values, most notably, a limit of 10 results per page. Let's update that.

*mysite/code/PropertySearchPageController.php*
```php
	public function index(HTTPRequest $request)
	{

		//...

		$paginatedProperties = PaginatedList::create(
			$properties,
			$request
		)->setPageLength(15);

		//...
	}
```

Another parameter we might want to customise is the request parameter that is used. In some cases, you might have a conflict with the variable `start`, or you may simply prefer something shorter. In that case, use `setPaginationGetVar()`.

*mysite/code/PropertySearchPageController.php*
```php
	public function index(HTTPRequest $request)
	{

		//...

		$paginatedProperties = PaginatedList::create(
			$properties,
			$request
		)
		    ->setPageLength(15)
		    ->setPaginationGetVar('s');

		//...
	}
```
