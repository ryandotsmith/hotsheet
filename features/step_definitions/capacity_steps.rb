#IDMAP= {
#  "Driver" => "capacity_driver_id",
#  "Location" => "capacity_location",
#  "Priority" => "capacity_priority",
#  "Available On" => "capacity_available_on",
#  "Notes" => "capacity_notes"
#}
#
Given /^I am looking at today's capacity$/ do
  When %{I am on "the capacity index page"}
end
#
#When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |input, arg|
#  @browser.text_field( :id, IDMAP[input]).set(arg)
#end
#
#When /^I press "([^\"]*)"$/ do |button|
#  @browser.button( :name, button ).click
#end
#
#When /^I click the link "([^\"]*)"$/ do |link|
#  @browser.link( :id, link ).click
#end
#
#When /^I fill in "([^\"]*)" with Todays Date$/ do |arg1|
#  true
#end
#
#Then /^I should see more capicity in "([^\"]*)" for today$/ do |arg1|
#  sleep 0.3
#  @browser.table( :id, 'daily_capacity').contains_text( "test" )
#end
#
