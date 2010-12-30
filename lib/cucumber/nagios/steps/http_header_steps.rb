When /I fetch (.*)/ do | url |
  visit url
  @url_headers = response.header
end
 
Then /^the "(.*)" header should be "(.*)"$/ do | header_name, header_value|
  @url_headers[header_name].should == header_value
end
 
Then /^the response should contain the "(.*)" header$/ do | header_name |
  @url_headers.should have_key(header_name.downcase)
end
 
### header contains checks
Then /^the "(.*)" header should contain "(.*)"$/ do | header_name, header_contains |
  @url_headers[header_name].should match header_contains
end
 
Then /^the "(.*)" header should not contain "(.*)"$/ do | header_name, header_contains |
  @url_headers[header_name].should_not match header_contains
end
