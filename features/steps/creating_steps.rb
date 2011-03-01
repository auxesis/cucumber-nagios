Given /^cucumber\-nagios is installed$/ do
  When 'I build the gem'
  And 'I install the latest gem'
  Then 'I should have "cucumber-nagios-gen" on my path'
  And 'I should have "cucumber-nagios" on my path'
end

When /^I create a new project called "([^\"]*)"$/ do |project_name|
  @project_name = project_name
  FileUtils.rm_rf("/tmp/#{@project_name}")

  silent_system("cd /tmp ; cucumber-nagios-gen project #{@project_name}").should be_true
end

When /^I pretend to create a new project called "([^\"]*)"$/ do |project_name|
  @project_name = project_name
  FileUtils.rm_rf("/tmp/#{@project_name}") if  Dir.exists?("/tmp/#{@project_name}")

  silent_system("cd /tmp ; cucumber-nagios-gen project --pretend #{@project_name}").should be_true
end

When /^I freeze in dependencies$/ do
  @project_name.should_not be_nil
  silent_system("cd /tmp/#{@project_name} ; bundle install --local").should be_true
end

Then /^I do not freeze in dependencies$/ do
  @project_name.should_not be_nil
  lambda do
    Dir.chdir("/tmp/#{@project_name}") do
      $stderr.puts "This should not run"
    end
  end.should raise_error(Errno::ENOENT)
end

Then /^a Gemfile lock should be created$/ do
  @project_name.should_not be_nil
  File.exists?("/tmp/#{@project_name}/Gemfile.lock").should be_true
end

Then /^a Gemfile lock should not be created$/ do
  @project_name.should_not be_nil
  File.exists?("/tmp/#{@project_name}/Gemfile.lock").should be_false
end

