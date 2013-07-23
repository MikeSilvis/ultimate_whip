ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Users" do
          table_for User.order("created_at DESC").limit(10) do
            column("Username")        { |user| link_to(user.username, admin_user_path(user)) }
            column("Registered on")   { |user| user.created_at                       }
          end
        end
      end

      column do
        panel "Recent Cars" do
          table_for Garage.order('updated_at desc').limit(10) do
            column(:type)    { |vehicle| link_to(vehicle.model.name, admin_garage_path(vehicle)) }
            column(:user) { |vehicle| link_to(vehicle.user.username, admin_user_path(vehicle.user))} 
            column(:updated_at) { |vehicle| vehicle.updated_at }
          end
        end
      end
    end

    columns do
      column do
        panel "Recent Photos" do
          table_for GaragePhoto.order("created_at DESC").limit(10) do
            column(:id) { |photo| link_to photo.id, admin_garage_photo_path(photo) }
            column(:photo) { |photo| image_tag photo.photo(:thumb) }
          end
        end
      end
      column do
        panel "Recent Comments" do
          table_for Comment.order("created_at DESC").limit(10) do
            column(:user) { |comment| comment.user.username }
            column(:comment) { |comment| comment.comment }
            column("On") { |comment| comment.commentable_type }
            column(:url) { |comment| link_to comment.url, comment.url, target: "_blank"  }
          end
        end
      end
    end
  end

end
