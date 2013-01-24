ActiveAdmin.register Garage do
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
