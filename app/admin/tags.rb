ActiveAdmin.register Tag do

  controller do
    cache_sweeper :tag_sweeper
  end

   controller do
    def permitted_params
      params.permit!
    end
  end
end
