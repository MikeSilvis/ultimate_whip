class Make < ActiveRecord::Base
  attr_accessible :model_id, :name, :type_id
  belongs_to :model
  belongs_to :type

  def self.find_with_graph(id)
    where(id: id).joins(:type, :model).first
  end

end
