Gem::Specification.new do |s|
  s.name = 'cucumber-nagios'
  s.version = '0.6.7'
  s.date = '2010-01-16'
  
  s.summary = "systems testing plugin for Nagios using Cucumber/Webrat/Mechanize/net-ssh"
  s.description = "cucumber-nagios lets you write high-level behavioural tests for your web applications and Unix infrastructure that can be plugged into Nagios"

  s.rubyforge_project = 'cucumber-nagios'
  s.authors = ['Lindsay Holmwood']
  s.email = 'lindsay@holmwood.id.au'
  s.homepage = 'http://auxesis.github.com/cucumber-nagios/'
  s.has_rdoc = false

  s.add_dependency('templater', '>= 0.5')
  s.add_dependency('rake', '>= 0.8.3')
  s.add_dependency('bundler', '>= 0.6.0')
  s.add_dependency('amqp', '>= 0.6.6')
 
  s.bindir = "bin"
  s.executables = %w(cucumber-nagios-gen)
  s.files = %w(bin/cucumber-nagios-gen lib/cucumber-nagios.rb lib/generators/project/Gemfile lib/generators/project/features lib/generators/project/features/steps lib/generators/project/features/steps/benchmark_steps.rb lib/generators/project/features/steps/ssh_steps.rb lib/generators/project/features/steps/result_steps.rb lib/generators/project/features/steps/webrat_steps.rb lib/generators/project/features/steps/amqp_steps.rb lib/generators/project/features/support lib/generators/project/features/support/env.rb lib/generators/project/features/support/nagios.rb lib/generators/project/bin lib/generators/project/bin/cucumber-nagios lib/generators/project/bin/cucumber-nagios-gen lib/generators/project/.bzrignore lib/generators/project/.gitignore lib/generators/project/README LICENSE README.md Rakefile lib/generators/project/lib/generators/feature/%feature_name%.feature lib/generators/project/lib/generators/feature/%feature_name%_steps.rb features/support/silent_system.rb features/using.feature features/steps/installing_steps.rb features/steps/using_steps.rb features/steps/creating_steps.rb features/creating.feature features/installing.feature)
end


