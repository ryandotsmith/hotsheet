Factory.define :capacity do |capacity|
  capacity.location     { "Kansas City"      } 
  capacity.notes        { "need a good load" }
  capacity.available_on {  Date.today         } 
  capacity.association :driver, :factory => :driver
end

Factory.define :driver do |driver|
  driver.name     { "Ryan Smith" } 
end
