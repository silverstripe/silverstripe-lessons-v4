### What we'll cover
* What are controller actions, and how are they used?
* Create a controller action to render a DataObject
* Rendering a DataObject as a page
* Adding pseudo-page behaviour to a DataObject

### How controller actions work

Up to this point in our project, for the most part, every page has been on a single URL, which that URL points to a single controller, which renders a single `$Layout` template. However, if you think back to our lesson on forms, you may remember that we were able to extend the URL route for our controller in order to generate and render a form. We did this using a controller action. Forms are just one of many use cases for a controller action.

Using controller actions is simple. All we're talking about is appending a URL part to an existing URL that matches the name of a publicly accessible method on the controller. Let's give it a try.

For this example, we're going to look at our Regions page. You'll see that it resolves to `http://[your base url]/regions`. Try appending a new segment to the URL, like `http://[your base url]/regions/test`. Not surprisingly, we get a 404.

#### Breaking down the request 

The reason why we get a 404 might surprise you. Let's take a look behind the scenes and see how SilverStripe is resolving this. Using the same URL, append `?debug_request`.

Let's take a look at what's going on here.

`Testing '$Action//$ID/$OtherID' with 'test' on SilverStripe\Lessons\RegionsPageController`

Right out of the gate, we can see that SilverStripe resolved our URL to `RegionsPageController`, which may come as a surprise, since the URL for this page does not include `/test/`, but what has happened is that the request handler has found a match for the URL and will assume that from this point forward, everything in the URL is a parameter being passed to the controller. By default, a controller gives you three extra parameters to pass beyond its base url, as we can see in our debug output.

* **`$Action`**: Immediately follows the URL. In this case our action is `test`.
* **`$ID`**: An ID that the controller action may want to use. This value does not have to be numeric. It's arbitrary, and just named `ID` because that's a common use case.
* **`$OtherID`**: Same as `ID`. You get two. 

You're not limited to this signature of parameters. In future lessons, we'll look at creating custom URL rules, but by default, this is what you get, and it's often all you need.

Let's look at the next line of debug output.

` Rule '$Action//$ID/$OtherID' matched to action 'handleAction' on SilverStripe\Lessons\RegionsPageController. Latest request params: array ( 'Action' => 'test', 'ID' => NULL, 'OtherID' => NULL, )`

So here we are. The request handler actually did match the `$Action/$ID/$OtherID` pattern, and it's trying to resolve our action, `test`. In the rest of the output, you can see that it fails to do that, and it renders an ErrorPage.

Why did it fail? As we said before, the `$Action` parameter should represent a publicly accessible function on the controller. We have no method called `test` right now.

Let's add that controller method now.

*mysite/code/RegionsPage.php*
```php
namespace SilverStripe\Lessons;

use PageController;

class RegionsPageController extends PageController
{

  public function test()
  {
		die('it works');
	}
	
}
```

#### Allowed actions

Now try accessing the URL `/regions/test`. It still 404s. What's going on here?

If you recall from our Lesson 11 tutorial on forms, we're not quite done yet. We have to whitelist the `test` method as one that can be invoked through the URL. You can imagine the security risk that would be imposed by allowing all public methods on a controller to be invoked arbitrarily in the URL. We don't want that. By default, no methods are allowed to be called through controller actions. You need to specify a list of those that are in a private static variable called `$allowed_actions`.

```php
namespace SilverStripe\Lessons;

use PageController;

class RegionsPageController extends PageController {

	private static $allowed_actions = [
		'test'
	];
	
	public function test()
	{
		die('it works');
	}

}
```

`$allowed_actions` can actually get quite complex. You can map these methods to required permission levels, and even custom functions that evaluate whether they should be accessible at runtime, which is really useful for complex controllers. In this case, we just want to make sure anyone can invoke the `test` action. 

Refresh the page with a `?flush`, as we changed a private static variable. Now it works.

### Creating a controller action to render a DataObject

The most common use for a controller action is to assign a URL to a DataObject that is nested in a Page, and this is, in my opinion, one of the first milestones of becoming a skilled SilverStripe developer.

