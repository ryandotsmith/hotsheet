Given /^I am looking at today's capacity$/ do
  When %{I am on "the capacity index page"}
end

Given /^I have a capacity today in "([^\"]*)"$/ do |location|
  Factory( :capacity, :location => location , :available_on => DateTime.now)
end

Given /^I have capacity "([^\"]*)" days? from now in "([^\"]*)"$/ do |n, location|
  Factory( :capacity, :location => location , :available_on => DateTime.now + n.to_i.days )
end

Then /^I should see capacity in "([^\"]*)" for "([^\"]*)"$/ do |location, day|
  date = DateTime.now.strftime('%m_%d_%y')
  response.should have_selector( 'div', :id => date ) do |div|
    div.should have_selector('td', :class => 'location') do |td|
      td.text.should eql( location ) 
    end
  end
end

Then /^I should see capacity in "([^\"]*)" "([^\"]*)" days? from now$/ do |location , n|
  date = (DateTime.now + n.to_i.days).strftime('%m_%d_%y')
   response.should have_selector( 'div', :id => date ) do |div|
    div.should have_selector('td', :class => 'location') do |td|
      td.text.should eql( location ) 
    end
  end
end

