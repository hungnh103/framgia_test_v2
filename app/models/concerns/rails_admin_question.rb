module RailsAdminQuestion
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        scopes [nil, :systems, :suggestion, :waiting, :rejected]
        # filters [:subject_id]
        field :id
        field :content do
          formatted_value do
            bindings[:view].content_tag(:a, "#{bindings[:object].content}" ,
              href: "/admin/question/#{bindings[:object].id}/show_question")
          end
        end
        field :subject
        field :user
        field :created_at do
          filterable false
        end
        field :active_question do
          label "Active"
        end
      end
    end
  end
end
