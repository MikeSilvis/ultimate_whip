class CreateGarageTags < ActiveRecord::Migration
  def change
    create_table :garage_tags do |t|
      t.integer :garage_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
