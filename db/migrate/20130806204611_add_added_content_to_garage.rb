class AddAddedContentToGarage < ActiveRecord::Migration
  def change
    add_column :garages, :added_content, :datetime
  end
end
