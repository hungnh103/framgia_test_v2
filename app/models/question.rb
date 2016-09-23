class Question < ActiveRecord::Base
  include RailsAdminQuestion
  include RailsAdmin::Engine.routes.url_helpers

  belongs_to :subject
  belongs_to :user

  enum state: [:waiting, :accepted, :rejected]
  enum question_type: [:single_choice, :multiple_choice, :text]

  has_many :options, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :exams, through: :results

  validates :content, presence: true

  accepts_nested_attributes_for :options, allow_destroy: true

  scope :systems, ->{where user_id: User.select(:id).where(admin: true)}
  scope :suggestion, ->{where user_id: User.select(:id).where(admin: false)}
  scope :most_failed, ->quantity do
    joins(:results)
    .where("results.correct is false")
    .group(:id).order("COUNT(results.question_id) DESC").limit(quantity)
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

