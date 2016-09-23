class Option < ActiveRecord::Base
  belongs_to :question
  has_many :answers, dependent: :destroy

  validates :content, presence: true

  scope :count_correct_option, ->question_id do
    where("question_id =? and correct =?", question_id, true).count
  end
  scope :correct_option, ->option_id do
    where "id =? and correct =?", option_id, true
  end
end
