class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string      :name
      t.integer     :follow_count
      t.boolean     :active
    end
  end
end
