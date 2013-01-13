class CreateDefaultTags < ActiveRecord::Migration
  def change
    create_table :default_tags do |t|
      t.references :garage
      t.string :name

      t.timestamps
    end
  end
end
