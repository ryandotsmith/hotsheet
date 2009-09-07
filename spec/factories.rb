Factory.define :driver do |driver|
  driver.name     { "Ryan Smith" } 
end

Factory.define :capacity do |capacity|
  capacity.location     { "Kansas City"        } 
  capacity.notes        { "need a good load"   }
  capacity.available_on {  Date.today          } 
  capacity.drivers      { [ Factory(:driver) ] }
end