We know that DataObjects are more primitive than Page objects. They contain none of the functionality for rendering a template, they have no `Link()` method, no meta tags, no controllers, etc. In short, they're not meant to be rendered as full pages. That doesn't mean, however, that you cannot assign them some of the properties necessary to do so. In fact, it often makes a lot of sense to.

Let's keep the focus on our RegionsPage. We have a list of `Region` DataObjects that are related to the page via `has_many`. We want to create a detail view for each one of the regions in our list. The user should be able to click on one of the regions and see more information.

This isn't an ideal use case for a DataObject as a page. These Region objects could just as well be pages in the site tree. It often comes down to a judgment call for the developer, guided by what will work best for the content editor. In a future tutorial, we'll look at creating a detail page for our `Property` DataObject, which, due to their volume, will be much more effective than managing them as pages.

#### Adding a Link() method

We can start with the most fundamental requirement. Regions should be able to produce a distinct link to their detail page. Let's add a `Link()` method to each Region. We'll have it invoke a controller action that we have not yet defined.

```php
namespace SilverStripe\Lessons;

use SilverStripe\ORM\DataObject;

class Region extends DataObject
{
  //...
	public function Link()
	{
		return $this->RegionsPage()->Link('show/'.$this->ID);
	}
}
```

We get the `RegionsPage` that owns this Region via the `has_many` / `has_one` parity, and call its link method. We pass in some extra URL segments we want appended to its link. We specify an `$Action` of *show* and an `$ID` that represents the Region's ID.

Now that we have that method, we'll apply it to the template. Change all the hash (#) links to `$Link`.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/RegionsPage.ss*
```html
<% loop $Regions %>
<div class="item col-md-12"><!-- Set width to 4 columns for grid view mode only -->
	<div class="image image-large">
		<a href="$Link">
			<span class="btn btn-default"><i class="fa fa-file-o"></i> Read More</span>
		</a>
		$Photo.CroppedImage(720,255)
	</div>
	<div class="info-blog">
		<h3>
			<a href="$Link">$Title</a>
		</h3>
		<p>$Description</p>
	</div>
</div>
<% end_loop %>
```
Give it a try. Click on one of the regions. The expected result should be a 404.

#### Getting the DataObject in the action

Fortunately, we know how to fix this 404 now. Let's create a `show` method in `RegionsPageController` and whitelist it in `$allowed_actions`.

```php
// ...
use SilverStripe\Control\HTTPRequest;

class RegionsPageController extends PageController
{

	private static $allowed_actions = [
		'show'
	];

	public function show(HTTPRequest $request)
	{
		
	}

}
```

We're not doing anything new here, other than ensuring that the `show` method gets its `HTTPRequest` argument. We'll need that object for getting the ID.

Now that we have the skeleton of how this is going to work, we'll build out the `show` method to fetch and return the Region being requested.

```php

	public function show(HTTPRequest $request)
	{
		$region = Region::get()->byID($request->param('ID'));

		if(!$region) {
			return $this->httpError(404,'That region could not be found');
		}

		return [
			'Region' => $region
		];
	}

}
```

