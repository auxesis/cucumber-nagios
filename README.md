cucumber-nagios
===============

cucumber-nagios allows you to write high-level behavioural tests of web 
application, and plug the results into Nagios. 

As Bradley Taylor [put it](http://bradley.is/post/82649218/testing-dash-metrics-with-cucumber): 

    “Instead of writing boring monitoring plugins from scratch, 
    you can now do behavior driven ops!

    Transform from a grumpy, misanthropic sysadmin to a hipster, 
    agile developer instantly.”


Setting up a project
====================

To set up a standalone `cucumber-nagios` project, run:

    cucumber-nagios-gen project <project-name>

This will spit out a bunch of files in the directory specified as `<project-name>`. 

Check the `README` within this directory for specific instructions for managing
the project. 


Freezing 
========

Freezing your dependencies into your project allows you to drop your 
`cucumber-nagios` project to any machine and have it run. Its only requirement is 
Ruby and Rake.

To freeze your project, within your project directory run:

    $ rake deps

Redeploying
===========

Once you've copied your project around, Just run the freezer again: 

    $ rake deps

Writing features
================

Once you've set up a project, you can use the `bin/cucumber-nagios-gen` command
to generate new features. It takes two arguments: the site you're testing, and 
feature you're testing: 

    bin/cucumber-nagios-gen feature gnome.org navigation

This will spit out two files: 

    features/gnome.org/navigation.feature
    features/gnome.org/steps/navigation_steps.rb


As for writing features, you'll want to have a read of the 
[Cucumber documentation](http://wiki.github.com/aslakhellesoy/cucumber), however
your tests will look something like this:

    Feature: google.com.au
      It should be up
      And I should be able to search for things
    
      Scenario: Searching for things
        Given I visit "http://www.google.com"
        When I fill in "q" with "wikipedia"
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

There aren't steps for "Then I should see site navigation", so you have to 
write one yourself. :-) In `features/smh.com.au/steps/smh_steps.rb`: 

    Then /^I should see site navigation$/ do                                                                    
      doc = Nokogiri::HTML(response.body.to_s)                                                                  
      doc.css("ul#nav li a").size.should > 5                                                                    
    end

You can use Nokogiri for testing responses with XPath matchers and CSS 
selectors. 

I suggest you use `bin/cucumber` directly so you can get better feedback when 
writing your tests:

    bin/cucumber --require bin/common.rb \
                 --require features/ 
                 features/smh/smh.feature


Running
=======

Invoke the Cucumber feature with the `cucumber-nagios` script: 

    bin/cucumber-nagios features/smh.com.au/smh.feature

`cucumber-nagios` can be run from anywhere: 

    /path/to/bin/cucumber-nagios /path/to/features/smh/smh.feature

It should return a standard Nagios-formatted response string: 

    Critical: 0, Warning: 0, 2 okay | passed=2, failed=0, total=2

Steps that fail will show up in the "Critical" total, and steps that pass 
show up in the "okay" total. 

The value printed at the end is in Nagios's Performance Data format, so it
can be graphed and the like.


Caveats
=======

You may want to think about keeping to one scenario to a file, otherwise 
you'll get multiple lines of output for a test:

    Critical: 1, Warning: 0, 2 okay | passed=2, failed=1, total=3
    Critical: 1, Warning: 0, 4 okay | passed=4, failed=1, total=5

That said, Nagios should only read the last line, so this might be an ok 
behaviour when you want to test for an aggregate of failures across a site.


Version control
===============

I highly recommend storing your cucumber-nagios projects in a version control
system!

To get up and running with git: 

    $ git init
    $ git add .
    $ git commit -m 'created cucumber-nagios project'

To get up and running with bzr:

    $ bzr init
    $ bzr add
    $ bzr commit -m 'created cucumber-nagios project'

.bzrignore and .gitignores are created when you generate a project.
