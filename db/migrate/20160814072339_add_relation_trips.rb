class AddRelationTrips < ActiveRecord::Migration
  def change
    add_reference :trips, :user, index: true    
    add_reference :trips, :merchant, index: true    
    add_reference :trips, :category, index: true
  end
end
