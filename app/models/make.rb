class Make < ActiveRecord::Base
  attr_accessible :model_id, :name, :type_id
  has_many :models

  def self.find_with_graph(id)
    where(id: id).joins(:type, :model).first
  end

  def self.all_ordered_by_name
    Make.order("name")
  end

end
