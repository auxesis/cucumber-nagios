Hacking
=======

Found something wrong? Got a great idea? You too can make cucumber-nagios
better by submitting a issue or patch.

Reporting issues
================

First, head over to our [issue
tracking](https://github.com/auxesis/cucumber-nagios/issues) and see if other
people want the same thing. If you don't see anything similar, create an issue
to let us know what's on your mind. As you might expect, we use cucumber to
write tests, so if you can describe your idea using Givens, Whens, and Thens,
that'll make fixing it even easier.

Submitting patches
==================

If you're feeling ambitious, creating a feature branch that solves your issue
is even better. Fork the [project](https://github.com/auxesis/cucumber-nagios),
and check out your fork (assuming a GitHub username of ken):

    $ git clone https://github.com/ken/cucumber-nagios.git

Setup your environment and make sure the tests pass:

    $ cd cucumber-nagios
    $ bundle install
    $ rake

Start a branch, apply your changes, make sure the tests still pass, commit, and
push to GitHub:

    $ git checkout -b my_feature_branch
    [ edit files ]
    $ rake
    $ git commit -m "Added new awesome features. Fixes github issue #1234"
    $ git push origin my_feature_branch

Then send us a pull request from your fork's page at GitHub.

Releasing a gem
===============

Releasing a gem is easy, but everyone forgets the exact steps.

1. Check AUTHORS, LICENSE, TODO, README.md and lib/generators/project/README to
make sure they're still accurate. Everyone hates when the docs are out of
date! :-)

2. Review MANIFEST to make sure gem files, all the gem files, and nothing but
the gem files are going into the gem. Running `git status` and `rake
check_manifest` will help you notice anything out of place.

3. Update Cucumber::Nagios::VERSION in lib/cucumber/nagios/version.rb. Check
http://semver.org if you aren't sure whether to use a prerelease, increment the
patch, minor or major version.

4. Remove any stray files. Every file in `git status` should be in "Changes to
be committed".

3. Run the tests with `rake`.

4. Commit your changes.

5. Build the gem with `rake build`.

6. Install the gem locally with `rake install`. Check that it seems to work.

7. Tag and push to RubyGems with `rake release`.

8. Push to GitHub with `git push origin`
