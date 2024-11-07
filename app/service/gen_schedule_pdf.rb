class GenSchedulePdf

  def initialize(student, schedules)
    @student = student
    @schedules = schedules
  end

  def render
    Prawn::Document.new do |pdf|
      pdf.font "Helvetica"

      pdf.text "#{@student.first_name} #{@student.last_name}'s schedule", size: 24, style: :bold, align: :center
      pdf.move_down 20

      if @schedules.any?
        data = [["Subject", "Teacher", "Classroom", "Days", "Start at", "Finish at"]]

        @schedules.each do |schedule|
          section = schedule.section
          data << [
            section.subject.name,
            section.teacher.first_and_last_name,
            section.classroom.name,
            section.days_of_week.join(', '),
            section.short_start_time,
            section.short_finish_time
          ]
        end

        pdf.table(data, header: true, row_colors: ['DDDDDD', 'FFFFFF'], width: pdf.bounds.width) do
          row(0).font_style = :bold
          self.header = true
        end
      else
        pdf.text "You have not any schedule.", align: :center
      end
    end.render
  end
end
