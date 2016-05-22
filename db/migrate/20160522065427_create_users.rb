class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :email
      t.string      :password_digest
      t.string      :authentication_token
      t.string      :username
      t.string      :first_name
      t.string      :last_name
      t.datetime    :dob
      t.string      :interest
      t.string      :categories
      t.attachment  :avatar
      t.string      :reset_token

      t.timestamps null: false
    end
  end
end


