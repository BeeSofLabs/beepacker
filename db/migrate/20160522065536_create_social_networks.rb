class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string  :provider
      t.integer :uid
      t.integer :user_id
      t.string  :token
      t.string  :secret
      t.string  :link
      t.string  :uid, default: ""
      
      t.timestamps null: false
    end
  end
end