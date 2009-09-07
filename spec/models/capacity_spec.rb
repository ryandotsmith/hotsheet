require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Capacity do
  before(:each) do
    @valid_attributes = {
      :location => "value for location",
      :available_on => Date.today,
      :fulfilled_on => DateTime.now,
      :notes => "value for notes",
      :priority => 0
    }
  end

  it "should create a new instance given valid attributes" do
    Capacity.create!(@valid_attributes)
  end
end

describe "finding capacities by date" do

  before(:each) do
    3.times do |i|
      Factory( :capacity, :available_on => Date.today + i.days )
    end
  end
  it "should look for capacities by available date" do
    Capacity.available_on( Date.today).count.should eql( 1 )
    Capacity.available_on( Date.today + 1.day ).count.should eql( 1 )
    Capacity.available_on( Date.today + 2.days ).count.should eql( 1 )
    Capacity.available_on( Date.today + 3.days ).count.should eql( 0 )
  end
  it "should sort capacities into a hash with available_on dates as keys" do
    return_hash = Capacity.all_by_availability
    return_hash.length.should eql( 3 )
    3.times do |i|
      return_hash[(Date.today + i.days)].should_not be_nil
    end
    return_hash[(Date.today + 4.days)].should be_nil
  end

  it "should return a hash that has all of the capacities included" do
    return_hash = Capacity.all_by_availability
    dates = return_hash.keys
    capacities = return_hash.values
    (capacities.flatten - Capacity.all).should eql( [] )
  end
  it "should return data such that removal of elements is easy" do
    return_hash = Capacity.all_by_availability
    capacities = return_hash.values.flatten
    capacities.delete( Capacity.first )
    capacities.count.should eql( Capacity.count - 1 )
  end
end

describe "ensuring drivers get associated with capacity" do
  it "should load a default driver if none is given" do
    capacity = Capacity.new(:location => 'kansas city')
    capacity.drivers.should eql([])
    capacity.save
    capacity.drivers.pop.name.should eql("TBD")
  end
end








