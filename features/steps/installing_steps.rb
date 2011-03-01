When /^I build the gem$/ do
  project_root = Pathname.new(File.dirname(__FILE__)).parent.parent.expand_path
  rakefile     = project_root.join('Rakefile')
  check_file_presence([rakefile], true)
  silent_system(unescape("rake -f #{rakefile} build"))
end

When /^I install the latest gem$/ do
  project_root = Pathname.new(File.dirname(__FILE__)).parent.parent.expand_path
  pkg_dir = project_root.join('pkg')
  glob = File.join(pkg_dir, '*.gem')
  latest = Dir.glob(glob).sort {|a, b| File.ctime(a) <=> File.ctime(b) }.last

  run_simple(unescape("gem install --local --force --ignore-dependencies --no-ri --no-rdoc #{latest}"))
end

