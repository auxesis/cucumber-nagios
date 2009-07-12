Given /^a project called "([^\"]*)" is created and frozen$/ do |project_name|
  @project_name = project_name
  Given 'cucumber-nagios is installed'
  When "I create a new project called \"#{@project_name}\""
  And 'I freeze in dependencies'
  Then 'my gems directory should be populated'
end

When /^I generate a new feature called "([^\"]*)" for "([^\"]*)"$/ do |feature, site|
  silent_system("cd /tmp/#{@project_name} ; bin/cucumber-nagios-gen feature #{site} #{feature}")
end

Then /^a feature file should exist for "([^\"]*)" on "([^\"]*)"$/ do |feature, site|
  File.exists?("/tmp/#{@project_name}/features/#{site}/#{feature}.feature").should be_true
end

Then /^the "([^\"]*)" feature on "([^\"]*)" should exit cleanly$/ do |feature, site|
  silent_system("cd /tmp/#{@project_name} ; bin/cucumber-nagios features/#{site}/#{feature}.feature").should be_true
end

Then /^the "([^\"]*)" feature on "([^\"]*)" should not exit cleanly$/ do |feature, site|
  silent_system("cd /tmp/#{@project_name} ; bin/cucumber-nagios features/#{site}/#{feature}.feature").should be_false
end

When /^the "([^\"]*)" feature on "([^\"]*)" checks for something preposterous$/ do |feature, site|
  file_name = "/tmp/#{@project_name}/features/#{site}/#{feature}.feature"
  File.open(file_name,'a') do |file|
    file << "     Then I should see \"supercalifragilisticexpialidocious\""
  end
end

