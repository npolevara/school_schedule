class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom

  has_many :schedules
  has_many :students, through: :schedules
  validates :days_of_week, :start_time, :duration, presence: true

  serialize :days_of_week, Array

  def short_start_time
    start_time.strftime("%I:%M %p")
  end

  def short_finish_time
    (start_time + duration.minutes).strftime("%I:%M %p")
  end

  def overlaps_with?(other_section)
    common_days = self.days_of_week & other_section.days_of_week
    return false if common_days.empty?

    self_start = self.start_time
    self_end = self_start + self.duration.minutes

    other_start = other_section.start_time
    other_end = other_section.start_time + other_section.duration.minutes

    self_start < other_end && other_start < self_end
  end
end
