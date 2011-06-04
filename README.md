cucumber-nagios
===============

cucumber-nagios allows you to write high-level behavioural tests of web
application, and plug the results into Nagios.

As Bradley Taylor [put it](http://bradley.is/post/82649218/testing-dash-metrics-with-cucumber):

    “Instead of writing boring monitoring plugins from scratch,
    you can now do behavior driven ops!

    Transform from a grumpy, misanthropic sysadmin to a hipster,
    agile developer instantly.”


Quickstart
==========

 1. `gem install cucumber-nagios`
 3. `cucumber-nagios-gen project bunch-o-tests`
 4. `cd bunch-o-tests`
 5. `bundle install`
 6. `cucumber-nagios-gen feature ebay.com.au bidding`
 7. `cucumber-nagios features/ebay.com.au/bidding.feature`

Installing
==========

Install the gem with:

    gem install cucumber-nagios

This will add the `cucumber-nagios-gen` and `cucumber-nagios` commands to your
path, and make the shipped cucumber-nagios steps available to other projects
using Cucumber.

*Windows users* - you need to download and install the
[Ruby Installer](http://rubyinstaller.org/downloads/) and the
[development kit](http://rubyinstaller.org/add-ons/devkit/), otherwise
`gem install cucumber-nagios` will fail.


Setting up a project
====================

After installing the cucumer-nagios gem, set up a standalone project with:

    cucumber-nagios-gen project <project-name>

This will spit out a bunch of files in the directory specified as `<project-name>`.

Check the `README` within this directory for specific instructions for managing
the project.

Setting up Password-less SSH
============================
To use Aruba's step definitions with SSH sessions we use passwordl-less
authetication.

Once you have installed the Cucumber-Nagios gem it should 'just-work'.
Of course you server needs to accept these connections.
To test your localhost password-less access (bash):

    ssh-forever `whoami`@`hostname` -p 22 -i ~/.ssh/test_id_rsa.pub -n testing -b
    ssh testing "echo 'Hello there from here: `hostname`'"

If you want an interactive login after you set up a new SSH user/key/host:

    ssh-forever `whoami`@`hostname` -p 22 -i ~/.ssh/test_id_rsa.pub -n testing2 -a -q

Finally if you need to enter you password to create a key, try this:

    ssh-forever `whoami`@`hostname` -p 22 -i ~/.ssh/test_id_rsa.pub -n testing3


Once you have your SSH server accepting secure, but password-less,
connections you can remove the test keys from `~/.ssh/`, and you can
remove the Host entry in `~/.ssh/config`.

You are now good to use SSH-forever - which of course is the gem we use :)

For a full example see [ssh-forever](https://github.com/mattwynne/ssh-forever).

Bundling dependencies
=====================

Bundling cucumber-nagios's dependencies allows you to drop your cucumber-nagios
project on any machine and have it run. This solves the case of developing your
checks on your local machine, and deploying them on a production monitoring
server.

First you need to make sure the following dependencies are installed:

  - RubyGems
  - `bundler` gem (automatically pulled in by the `cucumber-nagios` gem)

Then to bundle your dependencies, within your project directory run:

    $ bundle install

Writing features
================

Once you've set up a project, you can use the `cucumber-nagios-gen` command
to generate new features. It takes two arguments: the site you're testing, and
feature you're testing:

    cucumber-nagios-gen feature gnome.org navigation

This will spit out two files:

    features/gnome.org/navigation.feature
    features/gnome.org/steps/navigation_steps.rb


As for writing features, you'll want to have a read of the
[Cucumber documentation](http://wiki.github.com/aslakhellesoy/cucumber), however
your tests will look something like this:

    Feature: google.com.au
      To broaden their knowledge
      A user should be able
      To search for things

      Scenario: Searching for things
        When I go to "http://www.google.com"
        And I fill in "q" with "wikipedia"
        And I press "Google Search"
        Then I should see "www.wikipedia.org"

There's a collection of steps that will cover most of the things you'll be
testing for in `features/steps/webrat_steps.rb`.

You can write custom steps for testing specific output and behaviour, e.g.
in `features/smh.com.au/smh.feature`:

    Feature: smh.com.au
      It should be up
      And provide links to content

      Scenario: Visiting home page
        When I go to http://smh.com.au/
        Then I should see site navigation
        And there should be a section named "Opinion"

There aren't steps for `Then I should see site navigation`, so you have to
write one yourself. :-) In `features/smh.com.au/steps/smh_steps.rb`:

    Then /^I should see site navigation$/ do
      doc = Nokogiri::HTML(response.body.to_s)
      doc.css("ul#nav li a").size.should > 5
    end

You can use Nokogiri for testing responses with XPath matchers and CSS
selectors.

I suggest you use `bin/cucumber` directly so you can get better feedback when
writing your tests:

    bin/cucumber --require features/ features/smh/smh.feature

This will output using the default 'pretty' formatter.

Running
=======

Invoke the Cucumber feature with the `cucumber-nagios` script:

    cucumber-nagios features/smh.com.au/smh.feature

`cucumber-nagios` can be run from anywhere:

    /path/to/bin/cucumber-nagios /path/to/features/smh/smh.feature

It should return a standard Nagios-formatted response string:

    Critical: 0, Warning: 0, 2 okay | passed=2, failed=0, total=2

Steps that fail will show up in the "Critical" total, and steps that pass
show up in the "okay" total.

The value printed at the end is in Nagios's Performance Data format, so it
can be graphed and the like.

Benchmarking
============

You can benchmark your features if you need to test response times for a set of
site interactions:

    Feature: slashdot.com
      To keep the geek masses satisfied
      Slashdot must be responsive

      Scenario: Visiting a responsive front page
        Given I am benchmarking
        When I go to http://slashdot.org/
        Then the elapsed time should be less than 5 seconds

The elapsed time step can be reused multiple times in the same scenario if you
need fine grained testing:

    Feature: slashdot.com
      To keep the geek masses satisfied
      Slashdot must be responsive

      Scenario: Visiting news articles
        Given I am benchmarking
        When I go to http://slashdot.org/
        Then the elapsed time should be less than 5 seconds
        When I follow "Login"
        Then the elapsed time should be less than 4 seconds
        When I follow "Contact"
        Then the elapsed time should be less than 7 seconds

AMQP Message Queues
===================

You can test for various conditions on an AMQP message queue.

    Feature: github.com
      To make sure the rest of the system is in order
      All our message queues must not be backed up

      Scenario: test queue 2
        Given I have a AMQP server on rabbit.github.com
        And I want to check on the fork queue
        Then it should have less than 400 messages
        Then it should have at least 5 consumers
        Then it should have less than 50 messages per consumer

This has been tested using RabbitMQ but uses the amqp gem which should support
other backends. See features/amqp_steps.rb for all the available steps.

Deploying to production
=======================

As per the install instructions above, make sure you have RubyGems and the `bundler`
gem installed.

Once you've copied your project to your monitoring server, just run bundler again:

    $ bundle install

Quirks
======

Failure *is* an option (exceptions are good)
--------------------------------------------

Exceptions raised within your tests will appear in the failed totals, so you
don't need to worry about trying to catch them in your own custom steps.

i.e. if you try fetching a page on a server that is down, or the page returns
a 404, the exception raised by Mechanize just gets treated by Cucumber as a
test failure.

Using the Steps in another Cucumber suite
=========================================

If you want to use the steps shipped with cucumber-nagios elsewhere, you can
require them by adding the following line to `features/support/env.rb` like so:

    require 'cucumber/nagios/steps'

Or just require the steps you care about:

    require 'cucumber/nagios/steps/ssh'
    require 'cucumber/nagios/steps/ping'

Using the Formatter in another Cucumber suite
=============================================

Once installed as a gem, the `cucumber-nagios` formatter is available in any
other Cucumber test suite:

    cucumber --format Cucumber::Formatter::Nagios features/foo.feature

Version control
===============

It's _strongly_ recommend that you store your cucumber-nagios projects in a version
control system!

To get up and running with git:

    $ git init
    $ git add .
    $ git commit -m 'created cucumber-nagios project'

`.gitignore` is created when you generate a project.

Testing
=======

The gem is thoroughly tested (with Cucumber, no less). The gem's Cucumber
features live in $gemroot/features/, and can be run with:

    $ cucumber features/installing.feature
    $ cucumber features/creating.feature
    $ cucumber features/using.feature

Contributing
============

See the HACKING file.
