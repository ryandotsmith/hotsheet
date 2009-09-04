class CapacitiesController < ApplicationController
  resource_controller
  index.before do
    @new_capacity = Capacity.new 
  end
end

