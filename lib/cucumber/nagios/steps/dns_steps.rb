When /^I lookup "([^\"]*)"$/ do |name|
  s = Socket.getaddrinfo(name, nil)
  @ip = s[0][3]
end

When /^I reverse lookup "([^\"]*)"$/ do |ip|
  s = Socket.getaddrinfo(ip, nil)
  @name = s[0][2]
end

Then /^the name should resolve to "([^\"]*)"$/ do |ip|
  @ip.should == ip
end

Then /^the IP should resolve to "([^\"]*)"$/ do |name|
  @name.downcase.should == name.downcase
end
