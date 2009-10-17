namespace :db do

  desc "erase and populate db with some fake data"
  task :populate => :environment do 
    require 'populator' 
    require 'faker'
    [Driver,Capacity].each(&:delete_all)

    Driver.populate 10 do |driver|
      driver.name = Faker::Name.name
      Capacity.populate 10 do |capacity|
        capacity.available_on = (Date.today - 4.days)..(Date.today + 4.days)  
        capacity.location     = Faker::Address.us_state_abbr 
        capacity.priority     = -1..1
        ActiveRecord::Base.connection.execute("INSERT INTO capacities_drivers(capacity_id,driver_id) VALUES (#{capacity.id}, #{driver.id})")
      end
    end

  end

end
