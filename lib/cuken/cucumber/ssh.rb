World(::Cuken::Api::Ssh)

Before do
  @aruba_timeout_seconds.nil? || @aruba_timeout_seconds < 3 ? @aruba_timeout_seconds = 3 : @aruba_timeout_seconds
end

Given /^a SSH client user "([^\"]*)"$/ do |name|
  ssh_client_hostname name
end

Given /^a SSH client user$/ do
  ssh_client_hostname
end

Given /^a SSH client hostname "([^\"]*)"$/ do |name|
  ssh_client_hostname name
end

Given /^a SSH client hostname$/ do
  ssh_client_hostname
end

Given /^default ssh\-forever options$/ do
  ssh_forever_options(:default)
end

Given /^the ssh\-forever options:$/ do |table|
  ssh_forever_options(table)
end

When /^I initialize password\-less SSH access for:$/ do |table|
  ssh_init_password_less_batch(table)
end

Given /^I initialize password\-less SSH access$/ do
  ssh_init_password_less
end


