require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CapacitiesController do

  it "should setup the default focus with today's capacities" do
    Capacity.should_receive(:available_on).once.with(Date.today)
    get :index
  end

  it "should set the focus to a specific date if one is specified" do
    future = Date.today + 42.days
    Capacity.should_receive(:available_on).once.with( future )
    get :index, :focus_date => future
  end

end

