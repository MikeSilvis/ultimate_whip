ActiveAdmin.register Landing do
  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :description, :input_html => {:class => "ckeditor"}
    end
    f.actions
  end

   controller do
    def permitted_params
      params.permit!
    end
  end
end
