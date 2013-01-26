class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.timestamps
    end
  end
end
