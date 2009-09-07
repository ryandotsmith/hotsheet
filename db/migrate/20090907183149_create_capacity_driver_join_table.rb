class CreateCapacityDriverJoinTable < ActiveRecord::Migration
  def self.up
    create_table :capacities_drivers , :id => false do |t|
      t.integer :capacity_id
      t.integer :driver_id
    end
  end

  def self.down
  end
end
