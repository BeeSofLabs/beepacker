class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :code
      t.string :name
      t.string :buyer
      t.string :owner
      t.string :ttype
      t.attachment :bill_picture
      
      t.timestamps null: false
    end
  end
end
