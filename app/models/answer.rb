class Answer < ActiveRecord::Base
  belongs_to :result
  belongs_to :option

  scope :not_correct, ->result_id do
    joins(:option)
    .where("options.correct =? and result_id =?", false, result_id).count
  end
  scope :option_correct, ->result_id do
    joins(:option)
    .where("options.correct =? and result_id =?", true, result_id).count
  end

  def is_correct?
    return false if option_id.nil?
    option.correct?
  end
end
