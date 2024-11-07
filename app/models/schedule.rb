class Schedule < ApplicationRecord
  belongs_to :student
  belongs_to :section

  validates :student_id, uniqueness: { scope: :section_id }
  validate :timeframes

  private

  def timeframes
    student.sections.each do |existing_section|
      if section.overlaps_with?(existing_section)
        errors.add(:base, "Overlap with #{existing_section.subject.name}")
        break
      end
    end
  end
end
