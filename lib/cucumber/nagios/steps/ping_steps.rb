# TODO: this has only been tested on Solaris, so it should be changed to
#       handle other operating systems too
When /^I ping "([^\"]*)"$/ do |host|
  @result = system("ping #{host} > /dev/null 2>&1")
end

Then /^it should respond$/ do
  @result.should be_true
end

Then /^it should not respond$/ do
  @result.should be_false
end
