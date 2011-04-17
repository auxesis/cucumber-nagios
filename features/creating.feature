Feature: Creating new project
  To test websites
  A cucumber-nagios project
  Must be created

	@create
	Scenario: Create a project
		When I run `cucumber-nagios-gen project great-website-tests`
		And I cd to "great-website-tests"
		And I run `bundle install --local`
		Then a file named "Gemfile.lock" should exist

	@create
	Scenario: Pretend to create a project
		When I run `cucumber-nagios-gen project --pretend great-website-tests`
		Then a directory named "great-website-tests" should not exist

