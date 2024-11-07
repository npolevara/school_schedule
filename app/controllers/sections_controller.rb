class SectionsController < ApplicationController
  before_action :set_section, except: [:index, :new, :create]

  def index
    @sections = Section.all.eager_load(:subject, :teacher, :classroom)
  end

  def show
    @students = @section.students
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to @section, notice: 'Section created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to @section, notice: 'Section updated.'
    else
      render :edit
    end
  end

  def destroy
    @section.destroy
    redirect_to sections_url, notice: 'Section deleted.'
  end

  private
  
  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:teacher_id, :subject_id, :classroom_id, :days_of_week, :start_time, :duration)
  end
end
