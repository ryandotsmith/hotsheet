require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CapacitiesHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(CapacitiesHelper)
  end
  it "should return a boolean like string when asking if a capaicty is covered"do
    capacity = Capacity.new
    helper.covered?( capacity ).should eql('false')
    capacity.fulfilled_on = DateTime.now
    helper.covered?( capacity ).should eql('true')
  end
end
