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
      Driver.should_receive(:create)
      capacity.should_receive(:drivers=)
      capacity.should_receive(:save!)
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

    describe "creating capacities for JS posts" do

      it "should load focus capacities if the capacity created is in the current focus date" do
        3.times {Factory(:capacity)}
        capacity_params = { :available_on => Date.today , :location => "KC"}
        capacities = Capacity.all_by_availability(Date.today)
        Capacity.should_receive(:all_by_availability).with(Date.today).and_return(capacities)
        post :create, :capacity => capacity_params, :driver_name => "", :focus_date => Date.today.strftime("%Y-%m-%d")
      end

      it "should add a link to a focus table if the new capacity is not on the current focus date" do
        date_string = ( Date.today + 1.day ).strftime("%Y-%m-%d")
        date = ( Date.today + 1.day )
        capacity_params = { :available_on => (date), :location => "KC"}
        post :create, :capacity => capacity_params, :driver_name => "", :focus_date => Date.today
        text = "More capacity was added in <a>KC</a> for <a href='/capacities?focus_date=#{date_string}'> #{date_string} </a>"
        flash[:notice].should have_text(text)
      end
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

  describe "updating a capacity with a new driver" do
    it "should change the driver on the capicty to an existing driver" do
      old_driver = Factory( :driver, :name => 'old')
      new_driver = Factory( :driver, :name => 'new')
      capacity   = Factory( :capacity )
      capacity.drivers << old_driver
      Capacity.should_receive(:find).with('42').and_return(capacity)
      put :update, :id => '42', :driver_name => "new"
      capacity.drivers.include?(new_driver).should eql( true )
      capacity.drivers.include?(old_driver).should eql( false)
    end
    it "should create a new driver if one can not be found on a capacity update" do
      old_driver = Factory( :driver, :name => 'old')
      capacity   = Factory( :capacity )
      capacity.drivers << old_driver
      Capacity.should_receive(:find).with('42').and_return(capacity)
      Driver.find_by_name("new").should be_nil
      put :update, :id => '42', :driver_name => "new"
      Driver.find_by_name("new").should_not be_nil
    end
  end

end

