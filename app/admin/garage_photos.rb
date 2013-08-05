ActiveAdmin.register GaragePhoto do

  filter :id

  controller do
    cache_sweeper :garage_sweeper
    def scoped_collection
      GaragePhoto.includes({garage: [:user, { model: :make }] })
    end
  end

  index do
    column :id do |photo|
      link_to photo.id, [:admin, photo]
    end
    column :make_name
    column :model_name
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs "Photo", :multipart => true do
      f.input :garage
      f.input :photo, :as => :file, :hint => f.template.image_tag(f.object.photo.url(:thumb)), multipart: true
    end
    f.actions
  end

  show do |photo|
    attributes_table do
      row :username
      row :garage
      row :photo do
        image_tag photo.photo_url_thumb
      end
    end
  end

end
