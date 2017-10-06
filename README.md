## What we'll cover
* Writing the Javascript
* An overview of ViewableData
* Rendering a partial template
* Adding some UX enhancements


## Writing the Javascript

In the last tutorial, we added pagination to our list of search results. Let's now enhance the user experience a bit by adding Ajax to the pagination links.

Before we do anything, we'll need to add some JavaScript that will add this functionality. We'll do this in our catch-all JavaScript file, `scripts.js`.

*themes/one-ring/javascript/scripts.js*
```js
// Pagination
if ($('.pagination').length) {
  $('.main').on('click','.pagination a', function (e) {
	    e.preventDefault();
	    var url = $(this).attr('href');
	    $.ajax(url)
	        .done(function (response) {
	            $('.main').html(response);
	        })
	        .fail (function (xhr) {
	            alert('Error: ' + xhr.responseText);
	        });
	});
}

```

This is pretty specific to this use-case. Further down the track, we may find that we're adding a lot of Ajax events that closely resemble this, so we may want to make it more reusable at some point, but for now, let's just get this working.

Let's give this a try. Click on a link in the pagination and see if it works.

It kind of works, right? But we've still got a way to go. The controller is returning the entire page -- from `<html>` to `</html>` into our `.main` div. Not good, but it is the expected result. The Ajax URL is just the `href` attribute, so anything different would be unusual.

So what do we do? Change the URL in our Javascript to use something other than `href`? We could use an alternative URL in something like `data-ajax-url`. That's actually not necessary. We always aim to keep things tidy with single endpoints. The controller ideally know as little about the UI as possible, and setting up a separate endpoint for Ajax requests in this case would be antithetical to that. We'll keep the same endpoint, and we'll just assign the controller the ability to detect Ajax requests.

## Detecting Ajax in a controller

Let's update `PropertySearchPageController.php` to detect Ajax.

*mysite/code/PropertySearchPageController.php*
```php
public function index(HTTPRequest $request)
{
	
	//...

	if($request->isAjax()) {
		return "Ajax response!";
	}
	
	return [
		'Results' => $paginatedProperties
	];
}
```

Now give the link a try, and see what we get. You should see your custom Ajax response. Now we just need to return some partial content. Before we do that, let's talk a bit about a key player in SilverStripe Framework called `ViewableData`.

## An overview of ViewableData

To establish a basis for the next section of this lesson, we'll need to know more about how `ViewableData` objects work. `SilverStripe\View\ViewableData` is a primitive class in SilverStripe that essentially allows its public properties and methods to render content to a template. The most common occurance of `SilverStripe\View\ViewableData` objects is in `SilverStripe\ORM\DataObject` instances, which we've been working with on templates exclusively. But templates are capable of rendering much more than database content. You just need to go further up the inheritance chain, above `DataObject` to `ViewableData`, or a subclass thereof.

Let's look at a simple example of `ViewableData`.

```php
use SilverStripe\View\ViewableData;

class Address extends ViewableData
{
	
	public $Street = '123 Main Street';

	public $City = 'Compton';

	public $Zip = '90210';

	public $Country = 'US';

	public function Country()
	{
		return MyGeoLibrary::get_country_name($this->Country);
	}

	public function getFullAddress()
	{
		return sprintf(
			'%s<br>%s %s<br>%s'
			$this->Street,
			$this->City,
			$this->Zip,
			$this->Country() 
		);
	}
}
```

Now let's create a template to render our `Address` object.

*AddressTemplate.ss*
```html
<p>I live on $Street in $City.</p>
<p>My full address is $FullAddress.</p>
```

As you can see, we're rendering data using a combination of both methods and properties. `ViewableData` has a very specific way of resolving the template variables on the object:

* Check if there public method on the object called [VariableName]
* If not, check if a method called "get[VariableName]" exists
* If not, check if there is a public property named [VariableName]
* Otherwise, call "getField([VariableName])"

`getField()` is a fallback method. For the base `ViewableData` class, it simply returns `$this->$VariableName`. The idea is that subclasses can invoke their own handlers for this. For example, in `DataObject`, `getField()` looks to the `$db` array.

All `ViewableData` objects know how to render themselves on templates. To do that, simply invoke `renderWith($templateName)` on the object, and the template variables will be scoped to that object.

