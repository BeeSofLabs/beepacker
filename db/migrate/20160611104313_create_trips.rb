class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string      :name
      t.decimal     :price
      t.string      :currency
      t.integer     :join_count
      t.datetime    :start_date
      t.datetime    :end_date
      t.attachment  :picture
      t.string      :status
      
      t.timestamps null: false
    end
  end
end
