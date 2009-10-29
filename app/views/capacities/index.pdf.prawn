@capacities.each do |capacities|
  capacity_attrs = []
  date = capacities.first
  capacities.last.each do |capacity|
    capacity_attrs << [capacity.covered?.to_s,capacity.location,capacity.driver.name,capacity.notes]
  end
  pdf.text date, :align => :center
  pdf.table capacity_attrs,
    :column_widths => {0 => 100,1 => 100,2 => 100,3 => 200},
    :width    => 500,
    :position => :center,
    :headers  => ["Covered","Location","Driver","Notes"],
    :border_color => "gray",
    :border_style => :grid
  pdf.move_down(20)
end
