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

  s.add_dependency('templater', '>= 1.0.0')
  s.add_dependency('rake', '>= 0.8.3')
  s.add_dependency('bundler', '>= 0.6.0')
  s.add_dependency('amqp', '>= 0.6.6')
  s.add_dependency('cucumber', '>= 0.6.1')
  s.add_dependency('net-ssh', '>= 2.0.18')

  s.bindir = "bin"
  s.executables = %w(cucumber-nagios-gen)
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md AUTHORS HACKING TODO lib/generators/project/.gitignore lib/generators/project/.bzrignore)
end


