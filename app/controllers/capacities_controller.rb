class CapacitiesController < ApplicationController
  resource_controller
  index.before do
    @new_capacity = Capacity.new 
  end
  create.wants.html { redirect_to capacities_url }
  create.flash { "More capacity was added in #{ object.location } " }
end
