class Capacity < ActiveRecord::Base
  require 'set'
  belongs_to :driver
  named_scope :available_on, lambda { |date| 
    { :conditions => [ 'available_on = ?', date ] }
  }

  def self.all_by_availability( date=nil )
    hash = {}
    set  = Set.new( self.all ) if date.nil?
    set  = Set.new( self.available_on(date) ) unless date.nil?
    subsets = set.divide { |c| c.available_on }
    subsets.each do |subset|
      date = subset.first.available_on
      hash[date] = []
      subset.each do |capacity|
        hash[date] << capacity
      end
    end
    return hash
  end
end
