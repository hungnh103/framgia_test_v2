module RailsAdmin
  module Config
    module Actions
      class CreateQuestion < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :route_fragment do
          custom_key.to_s
        end

        register_instance_option :controller do
          proc do
            if request.get?
              @object = @abstract_model.new
              @object.options.build
              @subjects = Subject.all
            elsif request.post?
              question_params = params.require(:question).permit :content, :subject_id, :user_id,
                :state, :question_type, :active, options_attributes: [:id, :content, :correct, :_destroy]
              @object = @abstract_model.new question_params
              if @object.save
                if params[:commit] == "Save"
                  redirect_to show_question_path(Question, @object), notice: flash_message("create_question")
                else
                  redirect_to create_question_path(Question, @object), notice: flash_message("create_question")
                end
              end
            end
          end
        end

        register_instance_option :link_icon do
          "icon-plus"
        end
      end
    end
  end
end
