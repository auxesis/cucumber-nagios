#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Portions of this file originally from Chef (github.com/opscode/chef)

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

