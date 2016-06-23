class CreateHistoryTransactions < ActiveRecord::Migration
  def change
    create_table :history_transactions do |t|
      t.string :code
      t.string :name
      t.string :buyer
      t.string :owner
      t.string :ttype
      t.attachment :bill_picture
      
      t.references :user
      t.references :merchant
      
      t.timestamps null: false
    end
  end
end
