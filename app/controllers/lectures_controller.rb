class LecturesController < ApplicationController
  
  load_and_authorize_resource

  # GET /lectures
  # GET /lectures.json
  def index
    if request.referrer.split('/').last == "preview"
      @deleted_from_preview = true
    end
    
    @lectures = Lecture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lectures }
    end
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @lecture = Lecture.find(params[:id])
    @from_preview = false

    @commentable = @lecture
    @comments = @commentable.comments
    @comment = Comment.new

    @lecture.mark_as_read! :for => current_user
    @lecture.comments.each do |comment|
      comment.mark_as_read! :for => current_user
    end

    @active_school_day = most_recent_day_for_material(@lecture)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lecture }
    end
  end

  def preview
    @lecture = Lecture.find(params[:id])
    @from_preview = true
    render "show_preview", :layout => "preview"
  end

  # GET /lectures/new
  # GET /lectures/new.json
  def new
    @lecture = Lecture.new
    @active_school_day = SchoolDay.find(params[:day]) unless params[:day].nil? || params[:day].empty?
    load_prev_and_next_day

    # @attachment = @lecture.attachments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lecture }
    end
  end

  def new_preview
    @lecture = Lecture.new
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # GET /lectures/1/edit
  def edit
    @lecture = Lecture.find(params[:id])

    @attachments = @lecture.attachments
    # @attachment  = @lecture.attachments.build
    
    @lecture.mark_as_read! :for => current_user

    @active_school_day = most_recent_day_for_material(@lecture)
    load_prev_and_next_day
  end

  def edit_preview
    @lecture = Lecture.find(params[:id])
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(params[:lecture])

    respond_to do |format|
      if @lecture.save
        if params[:day].nil?
          format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
          format.json { render json: @lecture, status: :created, location: @lecture }
        elsif params[:day].empty?
          format.html { redirect_to new_school_day_path + "?lecture_added=#{@lecture.id}#lectures", notice: 'Lecture was successfully created.' }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:day])) + "?lecture_added=#{@lecture.id}#lectures", notice: 'Lecture was successfully created.' }
        end
      else
        if request.referrer.split('/').last == "preview"
          @from_preview = true
          format.html { render "form_preview", :layout => "preview" }
          format.json { render json: @lecture.errors, status: :unprocessable_entity }
        else
          format.html { render action: "new", :locals => {:day => params[:day]} }
          format.json { render json: @lecture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /lectures/1
  # PUT /lectures/1.json
  def update
    @lecture = Lecture.find(params[:id])

    respond_to do |format|
      if @lecture.update_attributes(params[:lecture])
        if request.referrer.split('/').last == "preview"
          format.html { redirect_to lecture_preview_path(@lecture), notice: 'Lecture was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
          format.json { head :no_content }
        end
      else
        if request.referrer.split('/').last == "preview"
          @from_preview = true
          format.html { render "form_preview", :layout => "preview" }
          format.json { render json: @lecture.errors, status: :unprocessable_entity }
        else
          format.html { render action: "edit" }
          format.json { render json: @lecture.errors, status: :unprocessable_entity }
        end
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
