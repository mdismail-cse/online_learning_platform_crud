class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
    @enrolled_course_ids = session[:enrolled_courses] || []
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def enroll
    @course = Course.find(params[:id])
    user_identifier = session[:user_identifier] || generate_user_identifier # Use a session-based user identifier or generate a new one
    
    if Enrollment.exists?(user_identifier: user_identifier, course: @course)
      redirect_to @course, notice: 'You are already enrolled in this course.'
    else
      @enrollment = Enrollment.new(user_identifier: user_identifier, course: @course)
    
      if @enrollment.save
        @course.increment!(:enrollment_count)
        redirect_to @course, notice: 'Enrollment successful.'
      else
        redirect_to @course, alert: 'Enrollment failed.'
      end
    end
  end
  
  
  private
  def generate_user_identifier
    # Generate a unique identifier for the user
    SecureRandom.hex(8)
  end
  
  



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :registration_fee)
    end
  
  



end
