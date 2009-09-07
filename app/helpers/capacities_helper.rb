module CapacitiesHelper

  def covered?( capacity )
    capacity.fulfilled_on.nil? ? "false" : "true"
  end

  def priority( capacity )
    case capacity.priority
    when 0
      'normal'
    when 1
      'high'
    when 2
      'top'
    end
  end
end
