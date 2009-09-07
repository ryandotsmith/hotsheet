class CapacitiesController < ApplicationController
  resource_controller
  create.wants.html { redirect_to capacities_url }
  create.flash { "More capacity was added in #{ object.location } " }

  def index
    if params[:focus_date]
      @focus_capacity = Capacity.available_on( params[:focus_date] ) 
    else
      @focus_capacity = Capacity.available_on(Date.today) 
    end
    # load all capacities excluding the one in focus
    # these capacitires will be loaded into the sidebar
    @capacities   = Capacity.all.delete( @focus_capacity )
    # build a new capacity for the form object
    @new_capacity = Capacity.new 

  end

end
