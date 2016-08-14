class AddDefaultUsernameFirstnameLastnameValues < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, default: ""
    change_column :users, :first_name, :string, default: ""
    change_column :users, :last_name, :string, default: ""        
  end
end
