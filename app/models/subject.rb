class Subject < ActiveRecord::Base

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true
  validates :chatwork_room_id, presence: true
  validates :number_of_question, presence: true, numericality: {only_integer: true,
    greater_than: 0}
  validates :duration, presence: true, numericality: {only_integer: true,
    greater_than: 0}

  def subject_duration
    "#{duration} minutes"
  end
end
