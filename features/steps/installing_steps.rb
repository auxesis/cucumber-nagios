When /^I build the gem$/ do
  project_root = Pathname.new(File.dirname(__FILE__)).parent.parent.expand_path
  rakefile     = project_root.join('Rakefile')
  File.exist?(rakefile).should be_true

  system("rake -f #{rakefile} build").should be_true
end

When /^I install the latest gem$/ do
  project_root = Pathname.new(File.dirname(__FILE__)).parent.parent.expand_path
  pkg_dir = project_root.join('pkg')
  glob = File.join(pkg_dir, '*.gem')
  latest = Dir.glob(glob).sort {|a, b| File.ctime(a) <=> File.ctime(b) }.last

  silent_system("gem install --local #{latest}").should be_true
end

Then /^I should have "([^"]*)" on my path$/ do |file|
  silent_system("which #{file}").should be_true
end

Then /^I can generate a new project$/ do
  testproj = "testproj-#{Time.now.to_i}"
  FileUtils.rm_rf("/tmp/#{testproj}")

  silent_system("cd /tmp ; cucumber-nagios-gen project #{testproj}").should be_true
  File.exists?("/tmp/#{testproj}").should be_true
end

