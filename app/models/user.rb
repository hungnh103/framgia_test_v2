class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable, :recoverable

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :chatwork_id, presence: true
end
