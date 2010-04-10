require 'mq'

# simple function to get at the number of messages on a queue and the 
# number of consumers using it and store them in variables for later use
def get_details_of_queue(queue, host) 
  AMQP.start(:host => host) do
    jobs = MQ.queue(queue)
    jobs.status do |msgs, cns| 
      @messages = msgs
      @count = cns     
    end
    AMQP.stop{ EM.stop }
  end
end

# set up some defaults so we can compare numbers without
# raising exceptions
Before do
  @messages = 0
  @consumers = 0
end

# Step definitions for testing various conditions on the queue
Given /I have a AMQP server on (.+)$/ do |host|
  @host = host
end

And /I want to check on the (\w+) queue$/ do |queue|
  get_details_of_queue(queue, @host)
end

Then /it should have less than (\d+) messages per consumer$/ do |messages|
  @consumers.should > 0
  messages.to_i.should < @messages/@consumers
end

Then /it should have less than (\d+) messages$/ do |messages|
  @messages.should < messages.to_i
end

Then /it should have at least (\d+) messages$/ do |messages|
  @messages.should >= messages.to_i
end

Then /it should have more than (\d+) messages$/ do |messages|
  @messages.should > messages.to_i
end

Then /It should have more than (\d+) consumers$/ do |consumers|
  @consumers.should > consumers.to_i
end

Then /It should have less than (\d+) consumers$/ do |consumers|
  @consumers.should < consumers.to_i
end

Then /It should have (\d+) consumers$/ do |consumers|
  @consumers.should == consumers.to_i
end
