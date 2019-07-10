### What are extensions?

By definition, an extension is any subclass of the `SilverStripe\Core\Extension` core class in SilverStripe. In practice, however, it's a modular bit of code that can be injected into one or many other classes. The word "extend" might make you think of subclassing, but extensions are actually quite different from subclasses. Subclasses inherit all methods and properties from their one-and-only parent class. Extensions, on the other hand, supply a set of methods that can be "magically" added to other classes. I use the word "magically" because extensions don't inject any hard code into your class definition. The methods are added at runtime. You can also go a step further and add properties to models which are derived from `SilverStripe\ORM\DataObject` by using the `SilverStripe\ORM\DataExtension` class. For the rest of this lesson we'll focus on the `SilverStripe\ORM\DataExtension` class.

The simplest case for an extension is whenever you're writing identical or nearly identical functionality in multiple classes. Imagine that you have a website for a business that displays all of its stores on a Google map. It also has events, which happen at specific places, and can be put on a map. Both of these classes need to have code similar to this:

```php
    private static $db = [
      'Address' => 'Varchar',
      'City' => 'Varchar',
      'Country' => 'Varchar(2)',
      'Postcode' => 'Varchar(5)',
      'Latitude' => 'Decimal(9,5)',
      'Longitude' => 'Decimal(9,5)',
    ];

    public function getFullAddress()
    {
        //...
    }

    public function geocodeAddress()
    {
        //....
    }
```

You could put all of this in a parent class and your `Event` and `Store` data objects inherit from it, but that's not very practical or logical. Other than the business rule that says they both need to go on a map, there's no really good reason to put both of these classes in the same ancestry. Further, if the two classes don't share the same parent, the whole model falls apart.

So what do you do? Put all the shared code in an extension and apply that extension to every class that needs it. That way, you don't have to repeat yourself, and it becomes inexpensive to make any DataObject mappable.

Some other examples might include adding functionality to send an email to an administrator after a given record is updated, or adding features that integrate a record with social media APIs. There are many good reasons to use extensions, and any decent sized SilverStripe project is bound to have a few in play.

A helpful metaphor to help distinguish between extensions and that subclasses are about _vertical_ architecture, and extensions are about _horizontal_ architecture. If you've done a lot of CSS, you're probably familiar with this design pattern. Think about the difference between the following:

```html
    <ul class="notifications">
        <li class="notification">Some text here</li>
    </ul>

    <div class="actions">
        <a class="action">Do this</a>
    </div>
```

```css
    ul.notifications li.notification, .actions a.action {
        background: red;
        color:white;
    }
```
Versus using a more horizontal pattern:

```html
    <ul class="notifications">
        <li class="notification alert">Some text here</li>
    </ul>

    <div class="actions">
        <a class="action alert">Do this</a>
    </div>
```

```css
    .alert {
        background: red;
        color: white;
    }
```

By injecting style through a separate class, we can effectively "tag" our element as having a specific set of traits, rather than relying on the inheritance chain to target the element in a specific case. You can think of data extensions in SilverStripe as giving you the option of mixing multiple PHP classes together.

### Extensions vs. other approaches

If you've ever used Ruby on Rails, or perhaps more popularly, LESS, you've probably already identified this familiar concept as a "mixin," and that is an accurate assessment. SilverStripe extensions are very similar to mixins. They're single-purpose bundles of functionality that augment existing code.

Further, if you're fairly well-versed in PHP, you might be wondering why SilverStripe has reinvented the concept of _traits_, offered natively in PHP since its version 5.4 release. You're certainly not far off, but there are a few good reasons why SilverStripe uses its own extensions pattern rather than PHP traits.

The first reason is simple history. The open-source release of SilverStripe predates PHP 5.4 by about seven years, so to some extent, extensions were built into the SilverStripe codebase as a long-standing workaround for a shortcoming in PHP.

Further, there are some SilverStripe idiosyncrasies that are not easily replaced by traits, such as the way arrays are merged rather than overloaded by subclasses, and the use of extension points, which we'll look at later in this tutorial.

