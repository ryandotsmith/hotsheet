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

    it "should use a default driver if an empty string is supplied for the driver name" do
      driver = Factory( :driver, :name  => "TBD")
      capacity = { :location => "Kansas City" }
      Driver.should_receive(:find_by_name).once.with('TBD').and_return( driver )
      Driver.should_not_receive(:new)
      post :create, :capacity => capacity, :driver_name => ''
    end

  end
  
  describe "updating a capacity with a covered date" do
    it "should be be covered if a covered date is receieved" do
      fulfilled_time = DateTime.now
      capacity = Factory(:capacity)
      Capacity.should_receive(:find).with('42').and_return(capacity)
      capacity_params = { :fulfilled_on => fulfilled_time }
      put :update, :id => '42', :capacity => capacity_params
      capacity.fulfilled_on.should eql(fulfilled_time)
    end
  end


end

