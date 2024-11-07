
class Student < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :sections, through: :schedules

  validates :first_name, :last_name, presence: true
end
