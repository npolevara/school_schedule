module Populate
  def generate_test_models
    10.times do
      Teacher.find_or_create_by!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    end
    20.times do
      Student.find_or_create_by!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    end
    10.times do
      Classroom.find_or_create_by!(
        name: Faker::Educator.subject,
      )
    end
    20.times do
      Subject.find_or_create_by!(
        name: Faker::Educator.subject,
        description: Faker::Lorem.sentence(word_count: 10)
      )
    end
  end

  def generate_sections_and_teachers_subjects
    teacher_ids = Teacher.pluck(:id)
    subject_ids = Subject.pluck(:id)
    classroom_ids = Classroom.pluck(:id)

    unless teacher_ids.empty? || subject_ids.empty? || classroom_ids.empty?
      days_of_week_options = [
        %w[Monday Wednesday Friday],
        %w[Tuesday Thursday],
        %w[Monday Wednesday],
        %w[Tuesday],
        %w[Friday],
        %w[Monday Tuesday Wednesday Thursday Friday]
      ]
      
      start_times = ["08:00", "10:00", "13:00", "15:00"]

      20.times do
        Section.create!(
          teacher_id: teacher_ids.sample,
          subject_id: subject_ids.sample,
          classroom_id: classroom_ids.sample,
          days_of_week: days_of_week_options.sample,
          start_time: start_times.sample,
          duration: [30, 45, 60, 90].sample
        )
      end

      levels = (1..5).to_a 

      teacher_ids.each do |teacher_id|
        subject_ids.sample(rand(1..subject_ids.size)).each do |subject_id|
          TeacherSubject.find_or_create_by(
            teacher_id: teacher_id,
            subject_id: subject_id,
            level: levels.sample
          )
        end
      end
    end
  end
end

class DefaultSeedGen
  extend Populate
  def self.run
    generate_test_models
    generate_sections_and_teachers_subjects
    puts "\nDatabase filled with test data\n"
  end
end

DefaultSeedGen.run
