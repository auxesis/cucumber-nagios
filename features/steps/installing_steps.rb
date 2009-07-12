When /^I build the gem$/ do
  project_root = File.join(File.dirname(__FILE__), '..', '..')
  rakefile = File.join(project_root, 'Rakefile')
  File.exist?(rakefile).should be_true
  
  silent_system("rake -f #{rakefile} build").should be_true
end

When /^I install the latest gem$/ do
  project_root = File.join(File.dirname(__FILE__), '..', '..')
  pkg_dir = File.join(project_root, 'pkg')
  pkg = File.expand_path(Dir.glob(File.join(pkg_dir, '*.gem')).last)

  silent_system("gem install #{pkg} 2>&1 > /dev/null").should be_true
end

Then /^I should have cucumber\-nagios\-gen on my path$/ do
  silent_system("which cucumber-nagios-gen").should be_true
end

Then /^I can generate a new project$/ do
  testproj = "testproj-#{Time.now.to_i}"
  FileUtils.rm_rf("/tmp/#{testproj}")
  
  silent_system("cd /tmp ; cucumber-nagios-gen project #{testproj}").should be_true
end

