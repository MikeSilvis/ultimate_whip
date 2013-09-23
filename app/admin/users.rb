ActiveAdmin.register User do

  show do
    attributes_table do
      row :id
      row :email
      row :username
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :created_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      table_for user.vehicles do
        column "id" do |vehicle|
          link_to vehicle.id, [:admin, vehicle ]
        end
        column "make" do |vehicle|
          vehicle.make_name
        end
      end
    end
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
