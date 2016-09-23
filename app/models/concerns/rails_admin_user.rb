module RailsAdminUser
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        field :name
        field :email
        field :admin
        field :password
        field :password_confirmation
        field :chatwork_id
        field :chatwork_api_key
      end

      list do
        field :id
        field :name
        field :email
        field :chatwork_id
        field :chatwork_api_key
        field :admin
      end
    end
  end
end

