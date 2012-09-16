class CreateMakes < ActiveRecord::Migration
  def change
    create_table :makes do |t|
      t.integer :type_id
      t.integer :model_id
      t.string :name

      t.timestamps
    end
  end
end
