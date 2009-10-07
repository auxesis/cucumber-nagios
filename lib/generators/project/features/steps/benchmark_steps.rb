Given /^I am benchmarking$/ do 
  @scenario_start_time = Time.now
end

Then /^the elapsed time should be less than (\d+) seconds$/ do |time|
  (@scenario_start_time - Time.now).should > time.to_i * -1
end

