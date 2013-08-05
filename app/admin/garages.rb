ActiveAdmin.register Garage do

  controller do
    cache_sweeper :garage_sweeper
    def scoped_collection
      Garage.includes({model: :make }, :color)
    end
  end

  index do
    column :id do |garage|
      link_to garage.id, [:admin, garage]
    end
    column :make
    column :model
    column :color
    column :year
    column :created_at
  end

  form do |f|
    f.inputs "Garage" do
      f.input :user
      f.input :color
      f.input :year
      f.input :model
    end
    f.inputs for: :photos do |photo, i|
      photo.input :id
      photo.input :_destroy, as: :boolean, label: "Delete"
      photo.input :photo, :as => :file, :hint => f.template.image_tag(photo.object.photo.url(:thumb)), multipart: true
      #photo.input :photo,  as: :file
    end

    #f.inputs "Photos" do
      #f.semantic_fields_for :photos do |photo|
        #photo.input :_destroy, as: :boolean, label: "Remove Photo"
      #end
    #end

    f.inputs "Bulk upload Photos" do
      f.input :forum_urls
      f.input :forum_div
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :model
      row :year
      row :color
      row :user
      row :created_at
      table_for garage.photos do
        column "photos" do |photo|
          link_to image_tag(photo.photo_url_thumb), [ :admin, photo ]
        end
      end
    end
  end

end
