Then /^I should see site navigation$/ do
  doc = Nokogiri::HTML(response.body.to_s)
  doc.css("ul#nav li a").size.should > 5
end

Then /^there should be a section named "(.+)"$/ do |name|
  doc = Nokogiri::HTML(response.body.to_s)
  doc.xpath("//h2//a[contains(.,'#{name}')]").size.should == 1
  #response.body.should have_xpath("//h2//a[contains(.,'#{name}')]")
end