This should be pretty intuitive, but let's walk through it.
* We get the region by the ID contained in the `ID` request parameter. If that parameter is null, we don't have to worry. The `byID()` method fails gracefully.
* If a region doesn't exist, return a 404.
* Return a new variable, `$Region` to the template. (we'll deal with this next)

### Rendering a DataObject as a page

As we saw in the debug output of the request handler, the `$Action` parameter maps to a method called `handleAction` on our controller. While our action method itself is designed to do everything it needs to do, the `handleAction()` method that invokes this method is somewhat opinionated. Specifically, it will automatically select a template for us, unless we declare otherwise.

A controller action will try to render a template following the naming convention ``[PageType]_[actionName].ss``. In our case, that gives us `RegionsPage_show.ss`. Let's create that template.

Copy your `themes/one-ring/templates/Layout/Page.ss` to `RegionsPage_show.ss` in the same location. Remove the `<div class="main ...">` block, and in its place, render some content from the `$Region` object we passed. This is a great opportunity to use the `<% with %>` block.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/RegionsPage_show.ss* (line 5)
```html
<div class="main col-sm-8">
	<% with $Region %>
		<div class="blog-main-image">
			$Photo.SetWidth(750)
		</div>
		$Description
	<% end_with %>
</div>
```

Try clicking on a region now and see that you get its detail page.

One thing that's a bit odd right now is that the `$Description` field is presented exactly the same way on the list view as it is on the detail view, which makes this click effectively pointless. Let's update the `Region` DataObject to store its `Description` field as an `HTMLText` field so that it could conceivably be much longer.

*mysite/code/Region.php*
```php
namespace SilverStripe\Lessons;

use SilverStripe\ORM\DataObject;

class Region extends DataObject
{

	private static $db = [
		'Title' => 'Varchar',
		'Description' => 'HTMLText',
	];
```

Run `dev/build`.

We'll also need to update the CMS field for `Description`.

```php
	public function getCMSFields()
	{
		$fields = FieldList::create(
			TextField::create('Title'),
			HtmlEditorField::create('Description'),
			$uploader = UploadField::create('Photo')
		);
    //...
  }
```

Now on `RegionsPage.ss`, let's just use `$Description.FirstParagraph`.

### Adding pseudo-page behaviour to a DataObject

There are still a few things missing from making this DataObject really feel like a page. The most glaring problem is that the title of the page is still *Regions*, rather than the more appropriate title of the Region we're looking at. Normally, we'd find the `$Title` variable in our template and simply change it to `$Region.Title`, but that variable doesn't live in the `RegionsPage_show.ss` template, so we'll need to override it in the controller.

#### Overloading model properties in the controller

Remember the array we passed to the template containing our custom variable `$Region`? We can use that to overload properties that the template would normally infer from the model. Let's add `Title` to that list.

*mysite/code/RegionsPage.php*
```php
	public function show(HTTPRequest $request)
	{
    //...
		return [
			'Region' => $region,
			'Title' => $region->Title
		];
	}
```

Refresh the page and see that we get a new title.

While the new title is showing on the page itself, it is not affecting the `<title>` tag. That's because, back in Lesson 3, we handed over control over the title tag to `$MetaTags`. Back in that lesson, we discussed the option to pass a parameter of `false` to the `$MetaTags` function to suppress the title tag, and customise it as we see fit. Let's do that now.

*themes/one-ring/templates/Page.ss* (line 8)
```html
	$MetaTags(false)
	<title>One Ring Rentals: $Title</title>
```
Refresh the page, and see that the title tag is now working.

#### Creating peer navigation

Another enhancement we can make is the perception of hierarchy. We can use our subnavigation section to display all the peer regions, with some state applied to the current one.

*themes/one-ring/templates/SilverStripe/Lessons/Layout/RegionsPage_show.ss* (line 15)
```html
<div class="sidebar gray col-sm-4">
	<h2 class="section-title">Regions</h2>
	<ul class="categories subnav">
		<% loop $Regions %>
			<li class="$LinkingMode"><a class="$LinkingMode" href="$Link">$Title</a></li>
		<% end_loop %>
	</ul>
</div>
```

Remember that, even though the content is all driven by the `Region` object, we're still in the scope of `RegionsPageController`, so we step into `<% loop $Regions %>` to get that `has_many` relation that we also use on list view.

Refresh the page and see that the regions are now all displaying.

#### Adding navigational state

We're still missing the "current" state for the region. That's because the method `$LinkingMode` doesn't exist on a DataObject by default, so we need to write our own.

*mysite/code/Region.php*
```php
//..
use SilverStripe\Control\Controller;

class Region extends DataObject
{
  //...
  
	public function LinkingMode()
	{
		return Controller::curr()->getRequest()->param('ID') == $this->ID ? 'current' : 'link';
	}
}
```
Remember that we're in the context of a simple DataObject here, so we don't have any awareness of the request. `Controller::curr()` is a useful method that gets us the currently active controller. Off that object, we can get the request object that has been assigned to it, and look for `->param('ID')`, the same way we did in our `show()` action. If the ID in the URL matches this region, we return `current`, otherwise we return `link`. We don't have to worry about `section` for something this simple.

Refresh the page and see that the current region is now indicated.