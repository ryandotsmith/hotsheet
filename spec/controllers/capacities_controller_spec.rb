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
  describe "creating capacities" do
    it "should build a new driver if one can not be found with the params" do
      capacity_params = { :location => "Kansas City" }
      capacity = mock_model(Capacity)
      Capacity.should_receive(:new).and_return(capacity)
      capacity.should_receive(:drivers).and_return(drivers = mock('array of drivers'))
      drivers.should_receive(:build).once.with(:name => "notindb")
      capacity.should_receive(:save)
      post :create, :capacity => capacity_params, :driver_name => 'notindb'
    end
    it "should not create a new driver if one can be found" do
      driver = Factory( :driver, :name => "miles")
      capacity = { :location => "Kansas City" }
      Driver.should_receive(:find_by_name).once.with('miles').and_return( driver )
      Driver.should_not_receive(:new)
      post :create, :capacity => capacity, :driver_name => 'miles'
    end
  end
end

