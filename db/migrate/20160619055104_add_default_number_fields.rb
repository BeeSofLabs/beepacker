class AddDefaultNumberFields < ActiveRecord::Migration
  def change
    change_column :itienaries, :image_count, :integer, default: 0
  end
end
