* An overview of environments
* Setting up logging on different environments
* Dealing with email

## An overview of environments

So far we've been working on our project only in the context of a development environment, but it's important to consider that we're eventually going to want to deploy to a remote test environment, and hopefully soon after, a production website. A given project can have many environments, especially large projects that are entertaining multiple, concurrent development efforts. Each environment introduces new state, and managing that state can be really cumbersome if you don't have a solid set up. Therefore, it's important to start considering your environments early on in your development process.

We've already talked a bit about the centrepiece of environment management in SilverStripe, the `.env` file. Just as a reminder, this file is intended to reside above the web root to provide environment-specific variables to the project. This allows you to deploy one coherent codebase to each environment without having to write conditional logic to serve each environment. It does introduce the complexity of needing a higher level of write access to your server, however, so you'll want to make sure you have shell access or a highly privileged FTP account that will allow you to edit files above the web root.

## Setting up logging on different environments

One of the services you'll want enabled on test and, even more so, production, is good error logging and notification. In our dev environment, we want to suppress this, as we don't mind getting verbose errors, but once the project is on the web, you'll want to suppress showstopping errors as much as possible and simply log them out so you can proactively fix them.

As of version 4.0, SilverStripe uses the [PSR-3 logging](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md) standard. This means it is easy to swap out the logger with an alternative implementation, and allows your SilverStripe application to play nicely with other frameworks and libraries.

To log errors, just access the logger interface with Injector.

```php
use SilverStripe\Core\Injector\Injector;
use Psr\Log\LoggerInterface;

Injector::inst()->get(LoggerInterface::class)->error('Description of error');
```

Also available per the PSR-3 standard are:

* `emergency()`
* `alert()`
* `critical()`
* `warning()`
* `notice()`
* `info()`
* `debug()`
* `log()`

For a full list, see the PSR-3 documentation](http://www.php-fig.org/psr/psr-3/).

It's a good idea to throw these in your user code where appropriate. Logging can be very useful for debugging. When using the logger in your classes, you need not keep going through `Injector` to get a logger instance. A cleaner approach is to inject the logger as a dependency.

```php
namespace My\App;

use Psr\Log\LoggerInterface;
use PageController;

class MyPageController extends PageController
{
  private static $dependencies = [
    'logger' => '%$' . LoggerInterface::class
  ];
  
  protected $shouldFail = true;
  
  public $logger;
  
  public function doSomething()
  {
    if ($this->shouldFail) {
      $this->logger->log('It failed');
    }
  }
}
```

What all of these logging methods acutally do depends on the implementation of `LoggerInterface` that you're using. By default, SilverStripe ships with [Monolog](https://github.com/Seldaek/monolog), a logging library that comes with its own PSR-3 logging implementation, `Monolog\Logger`.

The `Monolog\Logger` class supports *handlers*, which must implement their own `HandlerInterface` definition. You can add as many handlers as you like. Some commonly used handlers ship with SilverStripe Framework.

Here's an example of adding an email handler. Any error that happens at or above the given logging level will send an email to an administrator. Let's make anything `error()` and above send an email.

*mysite/_config/logging.yml*
```yml
SilverStripe\Core\Injector\Injector:
  Psr\Log\LoggerInterface: 
    calls:
      EmailHandler: [ pushHandler, [ %$EmailHandler ] ]
  EmailHandler:
      class: Monolog\Handler\NativeMailerHandler
      constructor:
        - errors@example.com
        - Error reported on example.com
        - admin@example.com
        - error
      properties:
        ContentType: text/html
        Formatter: %$SilverStripe\Logging\DetailedErrorFormatter
```

Since email is a pretty aggressive form of error notification, we probably don't want to sent it from anywhere other than the live environment. Let's put this in a conditional block.

*mysite/_config/logging.yml*
```yml
    --- 
    Name: lessons-live-logging
    Only:
      environment: live
    ---
    SilverStripe\Core\Injector\Injector:
     Psr\Log\LoggerInterface: 
      calls:
        EmailHandler: [ pushHandler, [ %$EmailHandler ] ]
    #...
```


A better option for low-level errors is writing to a log file. Let's set that up for anything over `notice()` level.

*mysite/_config/logging.yml*
```yml
    ---
    Name: lessons-all-logging
    ---
    SilverStripe\Core\Injector\Injector:
      Psr\Log\LoggerInterface: 
        calls:
          FileLogger: [ pushHandler, [ %$FileLogger ] ]
      FileLogger:
        class: Monolog\Handler\StreamHandler
        constructor:
          - "../errors.log"
          - "notice"
```

Let's make sure that error log doesn't get checked into our repository by adding it to `.gitignore`.

*.gitignore*
```
...
# ignore error log
errors.log
```

## Dealing with email

While we're on the topic of email, let's take some control over transactional emails in our environments. This can be a really annoying problem for a couple of reasons. For one, if we're testing with real data, we don't want transactional emails to be sent to real users from our development environment. Second, we want to be able to test whether those emails would be sent, and what their contents would be if we were in production.

A simple solution to this problem is to simply force the "to" address to go to you in the dev environment. You can configure this in the config yaml.

*mysite/_config/config.yml*
```yaml
Email:
  send_all_emails_to: 'me@example.com'
```

Pretty straightforward, but we're forgetting something. We don't want this setting to apply to all environments. We need to ensure that this yaml is only loaded in the dev environment. We're not writing PHP, so we don't have the convenience of if/else blocks, but fortunately, the SilverStripe YAML parser affords us a basic API for conditional logic.

*mysite/_config/email.yml*
```yaml
    ---
    Name: dev-email
    Only:
      environment: dev
    ---
    Email:
      send_all_emails_to: 'me@example.com'
```

Perhaps in the test and production environments, we want to monitor transactional email from a bit of a distance. We could force a BCC to our email address in that case.

*mysite/_config/email.yml*
```yaml
    ---
    Name: dev-email
    Only:
      environment: dev
    ---
    Email:
      send_all_emails_to: 'me@example.com'
    ---
    Name: live-email
    Except:
      environment: dev
    ---
    Email:
      bcc_all_emails_to: 'me@example.com'
```

This works okay, but it's kind of broad. If we have other developers on the project, they're not going to get any emails, and we also can't accurately test from our dev environment what the "to" address would actually be in production or test.

### MailCatcher

A much more thorough solution is to use a thirdparty tool to capture outgoing emails from your dev environment. There are a few of these tools available, but the one I like, and recommend, is [MailCatcher](https://mailcatcher.me/). Follow the instructions on the home page to install the software, and with just a bit of configuration, you can pipe all email into a local inbox. To browse the inbox, simply visit localhost:1080. Now, you can monitor all outgoing emails, and know exactly who would receive them and what their contents would be in a production environment.