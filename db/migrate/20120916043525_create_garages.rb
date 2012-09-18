class CreateGarages < ActiveRecord::Migration
  def change
    create_table :garages do |t|
      t.integer :model_id
      t.integer :year
      t.integer :color_id
      t.integer :user_id
      t.timestamps
    end
  end
end
