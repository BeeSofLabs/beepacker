class AddRelationItienariesBelongToTrips < ActiveRecord::Migration
  def change
    add_reference :itienaries, :trip, index: true
  end
end
