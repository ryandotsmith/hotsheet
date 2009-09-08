class DriversController < ApplicationController
  resource_controller

  def index 
    @drivers = Driver.find_by_sql( [ 'SELECT name FROM drivers WHERE name like ?','%' + params[:q] +'%' ]) if
      params[:q]
    string = ""
    @drivers.each do |driver|
      string += driver.name + "\n"
    end
    respond_to do |format|
      format.json { render :text => string } 
    end
  end

end
