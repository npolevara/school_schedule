class ApplicationController < ActionController::Base
  before_action :set_current_student

  private

  # hardcode current student without authentication for now
  def set_current_student
    @current_student = Student&.first
  end
end
