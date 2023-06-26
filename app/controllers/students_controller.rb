class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :no_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
    def index
      students = Student.all
      render json: students
    end
  
    def show
      student = Student.find(params[:id])
      render json: student
    end
  
    def create
      student = Student.create(student_params)
      if student.valid?
        render json: student, status: :created
      else
        render json: { error: student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      student = Student.find(params[:id])
      if student.update(student_params)
        render json: student
      else
        render json: { error: student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      student = Student.find(params[:id])
      student.destroy
      head :no_content
    end
  
    private
  
    def student_params
      params.require(:student).permit(:name, :age, :major, :instructor_id)
    end
  
    def no_response
      render json: { error: "Sorry, the record doesn't exist" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(invalid)
      render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
  end