Most importantly, however, extensions have one major advantage over PHP traits: they can be applied to classes that are outside the user space. That is to say, you can make changes to core classes without actually altering the source code. To reference our last example, it's easy to imagine adding mapping functionality to the `Event` and `Store` classes that live in our project code, but what if we wanted to add features to the core `File` class, or change the behaviour of a specific CMS controller? You wouldn't be able to assign the trait without altering the core class definition, and of course, we don't want to do that, because it will break when we upgrade.

You might wonder why we couldn't just create our own subclass of `SilverStripe\Assets\File` to add new features to it. We could do that, and it would work just fine in our own project, but the problem is, everyone else -- the CMS and all your modules -- aren't going to know about your special class. They're all still using `SilverStripe\Assets\File`. So if you want a global change, a subclass isn't a very good option. (You could use [dependency injection](http://doc.silverstripe.org/en/developer_guides/extending/injector/) to force your subclass, but that's a more advanced topic that we'll cover later.)

### Extension gotchas

We've established that extensions are somewhat of a workaround for functionality that is not offered natively by PHP, so there are bound to be a few tradeoffs and things we need to be aware of when working with extensions.

#### The "overloading" gotcha

The most common misconception about using extensions is that they can overload methods like subclasses. This is _not the case._ Let's say you want to update the `getMemberFormFields()` method of the `SilverStripe\Security\Member` class so that it pings a thirdparty service, so you write something like this:

```php
use SilverStripe\ORM\DataExtension;

class MyMemberExtension extends DataExtension
{

    protected function apiCall()
    {
        //.. call API here...
    }

    public function getMemberFormFields()
    {
       $someData = $this->apiCall();
       //... get normal fields, and add $someData
    }
}
```

This won't work. When an extension method collides with the class its extending, the native method always wins. You can only inject _new_ functionality into a class. You can't overload it like you do with a subclass.

Fortunately, to address this, SilverStripe offers **extension points**. Extension points are created when the class being extended invokes the `$this->extend()` method and hands off the execution to any and all extensions of the class, providing any references that the extension may want to use.

Let's look again at our login method. In `framework/src/Security/Member.php`, we can see that the `getMemberFormFields()` method we're trying to update offers an extension point:

```php
      public function getMemberFormFields()
      {
        //... build form fields
        $this->extend('updateMemberFormFields', $fields);        
      }
```

Given this knowledge, we could write our extension to use either of those two hooks.

```php
use SilverStripe\ORM\DataExtension;

class MyMemberExtension extends DataExtension {

    protected function apiCall()
    {
        //.. call API here...
    }

    public function updateMemberFormFields($fields)
    {
       $someData = $this->apiCall();
       $fields->push(HiddenField::create('SomeData', null, $someData));
    }

}
```
Think of `$this->extend()` as an event emitter, and the extension classes as event listeners. Extension points aren't offered everywhere, but they do appear in most of the areas of the codebase that you'd want to enhance or modify. As a module developer, it's very important to offer extension points so that others can make customisations as they see fit.

#### The "owner" gotcha

Let's look again at our API call. Suppose the API requires a parameter to define the request, such as the user's full name.

```php
use SilverStripe\ORM\DataExtension;

class MyMemberExtension extends DataExtension {

    protected function apiCall()
    {
        $myAPIClient->getUser($this->getName());
    }

    public function updateMemberFormFields($fields)
    {
       $someData = $this->apiCall();
       $fields->push(HiddenField::create('SomeData', null, $someData));
    }

}
```

This is imaginary code, so we'll spare ourselves the trouble of running it. The result would be something like this: ` Fatal error: The method getName() does not exist on MyMemberExtension `

How could that be? Member has the method `getName()`, right? Well, remember, we're not dealing with a subclass. We haven't inherited that method in our extension. This class runs parallel to the `SilverStripe\Security\Member` class, not beneath it.

Surely we'd want access to all those methods in our extension, and for that, SilverStripe provisions us with a property called `owner`, which refers to the instance of the class we're extending. To make this work, simply invoke `$this->owner->getName()`.

```php
    protected function apiCall()
    {
        $myAPIClient->getUser($this->owner->getName());
    }

```

Here is my promise to you: you will, with 100% certainty, forget about this idiosyncrasy multiple times in your SilverStripe projects. Everyone does. It's an antipattern, it's weird, it's easy to forget, and it's just one of those pitfalls you have to be aware of when working with extensions. So take a deep breath. Embrace it. You'll learn to love that error screen.

### Building and applying an extension

Believe it or not, we're actually going to write some code now. One of the most common extensions you'll want to write is one for the `SilverStripe\SiteConfig\SiteConfig` class. SiteConfig is a bit of an anomaly. It's a single-record database table that stores all of your site-wide settings, as seen on the _Settings_ tab in the CMS. By default, SiteConfig gives you fields for the `Title`, `Tagline`, along with some simple global permissions settings. Invariably, you'll want to extend this inventory of fields to store settings that relate to your project.

We're primarily looking for data that appears on every page, so the header and footer of your site are great places to look for content that might be stored in SiteConfig. In our footer, we have some links to social media, and a brief description of the site over on the left. Let's throw all this into SiteConfig.

#### Defining an extension class

If your extension is going to be used to augment a core class, like SiteConfig, the convention is to use the name of the class you're extending, followed by "Extension."

_app/src/SiteConfigExtension.php_
```php
namespace SilverStripe\Lessons;

use SilverStripe\ORM\DataExtension;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\TextareaField;

class SiteConfigExtension extends DataExtension
{

    private static $db = [
        'FacebookLink' => 'Varchar',
        'TwitterLink' => 'Varchar',
        'GoogleLink' => 'Varchar',
        'YouTubeLink' => 'Varchar',
        'FooterContent' => 'Text'
    ];

    public function updateCMSFields(FieldList $fields)
    {
        $fields->addFieldsToTab('Root.Social', array (
            TextField::create('FacebookLink','Facebook'),
            TextField::create('TwitterLink','Twitter'),
            TextField::create('GoogleLink','Google'),
            TextField::create('YouTubeLink','YouTube')
        ));
        $fields->addFieldsToTab('Root.Main', TextareaField::create('FooterContent', 'Content for footer'));
    }
}
```
We define a method for one of the most used extension points in the framework, `updateCMSFields`, which is offered by all DataObject classes to update their CMS interface before rendering. Notice that we don't have to return anything. The SiteConfig class will do that for us. Right now, we're just updating the object it passed us through `$this->extend('updateCMSFields', $fields)`. Since objects are passed by reference in PHP, we can feel free to mutate that `$fields` object as needed.

#### Registering your extension in the config

To activate our extension, we need to apply it to the `SilverStripe\SiteConfig\SiteConfig` class. This is done through the Config layer.

_app/_config/app.yml_
```yaml
    SilverStripe\SiteConfig\SiteConfig:
      extensions:
        - SilverStripe\Lessons\SiteConfigExtension
```
Because we changed the config, we have to flush the cache. Build the database using `dev/build?flush`. You should see some new fields.

Now access the Settings tab in the CMS and populate the fields with some values.

Lastly, we'll update our template to use the new fields. All `Page` templates are given a variable called `$SiteConfig` that accesses the single SiteConfig record. Since we'll be getting multiple properties off that object, this is a great opportunity to use the `<% with %>` block.

_app/templates/Includes/Footer.ss_ (line 78)
```html
<ul class="social-networks">
  <% with $SiteConfig %>
    <% if $FacebookLink %>
      <li><a href="$FacebookLink"><i class="fa fa-facebook"></i></a></li>
    <% end_if %>
    <% if $TwitterLink %>
      <li><a href="$TwitterLink"><i class="fa fa-twitter"></i></a></li>
    <% end_if %>
    <% if $GoogleLink %>
      <li><a href="$GoogleLink"><i class="fa fa-google"></i></a></li>
    <% end_if %>
    <% if $YouTubeLink %>
      <li><a href="#"><i class="fa fa-youtube"></i></a></li>    
    <% end_if %>
  <% end_with %>                                
</ul>
```
We've skipped over Pintrest, as it probably wouldn't apply to this business. We'll cover RSS in another tutorial, but either way, it won't be a site-wide RSS feed, so we can remove that button, as well.
