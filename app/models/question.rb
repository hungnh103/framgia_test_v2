class Question < ActiveRecord::Base
  include RailsAdminQuestion
  include RailsAdmin::Engine.routes.url_helpers

  PARAMS_ATTRIBUTES = [:content, :subject_id, :user_id, :question_type,
    options_attributes: [:id, :content, :correct, :_destroy]]

  belongs_to :subject
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :exams, through: :results

  enum state: [:waiting, :accepted, :rejected]
  enum question_type: [:single_choice, :multiple_choice, :text]

  validates :content, presence: true

  accepts_nested_attributes_for :options, allow_destroy: true

  scope :systems, ->{joins(:user).where users: {admin: true}}
  scope :suggestion, -> {joins(:user).where users: {admin: false}}
  scope :most_failed, ->quantity do
    joins(:results)
    .where("results.correct is false")
    .group(:id).order("COUNT(results.question_id) DESC").limit(quantity)
  end
  scope :random_with_subject, ->subject do
    where(state: :accepted, active: 1, subject: subject)
      .order("RAND()").limit subject.number_of_question || 30
  end

  def active_question
    if active?
      I18n.t("questions.labels.question_active").html_safe
    else
      I18n.t("questions.labels.question_deactive").html_safe
    end
  end

  class << self
    def most_failed_json quantity
      Question.most_failed(quantity).eager_load(:results).map do |question|
        {
          id: question.id,
          frequency: question.results.incorrects.count,
          url: "#{RailsAdmin::Engine.routes.url_helpers
            .show_question_path("Question", question)}"
        }
      end.to_json
    end
  end
end

