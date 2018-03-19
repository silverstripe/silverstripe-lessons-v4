### Adding primary navigation

To create our main menu, we'll use a global method that SilverStripe provides to all your templates: the `$Menu` function. `$Menu` returns a list of all the pages in a given section of the site. Because it returns a set rather than a single value, we'll need to loop through the result to create a menu of varying length. Inside the `<ul>` tag that wraps the primary navigation, remove the hardcoded `<li>` tags and add the following syntax:

```html
<% loop $Menu(1) %>
  <li><a class="$LinkingMode" href="$Link" title="Go to the $Title page">$MenuTitle</a></li>
<% end_loop %>
```

Let's examine what each piece of syntax does:

**<% loop $Menu(1) %>** Begins a loop through all the menu items, repeating all the HTML that is in the loop for each one. By passing (1) as an argument, we are asking the CMS to give us all the pages at level 1 of the hierarchy. Changing that to (2) would give us all the pages at the second level of the hierarchy in the current section, and so on.  

**$Link** The link to the page in the current iteration of the loop. 

**$Title** The title of the page in the current iteration of the loop

**$MenuTitle** SilverStripe distinguishes between the title of a page (i.e. in your `<h1>` tag) and the title that should appear in the context of navigation. Often times these are the same, but since the user is given the option to customise the title in menus, we use the $MenuTitle variable here.

**$LinkingMode** A helper method that indicates the state of our menu. For each item in the list, this method will return one of three strings:

*   **link**: the page is not active
*   **current**: this is the current page
*   **section**: the current page is a descendant of this page (i.e. on the URL `/about-us/company`, the "company" page is current, and the "about-us" page is "section."

Refresh the page. You should now see the three default pages SilverStripe creates for you in the primary navigation: Home, About Us, and Contact Us.

### Adding a base URL

Let's try navigating to one of the pages, say, "About Us." The site breaks! What's going on here?

Taking a look at the web inspector again, you'll see that the browser is looking for our assets in the wrong place (`about-us/themes/one-ring/`). We've used relative paths for everything, so we need to insure that all the assets load relative to our project root. We could use a leading slash ("/") for this, but if you're working in a subdirectory of localhost (e.g. http://localhost) that will look too far up the tree.

For this reason, it's strongly recommended that you add a `<base />` tag to the head of your document in all templates. Fortunately, there's an easy helper tag provided by SilverStripe to give you exactly what you need. Simply add the syntax `<% base_tag %>` to the top of your `<head>` section.

Reload the page, and things should look a bit less insane now.

### More common template variables

Now that we have a coherent, navigable set of templates, we can start adding some more template variables that are common to all pages.

We can start with our meta tags. While it is highly likely that you'll want to have a granular level of control over these, SilverStripe does offer the helper method `$MetaTags` that we recommend using. It outputs some boilerplate tags, including the character set, generator, as well as contextual metadata that is pulled from the CMS, such as the page description. By default, this method will include the `<title>` tag, as well, but if you'd prefer something more custom, simply use `$MetaTags(false)` to suppress it. Keep in mind that you're free to augment these meta tags with anything else you like. They're merely used to get you started.

Let's remove the "charset" meta tag along with the `<title>` tag, and replace them with `$MetaTags`. We'll leave the "viewport" meta tag, as we need that for our responsive design.

Next let's look at the main content area, where most of our page content will display. We can update our `<h1>` tag to use the `$Title` variable. This will pull in the current page title as it is defined in the CMS.

Below that, we have some breadcrumbs hardcoded into the template. This is likely to be an area of your design that you want to customize, but for now, we'll use the magic variable `$Breadcrumbs` to output of string of rich text representing the breadcrumbs. In later tutorials, we'll cover how to customize the output of this method.

Replace the contents of `<div class="breadcrumb" />` with `$Breadcrumbs`.

The most important section of our page is the main content area. In our mockup, we have a few paragraphs of lipsum text that we can remove in favor of pulling real content from the CMS. In SilverStripe, the `$Content` variable refers to the main body of content added to the rich text editor when editing a page.

Replace the contents of `<div class="main col-sm-8" />` with $Content.

Alongside the content, we have a sidebar that contains subnavigation. Earlier in this tutorial we created a loop for primary navigation using `$Menu(1)`. Similarly, we can create subnavigation using `$Menu(2)`. We don't want to include this block of content unless subnavigation exists, so we'll wrap the whole thing in an `<% if $Menu(2) %>` block.

Replace the contents of the sidebar as follows:

```html
<% if $Menu(2) %>
  <h3>In this section</h3>
    <ul class="subnav">  
      <% loop $Menu(2) %>
        <li><a class="$LinkingMode" href="$Link">$MenuTitle</a></li>
      <% end_loop %>
    </ul>
<% end_if %>
```

Let's look quickly at the login page to the CMS by accessing the `/admin/` URL. Notice that we're not presented with any login form. In order to get the form to show, we'll need to add a `$Form` variable, which primarily serves as a placeholder for the login form. SilverStripe doesn't have a custom template for the login form by default. Instead, it injects it into your default page type. We want to make sure it is positioned in a place that makes sense.

Add a `$Form` variable below `$Content`.

Lastly, our template uses the convention of a hyperlinked logo to go to the home page. In the static markup, we have a hardcoded link to `index.html`. We want to make sure this links to the base URL of our website. Let's use the `$AbsoluteBaseURL` variable in the link around the logo.