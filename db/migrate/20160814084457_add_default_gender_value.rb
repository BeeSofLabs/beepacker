class AddDefaultGenderValue < ActiveRecord::Migration
  def change
    change_column :users, :gender, :string, default: ""
  end
end
