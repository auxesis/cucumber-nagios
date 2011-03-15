Given /^the Gem "([^\"]*)" has been required$/ do |gem|
  Gem.loaded_specs.key?(gem).should be_true
end

Given /^that "([^\"]*)" has been required$/ do |lib|
  require(lib).should be_false
end

Given /^that "([^\"]*)" is required$/ do |lib|
  require(lib).should be_false
end

When /^I do aruba (.*)$/ do |aruba_step|
  begin
    When(aruba_step)
  rescue => e
    @aruba_exception = e
  end
end

Then /^I see aruba (.*)$/ do |aruba_step|
  begin
    Then(aruba_step)
  rescue => e
    @aruba_exception = e
  end
end



