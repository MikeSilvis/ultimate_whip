ActiveAdmin.register Tag do

  controller do
    cache_sweeper :tag_sweeper
  end

end
