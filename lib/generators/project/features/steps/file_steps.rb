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

require 'etc'

###
# Given
###

Given /^we have an empty file named '(.+)'$/ do |filename|
  filename = File.new(filename, 'w')
  filename.close
end

Given /^we have the atime\/mtime of '(.+)'$/ do |filename|
  @mtime = File.mtime(filename)
  @atime = File.atime(filename)
end

####
# Then
####

Then /^a file named '(.+)' should exist$/ do |filename|
  File.exists?(filename).should be(true)
end

Then /^a file named '(.+)' should not exist$/ do |filename|
  File.exists?(filename).should be(false)
end

Then /^'(.+)' should exist and raise error when copying$/ do |filename|
  File.exists?(filename).should be(true)
  lambda{copy(filename, filename + "_copy", false)}.should raise_error()
  File.delete(filename)
end


Then /^the (.)time of '(.+)' should be different$/ do |time_type, filename|
  case time_type
  when "m"
    current_mtime = File.mtime(filename)
    current_mtime.should_not == @mtime
  when "a"
    current_atime = File.atime(filename)
    current_atime.should_not == @atime
  end
end

Then /^a file named '(.+)' should contain '(.+)'$/ do |filename, contents|
  file = IO.read(filename)
  file.should =~ /#{contents}/m
end

Then /^a file named '(.+)' should contain '(.+)' only '(.+)' time(?:s)?$/ do |filename, string, count|
  seen_count = 0
  IO.foreach(filename) do |line|
    if line =~ /#{string}/
      seen_count += 1
    end
  end
  seen_count.should == count.to_i
end

Then /^the file named '(.+)' should be owned by '(.+)'$/ do |filename, owner|
  uid = Etc.getpwnam(owner).uid
  cstats = File.stat(filename)
  cstats.uid.should == uid
end

Then /^the file named '(.+)' should have mode '(.+)'$/ do |filename, expected_mode|
  cstats = File.stat(filename)
  (cstats.mode & 007777).should == octal_mode(expected_mode)
end

def octal_mode(mode)
  ((mode.respond_to?(:oct) ? mode.oct : mode.to_i) & 007777)
end

Then /^a directory named '(.+)' should exist$/ do |dir|
  File.directory?(dir).should be(true)  
end

Then /^a directory named '(.+)' should not exist$/ do |dir|
  File.directory?(dir).should be(false)
end

Then /^the directory named '(.+)' should be owned by '(.+)'$/ do |dirname, owner|
  uid = Etc.getpwnam(owner).uid
  cstats = File.stat(File.join(tmpdir, dirname))
  cstats.uid.should == uid
end

Then /^the directory named '(.+)' should have mode '(.+)'$/ do |dirname, expected_mode|
  cstats = File.stat(dirname)
  (cstats.mode & 007777).should == octal_mode(expected_mode)
end

