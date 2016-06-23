class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :address
      t.string :location
      
      t.attachment :picture
    end
  end
end
