class AddLinkToShowcase < ActiveRecord::Migration
  def change
    add_column :showcases, :link, :string
  end
end
