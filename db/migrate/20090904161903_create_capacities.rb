class CreateCapacities < ActiveRecord::Migration
  def self.up
    create_table :capacities do |t|
      t.string :location
      t.date :available_on
      t.datetime :fulfilled_on
      t.string :notes
      t.integer :priority, :default => 0
      t.integer :driver_id

      t.timestamps
    end
  end

  def self.down
    drop_table :capacities
  end
end
