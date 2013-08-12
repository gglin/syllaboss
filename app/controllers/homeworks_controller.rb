class HomeworksController < ApplicationController
  
  load_and_authorize_resource

  # GET /homeworks
  # GET /homeworks.json
  def index
    if request.referrer.split('/').last == "preview"
      @deleted_from_preview = true
    end

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
    @from_preview = false

    @commentable = @homework
    @comments = @commentable.comments
    @comment = Comment.new

    @homework.mark_as_read! :for => current_user
    @homework.comments.each do |comment|
      comment.mark_as_read! :for => current_user
    end

    @active_school_day = most_recent_day_for_material(@homework)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @homework }
    end
  end

  def preview
    @homework = Homework.find(params[:id])
    @from_preview = true
    render "show_preview", :layout => "preview"
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

  def new_preview
    @homework = Homework.new
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # GET /homeworks/1/edit
  def edit
    @homework = Homework.find(params[:id])

    @homework.mark_as_read! :for => current_user

    @active_school_day = most_recent_day_for_material(@homework)
    load_prev_and_next_day
  end

  def edit_preview
    @homework = Homework.find(params[:id])
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    @homework = Homework.new(params[:homework])

    respond_to do |format|
      if @homework.save
        if params[:last_page].nil?
          format.html { redirect_to @homework, notice: 'Homework was successfully created.' }
          format.json { render json: @homework, status: :created, location: @homework }
        elsif params[:last_page].empty?
          format.html { redirect_to new_school_day_path + "?homework_added=#{@homework.id}#homeworks", notice: 'Homework was successfully created.' }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:last_page])) + "?homework_added=#{@homework.id}#homeworks", notice: 'Homework was successfully created.' }
        end
      else
        if request.referrer.split('/').last == "preview"
          @from_preview = true
          format.html { render "form_preview", :layout => "preview" }
          format.json { render json: @homework.errors, status: :unprocessable_entity }
        else
          format.html { render action: "new" }
          format.json { render json: @homework.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /homeworks/1
  # PUT /homeworks/1.json
  def update
    @homework = Homework.find(params[:id])

    respond_to do |format|
      if @homework.update_attributes(params[:homework])
        if request.referrer.split('/').last == "preview"
          format.html { redirect_to homework_preview_path(@homework), notice: 'Homework was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @homework, notice: 'Homework was successfully updated.' }
          format.json { head :no_content }
        end
      else
        if request.referrer.split('/').last == "preview"
          @from_preview = true
          format.html { render "form_preview", :layout => "preview" }
          format.json { render json: @homework.errors, status: :unprocessable_entity }
        else
          format.html { render action: "edit" }
          format.json { render json: @homework.errors, status: :unprocessable_entity }
        end
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
