module RailsAdminSubject
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        field :name
        field :number_of_question
        field :duration do
          label "Duration(minute)"
        end
        field :chatwork_room_id
      end

      list do
        field :id
        field :name
        field :number_of_question
        field :duration
        field :chatwork_room_id
        field :created_at
      end

      show do
        field :name
        field :chatwork_room_id
        field :number_of_question
        field :duration do
          formatted_value{bindings[:object].subject_duration}
        end
        field :exams
        field :questions
      end
    end
  end
end
