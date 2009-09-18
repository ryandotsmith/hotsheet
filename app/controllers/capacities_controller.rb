class CapacitiesController < ApplicationController
  resource_controller
  def new 
    @capacity = Capacity.new
    respond_to do |format|
      format.js { render :action => 'new.js.erb', :layout => false }
    end
  end
  def edit
    @capacity = Capacity.find( params[:id] )
    respond_to do |format|
      format.html
        format.js { render :action => 'edit.js.erb', :layout => false }
      end
    end

    def show
      @capacity = Capacity.find( params[:id] )
      respond_to do |format|
        format.js { render :json => build_hash(@capacity)  } 
      end
    end

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
    set_or_initialize( params[:driver_name] )
    if @capacity.save
      flash[:notice] = "More capacity was added in #{ @capacity.location }"
      respond_to do |format|
       format.html { redirect_to capacities_url } 
      end
    end
  end# create

  def update
    @capacity = Capacity.find( params[:id] )
    @capacity.fulfilled_on = DateTime.now if params[:fulfilled] == "true"
    @capacity.fulfilled_on = nil if params[:fulfilled] == "false"
    set_or_initialize( params[:driver]['name'] ) if params[:driver]
    respond_to do |format|
      if @capacity.update_attributes!( params[:capacity] )
       format.html
       format.js { render :action => 'fulfilled.js', :layout => false } if params[:fulfilled] == "true" || params[:fulfilled] == "false"
       format.js { redirect_to @capacity, :status => :see_other } if params[:edit_in_place] == "true"
       format.js { render :action => 'update.js', :layout => false }
      end
    end
  end

private 

  def set_or_initialize( driver_name )
    if driver_name != ""
      driver = Driver.find_by_name( driver_name )
      if driver
        @capacity.drivers = [driver]
      else
        @capacity.drivers.build( :name => driver_name )
      end
    end
  end

  def build_hash( capacity )
    {:capacity => capacity.to_hash(:location), :driver => capacity.driver.to_hash(:name)} 
  end



end