```php
$myViewableData = Address::create();
echo $myViewableData->renderWith('AddressTemplate');
```

Another really useful feature of `ViewableData` is that the object itself can be called on a template and render itself. If we were to simply call `$MyAddressObject` on a template, SilverStripe would attempt to invoke a method called `forTemplate()` on the object to render it as a string. In our example address object, that might look like this:

```php
class Address extends ViewableData
{
	
	//...	

	public function forTemplate()
	{
		return $this->getFullAddress();
	}
}
```

A great example of this is SilverStripe's `Image` class. When you call `$MyImage` on a template, it invokes its `forTemplate()` method, which returns a string of HTML representing an `<img />` tag with all the correct attributes and values.

## Rendering a partial template

So now that we have a good understanding of `ViewableData`, let's play around with some of its features. Right now, we're just returning a string to the template for our Ajax response. Let's instead return a partial template.

At the centre of dealing with Ajax responses is the use of includes in your Layout template. Let's take everything in the `.main` div, and export it to an include called `PropertySearchResults`.

*themes/one-ring/templates/SilverStripe/Lessons/Includes/PropertySearchResults.ss*
```html
<!-- BEGIN MAIN CONTENT -->
<div class="main col-sm-8">
	<% include SilverStripe/Lessons/PropertySearchResults %>				
</div>	
<!-- END MAIN CONTENT -->
```

Notice that the `Includes/` part of the path is implicit when calling `<% include %>`.

Reload the page with `?flush` to get the new template.

Now, returning an Ajax response is trivial. Simply render the include.

```php
//...
class PropertySearchPageController extends PageController
{

	public function index(HTTPRequest $request)
	{

		//...
		
		if($request->isAjax()) {
			return $this->renderWith('SilverStripe/Lessons/Includes/PropertySearchResults');
		}
		
		//..
	}
}
```

This time, we don't benefit from the implicit `Includes/` directory. Unlike the template syntax, we need to specify it when referring to it in controller code.

Let's try this out. It's not quite working right. We're getting a "no results" message when we paginate. That's because the `$Results` variable is not exposed to the template through `renderWith()`. It's just a local variable in our `index()` method. We have two choices here:

* Assign `$paginatedProperties` to a public property on the controller
* Explicitly pass it to the template using `customise()`.

Of these two options, the latter is much more favourable. There are cases where the first option makes more sense, but in this case, explicitly passing the list makes our `PropertySearchResults` template more reusable, and assigning a new member property would pollute our controller unnecessarily. Let's make that update now.

```php
//...
class PropertySearchPageController extends PageController
{

	public function index(HTTPRequest $request)
	{

		//...
		
		if($request->isAjax()) {
			return $this->customise([
				'Results' => $paginatedResults
			])->renderWith('SilverStripe/Lessons/Includes/PropertySearchResults');
		}

		return [
			'Results' => $paginatedProperties
		];
	}
}
```
We now have repeated our array of data, so let's clean that up a bit.

```php
//...
class PropertySearchPageController extends PageController
{


	public function index(HTTPRequest $request) {

		//...
		
		$data = [
			'Results' => $paginatedProperties
		];

		if($request->isAjax()) {
			return $this->customise($data)
						 ->renderWith('SilverStripe/Lessons/Includes/PropertySearchResults');
		}

		return $data;
	}
}
```

Try it now. It's looking much better!

## Adding some UX enhancements

There are two major shortcomings of this user experience:
* The scroll stays fixed to the bottom of the results, leaving the user with little indication that the content has been updated
* The URL is not updated, so a page refresh after paginating will take the user back to the first page

Let's clean up both of these things now, with some updates to our Javascript.

*themes/one-ring/javascript/scripts.js*
```js
// Pagination
if ($('.pagination').length) {
    var paginate = function (url) {
        $.ajax(url)
            .done(function (response) {
                $('.main').html(response);
                $('html, body').animate({
                    scrollTop: $('.main').offset().top
                });
                window.history.pushState(
                    {url: url},
                    document.title,
                    url
                );    
            })
            .fail(function (xhr) {
                alert('Error: ' + xhr.responseText);
            });

    };
    $('.main').on('click','.pagination a', function (e) {
        e.preventDefault();
        var url = $(this).attr('href');
        paginate(url);
    });
    
    window.onpopstate = function(e) {
        if (e.state.url) {
            paginate(e.state.url);
        }
        else {
            e.preventDefault();
        }
    };        
}

```
First, we'll add an `animate()` method that will handle the automatic scrolling. Then, we'll push some state to the browser history using `pushState`.

