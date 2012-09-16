class CreateGaragePhotos < ActiveRecord::Migration
  def change
    create_table :garage_photos do |t|
      t.integer :garage_id

      t.timestamps
    end
  end
end
