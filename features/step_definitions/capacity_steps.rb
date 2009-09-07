Given /^I am looking at today's capacity$/ do
  When %{I am on "the capacity index page"}
end

Given /^I have a capacity today in "([^\"]*)"$/ do |location|
  Factory( :capacity, :location => location , :available_on => Date.today)
end

Given /^I have capacity "([^\"]*)" days? from now in "([^\"]*)"$/ do |n, location|
  Factory( :capacity, :location => location , :available_on => Date.today + n.to_i.days )
end

Then /^I should see capacity in "([^\"]*)" for "([^\"]*)"$/ do |location, day|
  date = Date.today.strftime('%m_%d_%y')
  response.should have_selector( 'div', :id => 'focus_capacities' ) do |focus_capacities|
    focus_capacities.should have_selector('td', :class => 'location') do |td|
      td.text.should eql( location ) 
    end
  end
end

Then /^I should see capacity in "([^\"]*)" "([^\"]*)" days? from now$/ do |location , n|
  date = (Date.today + n.to_i.days).strftime('%m_%d_%y')
   response.should have_selector( 'div', :id => date ) do |div|
    div.should have_selector('td', :class => 'location') do |td|
      td.text.should eql( location ) 
    end
  end
end


Given /^I have future capacity$/ do
  @future_date = Date.today + 1.days
  response.should have_selector('div', :id => @future_date.strftime('%m_%d_%y') )
end

When /^I click on a capacity in the future$/ do
  click_link( @future_date.strftime('%m_%d_%y'))
end

Then /^the future capacity should come into focus$/ do
  response.should have_selector( 'div', :id => 'focus_capacities' ) do |focus_capacities|
    focus_capacities.should have_selector('h1') do |h1|
      h1.text.should eql( @future_date.strftime('%m_%d_%y') )
    end
  end
end




