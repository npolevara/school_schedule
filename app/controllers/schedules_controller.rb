class SchedulesController < ApplicationController
  before_action :set_student
  before_action :set_schedules, only: [:index, :download]

  def index
  end

  def create
    section = Section.find(params[:section_id])
    @schedule = @student.schedules.build(section: section)
    if @schedule.save
      redirect_to student_schedules_path(@student), notice: "#{section.subject.name} section added!"
    else
      redirect_to sections_path, alert: @schedule.errors.full_messages
    end
  end

  def destroy
    @student.schedules.find(params[:id])&.destroy!
    redirect_to student_schedules_path(@student), notice: 'Section removed!'
  end

  def download
    respond_to do |format|
      format.pdf do
        pdf = GenSchedulePdf.new(@student, @schedules)
        send_data pdf.render,
                  filename: "#{@student.first_name}_#{@student.last_name}_schedule.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  private

  def set_schedules
    @schedules = @student.schedules.eager_load(:section => [:subject, :teacher, :classroom])
  end

  def set_student
    @student = Student.find(params[:student_id])
  end
end