Lastly, we make export the `.ajax()` call to a function, so that both the pagination links and the browser back button will be able to invoke it when we add an `onpopstate` event.

### Reapplying plugins

A lot of the UI plugins we're using are applied on document load, which means that when part of the DOM gets replaced, they won't be applied. Notice as you paginated through the results that the "sort by" dropdown degrades back to a standard HTML input. Let's ensure the fancy dropdown gets reapplied.

We'll export the `chosen()` plugin to a reusable function and call it when needed.

*themes/one-ring/javascript/scripts.js*
```js
(function($) {
  var applyChosen = function (selector) {
    if ($(selector).length) {
      $(selector).chosen({
        allow_single_deselect: true,
        disable_search_threshold: 12
      });
    }
  };
  $(function () {

    applyChosen('select');
    
    //...
```

Now, on the successful ajax response, we'll reapply it.

*themes/one-ring/javascript/scripts.js*
```js
  $.ajax(ajaxUrl)
    .done(function (response) {
      $('.main').html(response);
      applyChosen('.main select');

```

### Cache busting
There's one last idiosyncrasy we need to sort out before we can call this finished. Let's just try paginating a few times, and clicking on a non-Ajax link that will take us to another page. Now click the back button. Yikes! We're only getting back the content for the Ajax request. You may not be able to replicate this in all browsers. Google Chrome seems to reliably reproduce the bug, though. So why is this happening?

The short answer is that good browsers like Google Chrome are really, really smart. That's what makes them so fast. In this case, perhaps it's being a bit too smart, but ultimately, we have made a pretty critical mistake.

Earlier in the tutorial, we talked about a common endpoint for standard HTTP requests and XHRs. While it's true that both types of requests should be piped through the same controller action, the idea that they should share exactly the same URL is flawed. One of the pillars of HTTP caching, and the HTTP protocol in general, is that requests should be deterministic. For any given URL, we should expect the same response. When URLs return various responses based on arbitrary external state like session state or, in our case, the type of request, they are no longer deterministic, and bad things can happen, because the browser has cached that URL, believing that it has already seen the response that it generates. This is great for performance, but bad for the type of turnkey functionality we're trying to implement.

We need to update our Javascript so that the Ajax request has a slightly different URL than the URL that is being stored in history. Let's just append a simple `ajax=1` request parameter to the URL.

```js
    // Pagination
    if ($('.pagination').length) {
        var paginate = function (url) {
            var param = '&ajax=1',
                ajaxUrl = (url.indexOf(param) === -1) ? 
                           url + '&ajax=1' : 
                           url,
                cleanUrl = url.replace(new RegExp(param+'$'),'');

            $.ajax(ajaxUrl)
                .done(function (response) {
                    $('.main').html(response);
                    applyChosen('.main select');
                    $('html, body').animate({
                        scrollTop: $('.main').offset().top
                    });
                    window.history.pushState(
                        {url: cleanUrl},
                        document.title,
                        cleanUrl
                    );
                })
                .fail (function (xhr) {
                    alert('Error: ' + xhr.responseText);
                });
        };
```

Let's walk through this.

* First, we generate the `ajaxUrl` variable, is whatever URL the function is given, plus an `ajax=1` parameter. Notice that we have to be careful not to add the `ajax` parameter multiple times. We have to do this because the pagination links preserve all the `GET` parameters from the Ajax request, so they will all contain query strings like `?start=10&ajax=1`.
* Next, we generate the `cleanURL` variable, which is the URL with the `ajax=1` removed. Again, the pagination links all have `ajax=1` on them, so this sanitisation is important.
* We then update the Ajax request to go to the `ajaxUrl` instead of the given URL.
* Lastly, we store the `cleanUrl` in the browser history, so that when the back button is pressed, the browser knows that the Ajax request and the standard request are different.

In order to test this, it is imperative that you clear your browser cache. This whole bug revolves around eager caching, so you won't see any results until you do so. If you're using Google Chrome, you may want to try Incognito Mode for this.

Now the back button is returning the expected result, and things are looking and feeling much better.
