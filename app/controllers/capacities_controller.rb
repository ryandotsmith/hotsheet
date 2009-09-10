class CapacitiesController < ApplicationController
  resource_controller
  #create.wants.html { redirect_to capacities_url }
  #create.flash { "More capacity was added in #{ object.location } " }

  def index
    if params[:focus_date]
      @focus_capacities = Capacity.all_by_availability( params[:focus_date] ) 
    else
      @focus_capacities = Capacity.all_by_availability( Date.today ) 
    end
    # added the || Date.today for the case when there are no 
    # focus_capacities and a view gets rendered. Views will often
    # call strftime on the focus_date
    @focus_date = @focus_capacities.keys.pop || Date.today
    # load all capacities excluding the one in focus
    # these capacitires will be loaded into the sidebar
    @capacities   = Capacity.all_by_availability
    # pick the Focus capacities out of the hash
    @capacities.delete( @focus_date )
    @capacities = @capacities.sort 
    # build a new capacity for the form object
    @new_capacity = Capacity.new 
  end

  def create
    @capacity = Capacity.new( params[:capacity] )

    if params[:driver_name] != ""
      driver = Driver.find_by_name( params[:driver_name] )
      if driver
        @capacity.drivers << driver
      else
        @capacity.drivers.build( :name => params[:driver_name])
      end
    end

    if @capacity.save
      flash[:notice] = "More capacity was added in #{ @capacity.location }"
      respond_to do |format|
       format.html { redirect_to capacities_url } 
      end
    end

  end# create

  update.after do
    object.fulfilled_on = DateTime.now if params[:fulfilled] == "true"
    object.save!
  end
  update.wants.js { render :text => 'good job' }

end
