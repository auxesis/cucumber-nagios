Given /^a project called "([^\"]*)" is created and frozen$/ do |project_name|
  @project_name = project_name
  Given 'cucumber-nagios is installed'
  When "I create a new project called \"#{@project_name}\""
  And 'I freeze in dependencies'
  Then 'a Gemfile lock should be created'
end

When /^I generate a new feature called "([^\"]*)" for "([^\"]*)"$/ do |feature, site|
  Dir.chdir("/tmp/#{@project_name}") do
    silent_system("cucumber-nagios-gen feature #{site} #{feature}")
  end
end

Then /^a feature file should exist for "([^\"]*)" on "([^\"]*)"$/ do |feature, site|
  File.exists?("/tmp/#{@project_name}/features/#{site}/#{feature}.feature").should be_true
end

Then /^the "([^\"]*)" feature on "([^\"]*)" should exit cleanly$/ do |feature, site|
  Dir.chdir("/tmp/#{@project_name}") do
    silent_system("cucumber-nagios features/#{site}/#{feature}.feature").should be_true
  end
end

Then /^the "([^\"]*)" feature on "([^\"]*)" should not exit cleanly$/ do |feature, site|
  Dir.chdir("/tmp/#{@project_name}") do
    silent_system("cucumber-nagios features/#{site}/#{feature}.feature").should be_false
  end
end

When /^the "([^\"]*)" feature on "([^\"]*)" checks for something preposterous$/ do |feature, site|
  file_name = "/tmp/#{@project_name}/features/#{site}/#{feature}.feature"
  File.open(file_name,'a') do |file|
    file << "     Then I should see \"supercalifragilisticexpialidocious\""
  end
end

Then /^"([^"]*)" in the "([^"]*)" project should not exist$/ do |file, project_name|
  filename = File.join(file, project_name)
  File.exists?(filename).should be_false
end

Then /^the "([^"]*)" feature on "([^"]*)" should produce multiline output$/ do |feature, site|
  Dir.chdir("/tmp/#{@project_name}") do
    command = "cucumber-nagios features/#{site}/#{feature}.feature"
    @output = `#{command}`
    @output.split("\n").size.should > 1
  end
end
