Given /^a driver exists with the name "([^\"]*)"$/ do |name|
 @driver = Factory( :driver, :name => name) 
end

Then /^"([^\"]*)" should have capacity in "([^\"]*)"$/ do |driver, location|
  @driver.capacities.any? { |c| c.location == location }
end

