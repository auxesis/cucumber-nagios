Gem::Specification.new do |s|
  s.name = 'cucumber-nagios'
  s.version = '0.3.3'
  s.date = '2009-03-05'
  
  s.summary = "web app testing plugin for Nagios using Cucumber/Webrat/Mechanize"
  s.description = "cucumber-nagios lets you write high-level behavioural tests for your web applications that can be plugged into Nagios"
  
  s.authors = ['Lindsay Holmwood']
  s.email = 'lindsay@holmwood.id.au'
  s.homepage = 'http://holmwood.id.au/~lindsay/2009/02/23/web-app-integration-testing-for-sysadmins-with-cucumber-nagios/'
  s.has_rdoc = false

  s.add_dependency('templater', '>= 0.5')
  s.add_dependency('rake', '>= 0.8.3')
 
  s.bindir = "bin"
  s.executables = %w(cucumber-nagios-gen)
  s.files = %w(bin/cucumber-nagios-gen lib/generators/project/Rakefile lib/generators/project/features lib/generators/project/features/steps lib/generators/project/features/steps/result_steps.rb lib/generators/project/features/steps/webrat_steps.rb lib/generators/project/features/support lib/generators/project/features/support/env.rb lib/generators/project/features/support/nagios.rb lib/generators/project/bin lib/generators/project/bin/common.rb lib/generators/project/bin/cucumber lib/generators/project/bin/cucumber-nagios lib/generators/project/bin/cucumber-nagios-gen lib/generators/project/.bzrignore lib/generators/project/.gitignore lib/generators/project/README LICENSE README.md Rakefile lib/generators/project/lib/generators/feature/%feature_name%.feature lib/generators/project/lib/generators/feature/%feature_name%_steps.rb)
end


