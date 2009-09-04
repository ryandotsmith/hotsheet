require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Capacity do
  before(:each) do
    @valid_attributes = {
      :location => "value for location",
      :available_on => Time.now,
      :fulfilled_on => Time.now,
      :notes => "value for notes",
      :priority => 1,
      :driver_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Capacity.create!(@valid_attributes)
  end
end
