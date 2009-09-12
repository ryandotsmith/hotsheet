class Driver < ActiveRecord::Base
  include ToHash
  has_and_belongs_to_many :capacities
end
