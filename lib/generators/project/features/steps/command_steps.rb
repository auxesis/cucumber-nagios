#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

When /^I run '(.+)'$/ do |cmd|
  status = Cucumber::Nagios::Command.popen4(cmd) do |p, i, o, e|
    @stdout = o.gets(nil)
    @stderr = e.gets(nil)
  end
  @status = status
end

###
# Then
###
Then /^it should exit '(.+)'$/ do |exit_code|
  begin
    @status.exitstatus.should eql(exit_code.to_i)
  rescue 
    print_output
    raise
  end
end

Then /^it should exit from being signaled$/ do 
  begin
    @status.signaled?.should == true
  rescue 
    print_output
    raise
  end
end

def print_output
  puts "--- run stdout:"
  puts @stdout
  puts "--- run stderr:"
  puts @stderr
end

# Then 'stdout' should have 'foo'
Then /^'(.+)' should have '(.+)'$/ do |which, to_match|
  self.instance_variable_get("@#{which}".to_sym).should match(/#{to_match}/m)
end

# Then 'stderr' should not have 'foo'
Then /^'(.+)' should not have '(.+)'$/ do |which, to_match|
  self.instance_variable_get("@#{which}".to_sym).should_not match(/#{to_match}/m)
end

# Then 'my dog ate my homework' should appear on 'stdout' '5' times 
Then /^'(.+)' should appear on '(.+)' '(.+)' times$/ do |to_match, which, count|
  seen_count = 0
  self.instance_variable_get("@#{which}".to_sym).split("\n").each do |line|
    seen_count += 1 if line =~ /#{to_match}/
  end
  seen_count.should == count.to_i
end

