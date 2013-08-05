class HomeworksController < ApplicationController
  
  load_and_authorize_resource

  # GET /homeworks
  # GET /homeworks.json
  def index
    # if params[:search].present?
    #   @search = Homework.search do
    #     fulltext params[:search]
    #   end
    #   @homeworks = @search.results
    # else
    #   @homeworks = Homework.all
    # end
    @homeworks = Homework.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @homeworks }
    end
  end

  # GET /homeworks/1
  # GET /homeworks/1.json
  def show
    @homework = Homework.find(params[:id])

    @commentable = @homework
    @comments = @commentable.comments
    @comment = Comment.new

    @active_school_day = most_recent_day_for_material(@homework)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @homework }
    end
  end

  # GET /homeworks/new
  # GET /homeworks/new.json
  def new
    @homework = Homework.new
    @active_school_day = SchoolDay.find(params[:day]) unless params[:day].nil? || params[:day].empty?
    load_prev_and_next_day

    respond_to do |format|
      format.html # new.html.erb
       format.json { render json: @homework }
    end
  end

  # GET /homeworks/1/edit
  def edit
    @homework = Homework.find(params[:id])

    @active_school_day = most_recent_day_for_material(@homework)
    load_prev_and_next_day
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    @homework = Homework.new(params[:homework])

    respond_to do |format|
      if @homework.save #need an if statement -- if params[:from] redirect_to 
        if params[:last_page].nil?
          format.html { redirect_to @homework, notice: 'Homework was successfully created.' }
          format.json { render json: @homework, status: :created, location: @homework }
        elsif params[:last_page].empty?
          format.html { redirect_to new_school_day_path + "?homework_added=#{@homework.id}#homeworks", notice: 'Homework was successfully created.' }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:last_page])) + "?homework_added=#{@homework.id}#homeworks", notice: 'Homework was successfully created.' }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /homeworks/1
  # PUT /homeworks/1.json
  def update
    @homework = Homework.find(params[:id])

    respond_to do |format|
      if @homework.update_attributes(params[:homework])
        format.html { redirect_to @homework, notice: 'Homework was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework = Homework.find(params[:id])
    @homework.destroy

    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: "Homework was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
