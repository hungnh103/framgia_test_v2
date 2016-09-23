class Subject < ActiveRecord::Base
  include RailsAdminSubject

  has_many :exams, dependent: :destroy
  has_many :questions

  validates :name, presence: true
  validates :number_of_question, presence: true,
    numericality: {only_integer: true, greater_than: 0}
  validates :duration, presence: true,
    numericality: {only_integer: true, greater_than: 0}

  def random_questions
    questions.where(active: 1).order("RAND()").limit number_of_question
  end

  def subject_duration
    "#{duration} minutes"
  end
end
