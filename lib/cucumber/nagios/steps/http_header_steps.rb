#
# Some WWW access features/steps can take a while:
#
Before do
  @aruba_timeout_seconds.nil? || @aruba_timeout_seconds < 30 ? @aruba_timeout_seconds = 10 : @aruba_timeout_seconds
end

When /I fetch headers from "(.*)"/ do |url|
  visit(url)
  @headers = response.header
end

Then /^the "(.*)" header should be "(.*)"$/ do |name, value|
  @headers[name].should == value
end

Then /^the response should contain the "(.*)" header$/ do |name|
  @headers.should have_key(name.downcase)
end

Then /^the "(.*)" header should contain "(.*)"$/ do |name, expression|
  @headers[name].should match(expression)
end

Then /^the "(.*)" header should not contain "(.*)"$/ do |name, expression|
  @headers[name].should_not match(expression)
end
