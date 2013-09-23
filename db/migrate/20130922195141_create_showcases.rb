class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.integer :garage_id
      t.boolean :active
      t.integer :normal_offset
      t.integer :iphone_offset
      t.integer :tag_id
      t.string :caption
      t.string :description

      t.timestamps
    end
  end
end
