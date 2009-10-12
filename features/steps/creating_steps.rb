Given /^cucumber\-nagios is installed$/ do
  When 'I build the gem'
  And 'I install the latest gem'
  Then 'I should have cucumber-nagios-gen on my path'
end

When /^I create a new project called "([^\"]*)"$/ do |project_name|
  @project_name = project_name
  FileUtils.rm_rf("/tmp/#{@project_name}")
  
  silent_system("cd /tmp ; cucumber-nagios-gen project #{@project_name}").should be_true
end

When /^I freeze in dependencies$/ do
  @project_name.should_not be_nil
  silent_system("cd /tmp/#{@project_name} ; gem bundle").should be_true
end

Then /^my gems directory should be populated$/ do
  @project_name.should_not be_nil
  Dir.glob("/tmp/#{@project_name}/vendor/gems/*").size.should > 0
end

