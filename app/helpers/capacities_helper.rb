module CapacitiesHelper

  def covered?( capacity )
    capacity.fulfilled_on.nil? ? "false" : "true"
  end

end
