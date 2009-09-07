class Driver < ActiveRecord::Base
  has_and_belongs_to_many :capacities
end
