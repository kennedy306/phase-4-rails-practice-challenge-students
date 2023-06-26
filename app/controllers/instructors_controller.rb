class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :no_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
    def index
      instructors = Instructor.all
      render json: instructors
    end
  
    def show 
      instructor = Instructor.find(params[:id])
      render json: instructor
    end
  
    def create
      instructor = Instructor.create(instructor_params)
      if instructor.valid?
        render json: instructor, status: :created
      else
        render json: { error: instructor.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      instructor = Instructor.find(params[:id])
      if instructor.update(instructor_params)
        render json: instructor
      else
        render json: { error: instructor.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      instructor = Instructor.find(params[:id])
      instructor.destroy
      head :no_content
    end
  
    private
  
    def no_response
      render json: { error: "Sorry, the record doesn't exist" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(invalid)
      render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
  
    def instructor_params
      params.require(:instructor).permit(:name)
    end
  end