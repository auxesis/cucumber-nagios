Given /^cucumber\-nagios is installed$/ do
  Given %Q{I build the gem}
  When %Q{I install the latest gem}
  Then %Q{I successfully run "which cucumber-nagios-gen"}
  And %Q{I successfully run "which cucumber-nagios"}
end
