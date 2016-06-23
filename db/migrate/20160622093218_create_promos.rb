class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string      :title
      t.string      :content
      t.float       :lat, :limit => 30
      t.float       :lng, :limit => 30
      t.attachment  :picture
      t.datetime    :start_date
      t.datetime    :end_date
      t.integer     :visitor_count
      t.integer     :promotype
      t.string      :status # show or hide
      
      t.timestamps null: false
    end
  end
end
