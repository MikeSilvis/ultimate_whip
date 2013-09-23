ActiveAdmin.register Showcase do

  form do |f|
    f.inputs do
      f.input :active
      f.input :normal_offset, label: "Vertical Positioning"
      f.input :iphone_offset, label: "Vertical Positioning for iPhone"
      f.input :garage, collection: Hash[Garage.includes(:model).order(:id).map {|g| ["#{g.id} - #{g.model.name}",g.id]} ], label: "Car to link to"
      f.input :garage_photo, collection: Hash[GaragePhoto.all.order(:id).map{|b| [b.id,b.id]}], label: "Photo to use"
      f.input :tag, label: "Always show on this tag"
      f.input :caption
      f.input :description
      f.actions
    end
  end

   controller do
    def permitted_params
      params.permit!
    end
  end

end
