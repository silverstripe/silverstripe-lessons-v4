### Drop your bags

You know that feeling you get when you've been traveling all day, and you finally breach the door to your hotel room? You drop your bags in the first vacant spot you can find, suspending your impending obligation to unpack and get organised, and gift yourself that moment of relaxation.

When migrating a static site into SilverStripe, it is often helpful to follow that same pattern. In this section, we'll drop all of our HTML and other static assets into their own directory so that they are browseable by our web server and living in our project, albeit as poorly assimilated outsiders. Sure, we've still got a lot of "unpacking" to do, but you'll feel better knowing that everything is where it is supposed to be, under one roof.

Let's create a directory called `static/` in our public webroot. Again, this label is entirely up to you, so if it's more meaningful to you to use something like `html/`, or `raw/`, feel free to invoke that option.

Your folder structure should now look like this:

```
app/
  _config/
  src/ 
  templates/
    Includes/
    Layout/

public/
  css/
  images/
  javascript/
  static/
```

Now we'll simply dump the all the contents of our static site ([one-ring-rentals-static.zip](https://github.com/silverstripe/silverstripe-lessons-v4/raw/c22cf8a9c1781b8f85f0675d8bfd07b842eec532/Lesson-02-begin/__assets/one-ring-rentals-static.zip)) into the `static/` folder, preserving the file structure. Since we've used relative paths for all the assets, having the site deep into the directory structure will not break anything.

Let's test it out. Navigate your browser to <http://localhost:8888/static/default.html>, and you should see our home page. Try the same thing for [`home.html`](http://localhost:8888/static/home.html).

### SS-izing

Now that we've dropped our bags and have rewarded ourselves with a quick glimpse of our site in living flesh, it's time to start cutting up our static site into SilverStripe templates.

### Copy and correct

We'll start with `default.html`. This mockup is intended to represent the most basic of page types in our site. As discussed earlier, SilverStripe conventionally purposes the `Page.ss` template for this case. Copy the contents of `default.html` into your `app/templates/Page.ss` file, which currently contains our "Hello, world" proof-of-concept, and reload your site on the base URL (e.g. <http://localhost:8888/>).

Look good? No, it shouldn't. It should look like an unstyled mess. Let's copy over all the static assets into our project. Make the following copies:

| From                   | To                  |
| ---------------------- | ------------------- |
| `public/static/css`    | `public/css`        |
| `public/static/js`     | `public/javascript` |
| `public/static/images` | `public/images`     |
| `public/static/fonts`  | `public/fonts`      |

While the site looks better, a quick glance at the web inspector shows us that there are still a lot of 404s coming through, mostly for our Javascript files. Let's update all the `<script>` tags to point to `javascript` instead of `js/`. For example, `js/common/modernizr.js` becomes `javascript/common/modernizr.js`. Most of these updates are at the bottom of the document.


Everything should be loading correctly now. You can now delete the `public/static` folder, as we don't need it anymore. We have migrated our static document into a SilverStripe theme.
