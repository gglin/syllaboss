class LecturesController < ApplicationController
  
  load_and_authorize_resource

  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all

    # @search = Lecture.search do
    #   fulltext params[:search]
    # end
    # @lectures = @search.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lectures }
    end
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @lecture = Lecture.find(params[:id])

    @commentable = @lecture
    @comments = @commentable.comments
    @comment = Comment.new

    @active_school_day = most_recent_day_for_material(@lecture)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lecture }
    end
  end

  # GET /lectures/new
  # GET /lectures/new.json
  def new
    @lecture = Lecture.new
    @active_school_day = SchoolDay.find(params[:day]) unless params[:day].nil? || params[:day].empty?
    load_prev_and_next_day

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lecture }
    end
  end

  # GET /lectures/1/edit
  def edit
    @lecture = Lecture.find(params[:id])
    
    @active_school_day = most_recent_day_for_material(@lecture)
    load_prev_and_next_day
  end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(params[:lecture])

    respond_to do |format|
      if @lecture.save
        if params[:last_page].nil?
          format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
          format.json { render json: @lecture, status: :created, location: @lecture }
        elsif params[:last_page].empty?
          format.html { redirect_to new_school_day_path + "?lecture_added=#{@lecture.id}#lectures", notice: 'Lecture was successfully created.' }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:last_page])) + "?lecture_added=#{@lecture.id}#lectures", notice: 'Lecture was successfully created.' }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lectures/1
  # PUT /lectures/1.json
  def update
    @lecture = Lecture.find(params[:id])

    respond_to do |format|
      if @lecture.update_attributes(params[:lecture])
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture = Lecture.find(params[:id])
    @lecture.destroy

    respond_to do |format|
      format.html { redirect_to lectures_url, notice: "Lecture was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
