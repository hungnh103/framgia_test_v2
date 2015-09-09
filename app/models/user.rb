class User < ActiveRecord::Base
  include RailsAdminUser

  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable, :recoverable

  has_many :exams, dependent: :destroy
  has_many :questions

  validates :chatwork_id, presence: true
  validates :chatwork_room_id, presence: true
end
