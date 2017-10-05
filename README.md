In this tutorial, we’ll cover how to build your first theme in SilverStripe. The SilverStripe installer ships with its own default theme -- _Simple_, but it's more likely you’ll want to override this to use your own custom design.

### What is a theme?

In a conventional SilverStripe project, the code and business logic (backend) of a website is kept separate from the UI and design elements (frontend). More specifically, PHP classes and configuration files are kept in the **project directory**, while templates, CSS, images, and Javascript are kept in the **theme directory**.

In a default installation of SilverStripe, your project directory is called **mysite/**, and lives in the web root. Your theme directory, however, will be located one level deeper, under the **themes/** folder. Because the code layer is detached from the UI, a given project can have multiple themes.

### Building the theme structure

Let’s create our first theme by creating a new folder under **themes/**. The folder name is arbitrary, but must be comprised of only alphanumeric characters, dashes, or underscores. In this lesson, we’ll call the folder **one-ring/**, which refers to the name of our website, but feel free to choose any name you like. Remember the name you choose, as we’ll need to refer to it later.

Underneath your new theme folder, you’ll need to create some new folders, so that your theme has the following structure:

*   themes/
    *   one-ring/
        *   css/
        *   images/
        *   javascript/
        *   templates/
            *   Includes/
            *   Layout/

Most of these folders are self-descriptive, but note that the only folders with compulsory names are `templates/` and `css/`. The `images/` and `javascript/` folders can be named anything you like. In fact, they can even remain absent if you don’t have anything to put there. Further, feel free to add any other folders you like, and subfolders thereof (i.e. a `less/` or `scss/` folder).

Next we’ll create the most fundamental component of a theme -- a template. In SilverStripe, templates are not HTML documents, but rather PHP code that is compiled from SilverStripe’s own template syntax behind the scenes. In alignment with that key that distinction, it is imperative that template files use the `.ss` extension.

In your `templates/` directory, create a file called `Page.ss`. Inside that file, create a basic HTML document.

```html
<html>
  <body>
    <h1>Hello, world</h1>
  </body>
</html>
```

Why `Page.ss`? A default installation of SilverStripe ships with a page type called `Page`. Typically, this page type is used to display the most basic form of content for a project. A common use case is for the “About Us” page, or even something more plain, like “Terms and Conditions.”

### Activating the theme

To activate the theme, we’ll have to dig into the project directory. Open the file `theme.yml` in the `mysite/_config` directory. Under the heading `SilverStripe\View\SSViewer`, take note of the setting for `themes`, and change it to include your theme name. In this case, we named our theme **one-ring**, so our new configuration file will look like this:

```yaml
SilverStripe\View\SSViewer:
  themes:
    - 'one-ring'
    - '$default'
```

In this configuration file, the theme `one-ring` is given the highest priority. If a template can't be found in that theme, SilverStipe will continue working down the list, trying each theme until it finds a match. As a fallback, you'll want to have `$default` as the last entry in your list to ensure the base templates get loaded.

These files are written in YAML, which is a markup language, similar to JSON or XML, that is very [well-documented](https://github.com/Animosity/CraftIRC/wiki/Complete-idiot%27s-introduction-to-yaml). Configuration is a very rich topic in SilverStripe that we’ll cover in later tutorials, but for now, the only important bit you need to know is that any changes you make to these files have to be cleared from cache. To clear the cache, simply access any page on your site and append ?flush to the URL, e.g. `http://{your localhost}/tutorial/?flush`

Once the page is loaded, you should see your “Hello, world” page template. At this time, you can feel free to delete the “simple” theme from your themes directory, as we have now branched out on our own.