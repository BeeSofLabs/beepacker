class CreateItienaries < ActiveRecord::Migration
  def change
    create_table :itienaries do |t|
      t.string      :title
      t.string      :content
      t.string      :transportation
      t.string      :location
      t.float       :lat, :limit => 30
      t.float       :lng, :limit => 30
      t.integer     :image_count
      t.datetime    :start_date
    end
  end
end
