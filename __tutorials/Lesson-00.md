## Requirements

In order to work with your development environment efficiently you need some tools installed on your client:

* [Visual Studio Code][VSCode] or [VSCodium][VSCodeOS]:  
  The IDE for editing your code.
* [Docker] which can be downloaded [here](https://hub.docker.com/?overlay=onboarding):  
  A service for running containers (sort of tiny virtual machines)

## Creating a project folder

Create a directory in your home called `silverstripe-lessons`. This is where you're going to code, edit and develop your first silverstripe-project.

This folder will be called `project folder` in all following lessons. Please also note, that all further lessons require that you're working in this folder.

## Installing a local web server

SilverStripe is a PHP-based application that connects to a database, so in order to run it, you'll need a web server. You won't want to be doing all of your development on a remote environment, so setting up a local web server is highly recommended. If you're running OSX or Linux, you probably have all the tools you need already installed on your system, but that's not always ideal. Installing your own local web server affords you more granular control over your environment and insulates it from system-level upgrades.

While this tutorial will explain how to run a local web server using Docker, there are several other choices to be aware of on which there will be a brief explanation given later.

### Setting up a docker container

First please make sure you have [Docker](https://www.docker.com/) installed on your client.  
Docker works with so-called "images".
You can consider an image as a building plan for creating a "container".

Containers are small virtual machines which share the operating system with your client which makes them much smaller, faster and more powerful.

#### Setting up an image for SilverStripe

First you need to create an image which provides all components for running SilverStripe (such as php, apache, composer and a bunch of PHP-extensions).

Luckily there is an image available online called `manuth/silverstripe-dev` which provides all components required for running SilverStripe 4.

In your project-folder create a `.devcontainer`-folder. This folder will contain all files and folderys

In the `.devcontainer`-folder create a file called `Dockerfile` with the following content:

```dockerfile
FROM manuth/silverstripe-dev
```

Your docker-image inherits `manuth/silverstripe-dev`, the image mentioned before.

Next you must build your image in order to use it.

```bash
docker build .devcontainer -t silverstripe-example
```

This creates an image named `silverstripe-example`.

#### Runing the container

Next you might want to check whether the container is running correctly.

Create a file called `index.php`:

```php
<?php
    /* If you can read this, PHP is not working */
    echo "PHP is up and running!"
?>
```

Now it's time to create and run a container from our image. You can do so by invoking this command:

```bash
docker run -d -v "$(pwd):/var/www/html" -p 8888:80 --name example silverstripe-example
```

This command...
* Runs the a container called `example` based on the `silverstripe-example`-image
* Mounts the current directory into the `/var/www/html`-directory of the container
* Forwards port `80` of the container to port `8888` of your client

You can now check whether your local web server is working by opening `https://localhost:8888` in your web browser.

After verifying the functionality of your local web server run this command to stop and remove the container:

```bash
docker stop example
docker rm example
```

#### Setting up a docker-environment

You might remember that SilverStripe not only requires a web server but also a database server running MySQL.

Docker provides the functionality to create environments with any amount of docker-containers using `docker-compose`.

In the `.devcontainer`-folder create a file called `docker-compose.yml` with following content:

```yml
version: '3'

services:
  silverstripe:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - 8888:80
    volumes:
      - ..:/var/www/html
  db:
    image: mysql:5
    environment:
      - MYSQL_ROOT_PASSWORD=root
    volumes:
      - ./mysql-data:/var/lib/mysql
```

As you can see this file contains the configuration for the image we just created, as well as configuration for a mysql-container.

The mysql-container will store its mysql-databases at `.devcontainer/mysql-data` and will create a root-user with its password set to `root`.

You can start the docker-environment by invoking this command:

```bash
docker-compose -f ./.devcontainer/docker-compose.yml up -d --build
```

Your web server should be up and running again. You can verify this by opening `http://localhost:8888` in your web browser.

Run this command to stop the docker-environment:

```
docker-compose -f ./.devcontainer/docker-compose.yml down
```

Create a file called `.gitignore` to exclude the `mysql-data` folder from your project:

***.gitignore:***
```ignore
.devcontainer/mysql-data/
```

### Other alternatives

#### Virtualisation

Installing a virtual web server, on your local machine is fast, fairly easy, and eliminates many of the variables and unknowns that are often hazardous to local development. There are two main players in this space:

* [Vagrant](https://www.vagrantup.com/), which runs on top of [VirtualBox](https://www.virtualbox.org/wiki/Downloads), providing you a simple configuration layer and tools for running your virtual machine. There are many pre-cooked environments ready for you to download and consume, such as [Scotch Box](https://box.scotch.io/)
* [Docker](https://www.docker.com/), which creates a "container" for your virtual environment, sharing the same operating system as the the host (your computer).

In general, Vagrant is much easier to set up, but is much more resource intensive as each instance uses its own operating system, while Docker is more difficult to learn and set up, but uses far less resources and runs more efficiently than Vagrant.

#### Create your own

There are a number of tutorials available for assembling your own recipe of Apache, PHP, and MySQL using package managers like [Homebrew](https://brew.sh/) or [Macports](https://www.macports.org/).
* [macOS 10.12 Sierra Apache Setup](https://getgrav.org/blog/macos-sierra-apache-mysql-vhost-apc)
* A [Github Gist](https://gist.github.com/pwenzel/f06419631bd172331281) of setting up a LAMP stack on OSX

#### Turnkey solutions

While less flexible than building an environment from scratch or using a virtual machine, there are some single-click installs that will put a basic server on your workstation. Some of these include:
* [MAMP](https://www.mamp.info/en/)
* [WAMP](http://www.wampserver.com/en/)
* [AMPPS](http://www.ampps.com/download)
* [Uniform Server](http://www.uniformserver.com/).

What these products offer in ease of use and simplicity they revoke in the form of flexibility. They are often pretty rigid and cannot be extended without a lot of work and/or hacking. SilverStripe requires the `php-intl` extension, for instance, which is not included in any of these products.

## Setting up the IDE

You can configure VSCode to run in a docker container.  
Open up VSCode and install the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)-extension.

After that you have to create a `devcontainer.json`-file in your `.devcontainer` folder with following content:

```json
{
    "name": "SilverStripe Development",
    "dockerComposeFile": "docker-compose.yml",
    "service": "silverstripe",
    "workspaceFolder": "/var/www/html"
}
```

That's it!

The only thing that's left to do is opening up your project folder in VSCode by hitting `File` => `Open Folder…`.

Next you must hit the green remote-icon on the bottom left and select `Remote-Containers: Reopen in Container`.

## Introducing Composer

Before we get into installing Composer, we should probably go over what exactly Composer is and how it works.

### What is Composer, and why do I need it?

[Composer](https://getcomposer.org/) is a dependency manager for PHP. Dependency managers are increasingly popular these days, especially for front-end libraries; You may have heard of [NPM](https://www.npmjs.com/). At their most fundamental level, dependency managers are simply abstractions of a source code repository. They obscure all the minute details about where the projects live and what branches are available, and they allow you to simply refer to packages semantically by name and by version number.

A key feature of Composer is that it resolves dependencies. When one module requires one or more other modules in order to work properly, Composer will sort all that out and pull down everything you need. Further, Composer applies version constraints. So if a package requires a module that doesn't work with something you already have installed, it will apprise you of that conflict and halt the installation so that your project doesn't break.

You might be wondering, "Why can't I just go and download the modules and install them manually?" Well, let's use an example SilverStripe project without Composer to illustrate why that isn't always a good choice.

Let's say you want to get a gallery module for your website. You go out to some web page, download it, and drop it into your project. When you try to run the application, the module complains that it's missing the slideshow module, which is integral to the gallery module.


<img width="600" src="https://silverstripe.org/assets/lessons/lessson-0/lesson0-6.png">



Now your project is hosed until you satisfy this dependency. So you go and find the slideshow module, and after some digging you're able to track it down. You drop it in, hoping this will make your gallery module happy.


<img width="600" src="https://silverstripe.org/assets/lessons/lessson-0/lesson0-7.png">




Now we have a new problem. The slideshow module is incompatible with the version of SilverStripe that we're running. You can see where this is going. All the players in your project don't get along, and your website blows up.

Installing packages with Composer solves all these issues because you simply execute a nice, declarative command, asking to install a package and a specific version, and it handles all the orchestration for you.

```
composer require example/some-module
```

This is by no means a magic bullet. You will still have to resolve conflicts, but it will tell you what those conflicts are, and it won't let your project exist in a state with incompatibilities.

### Installing Composer

Though composer is already installed on your container (thanks to `silverstripe-dev`) it might be a good idea to go and grab the most recent version from the internet.

Installing Composer is just a matter of running two commands:

```bash
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
```

These commands might look a little foreign to you if you're new to the terminal. If you need more information, SilverStripe documentation about [Composer](https://docs.silverstripe.org/en/getting_started/composer/).

In VSCode click `Terminal` => `New Terminal…` to open up a shell on your docker container.

Let's run the first command, which installs Composer. It doesn't matter where in the file system we run this command.


<img width="600" src="https://silverstripe.org/assets/lessons/lessson-0/lesson0-8.png">




The second command will move the Composer executable to a place where it's globally accessible, so we can just run Composer anywhere.

### Adding Composer to the image

If you ever re-create your `silverstripe-example` image, which often might be the case, your composer-installation will be undone.

In order to permanentally add composer to your `silverstripe-example` image append these lines to the `Dockerfile` inside the `.devcontainer`-folder:

```dockerfile
RUN curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer
```

Next time you recreate your `Dockerfile` the most recent version of composer will be included.

## Creating a SilverStripe project

Let's create a SilverStripe project using Composer. Because this is a new project, we'll use the `create-project` command and point Composer at the `silverstripe/installer`. We'll specify a project name of *example*.

```bash
composer create-project silverstripe/installer example
```

Composer will now go out and read the SilverStripe installer package. Then, it's going to pull down all the dependencies, including SilverStripe Framework, and several other core modules, along with various supporting PHP libraries. Lastly, it's going to install the default theme that comes with the SilverStripe installer.

### The public/ folder

SilverStripe only exposes a very small slice of your entire project to the web. All of the PHP code, configuration files, templates, and other core files are stored in the project root, which is not web accessible. The actual `index.php` file that renders your website lives in the `public/` folder, along with any and all other frontend depedencies such as CSS, JavaScript, webfonts, and images.


#### Will public/ always be in my URL?

No! SilverStripe is configured to redirect all requests to the `public/` folder.
This is done using the `.htaccess` in the root of your project.

If you're using IIS please make sure you to set the root of your website to `public/`.

In our case, our site lives at `http://localhost:8888/example`.


<img width="600" src="https://silverstripe.org/assets/lessons/4.0/lesson0-10.png">


### Viewing your website

Go to the URL `http://localhost:8888/example`. You should see an install page. It's full of red errors that are telling us that the install isn't going to work, so let's go through this and see if we can sort it out.


### Configuring the installer

One thing that it's complaining about is that there isn't enough information to connect to the database. So let's fill out the database username and password. In many local MySQL installations, the root password is often empty. If that's the case, you probably won't see this error, as no password is the correct password!

If our scenario the server is `db` and both the username and password are `root` and `root`.

Next let's just change the database name to something a little bit more meaningful. We'll call it `SS_example`, because this is the project example.

Lastly, we can create an admin account. Let's specify a password. That'll be the account we use to connect to the CMS. We'll recheck the requirements and install SilverStripe.


<img width="600" src="https://silverstripe.org/assets/lessons/lessson-0/lesson0-11.png">




Now that the installation is complete, SilverStripe is going to prompt you to delete the install files, as they are a security risk. Click on that, and it will authenticate you before moving forward. Provide that admin password you chose earlier.

## Refining your development environment

Now that we've installed SilverStripe, let's finely tune our development environment so we can get things working a little bit faster.

### .env

The main ingredient in environment management in SilverStripe is the `.env` file. This file provides a shared configuration across all your projects through the injection of environment variables. It should contain information such as database credentials, as those are most likely to be shared across all of your local development projects.

It can also include other application settings. You might have API keys or email addresses in there that you want to specify as globally accessible by all projects.

The key attribute of the `.env` file, however, is that it should not ship with the project. It can live outside the web root, outside of source control. When you deploy this project from your local environment to somewhere else, that remote environment should have its own configuration, so having the file outside the project (or at least ignored by your source control system) means you don't have to worry about accidentally overriding settings.

<div class="alert alert-danger">
    The <code>.env</code> file is meant for development environments only. While it could theoretically be used in production this is <em>not</em> recommended, and should only be used as a last resort in hosting environments where setting server level or true environment variables is not an option. Please see the documentation for your web server for more information. E.g. <a href="https://httpd.apache.org/docs/2.4/mod/mod_env.html#setenv">Apache</a>
</div>

In our docker-scernario we can simply add an `environment`-section to our `docker-compose.yml`:

```yml
[...]
  silverstripe:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - SS_DATABASE_CLASS=MySQLPDODatabase
      - SS_DATABASE_SERVER=db
      - SS_DATABASE_USERNAME=root
      - SS_DATABASE_PASSWORD=root
[...]
```

After adding this section to the `docker-compose.yml` you can safely delete `SS_DATABASE_CLASS`, server, username and password from the `.env`-file.

Do that and recreate your docker-containers by bringing VSCode to the front, pressing the green button at the bottom left and hitting `Remote-Containers: Rebuild Container`.

### How .env works

Let's take a look at an example directory structure, where we have an `htdocs` folder, and three example projects underneath it.

```md
* htdocs/ **[ .env ]**
    * project-a/
    * project-b/
    * project-c/
```




With the `.env` file in `htdocs`, the settings will cascade down to project A, B, and C.


You can place an `.env` file in, say project B's project root 'project-b', and it will override the parent `.env` file.

```md
* htdocs/ [ .env ]
    * project-a/
    * project-b/ **[ .env ]**
    * project-c/
```


<div class="alert alert-info">
    The <code>.env</code> file is searched for in the project root, and then its parent directory only. Only the first file found is loaded.
</div>


### Some common configurations

In a typical `.env` file, you definitely want to define the database server, database username and database password. Everything is defined in constants.

Lastly, you'll probably want to define the environment type as *dev*, so you can take advantage of all the debugging tools and get some verbose errors.

*project-folder/.env*
```bash
SS_ENVIRONMENT_TYPE='dev'
```

Let's create a second SilverStripe project. We'll call it *example2*.

```bash
composer create-project silverstripe/installer example2
```

So let's go to that *example2* URL (<http://localhost:8888/example2/>). The install page comes up again, but it looks slightly different.


<img width="600" src="https://silverstripe.org/assets/lessons/lessson-0/lesson0-14.png">



Some of the fields have been populated for you, such as the database username and password, but you still have to provide a database name. Let's use `SS_example2`. Also, provide that admin password again.

Click "Install SilverStripe," and once again, clear out those install files.

### Going further

Let's now take this a step further. There are some more things we want to throw into our `.env` file. We can use `SS_DATABASE_CHOOSE_NAME` to tell SilverStripe to intelligently determine a database name so that you don't have to. It will look at the filesystem, see where the project is installed, and choose a database name based on that. By default this takes the form of e.g. `SS_project-a`, keeping with the examples above.

Also, you can specify the default admin username and password. For local development you're probably not too concerned about security, so having something easy to remember such as *root/password*, is just fine as long as the password has **at least 8 characters**.

*project-folder/.env*
```php
SS_ENVIRONMENT_TYPE='dev'
SS_DATABASE_CHOOSE_NAME=true
SS_DEFAULT_ADMIN_USERNAME='root'
SS_DEFAULT_ADMIN_PASSWORD='password'
```
Another setting you might want to turn on is `SS_SEND_ALL_EMAILS_TO`. If you provide your email address here it will force all emails to go to you, instead of to the places that your application might be sending them, which could include a client or anyone else who you don't want getting your tests. By applying this setting, it will force email to go to you, no matter what to address you've specified, so that's very useful in development mode.

For a full list of settings you can go to the docs and just look up [environment management](https://docs.silverstripe.org/en/4/getting_started/environment_management) There are probably a dozen or so other settings you can throw in here. Some are more useful than others. Have a quick look through there because you might find something that's really useful to you.

Let's save the changes to `.env`, and apply those new settings.

Lastly let's create third SilverStripe project called `example3`:

```bash
composer create-project silverstripe/installer example3
```

When we go to the `http://localhost:8888/example3/public` URL, you'll notice that we bypass the install page. That's because SilverStripe has learnt everything it needed to know about running this project from `.env`.

This is a really quick way to light up a project and do some testing. You can just throw this project away when you're done and do it again, and you don't have to go through that install process every single time. `.env` comes in really useful here, as it applies all the settings you want for every single project.

We're now off and running with a local development environment for SilverStripe development.

[Get started building your first SilverStripe website](learn/lessons/creating-your-first-theme) with our series of lessons.

## Cleaning up

In order to get ready for the next lesson you need to clean up your project-folder.

1. Delete following files and folders:
    * `example2`
    * `example3`
    * `.env`
    * `.gitignore`
    * `index.php`
2. The only remaining folders should be `.devcontainer` and `example`.
3. Move the contents of `example` to your project-folder.
4. Delete the `example` folder
5. Add following line to the `.giticnore` file:
    ```ignore
    .devcontainer/mysql-data/
    ```

<!--- References -->
[VSCode]: https://code.visualstudio.com/
[VSCodeOS]: https://vscodium.com/
[Docker]: https://www.docker.com/
