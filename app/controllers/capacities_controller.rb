class CapacitiesController < ApplicationController
  resource_controller
  create.wants.html { redirect_to capacities_url }
  create.flash { "More capacity was added in #{ object.location } " }

  def index
    if params[:focus_date]
      @focus_capacities = Capacity.all_by_availability( params[:focus_date] ) 
    else
      @focus_capacities = Capacity.all_by_availability( Date.today ) 
    end
    @focus_date = @focus_capacities.keys.pop
    # load all capacities excluding the one in focus
    # these capacitires will be loaded into the sidebar
    @capacities   = Capacity.all_by_availability
    # pick the Focus capacities out of the hash
    @capacities.delete( @focus_date )
    # build a new capacity for the form object
    @new_capacity = Capacity.new 
  end

end
