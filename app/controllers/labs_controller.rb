class LabsController < ApplicationController
  
  load_and_authorize_resource

  # GET /labs
  # GET /labs.json
  def index
    if request.referrer.split('/').last == "preview"
      @deleted_from_preview = true
    end

    @labs = Lab.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @labs }
    end
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
    @lab = Lab.find(params[:id])
    @from_preview = false

    @commentable = @lab
    @comments = @commentable.comments
    @comment = Comment.new

    @lab.mark_as_read! :for => current_user
    @lab.comments.each do |comment|
      comment.mark_as_read! :for => current_user
    end

    @active_school_day = most_recent_day_for_material(@lab)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lab }
    end
  end

  def preview
    @lab = Lab.find(params[:id])
    @from_preview = true
    render "show_preview", :layout => "preview"
  end

  # GET /labs/new
  # GET /labs/new.json
  def new
    @lab = Lab.new
    @active_school_day = SchoolDay.find(params[:day]) unless params[:day].nil? || params[:day].empty?
    load_prev_and_next_day

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lab }
    end
  end

  def new_preview
    @lab = Lab.new
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # GET /labs/1/edit
  def edit
    @lab = Lab.find(params[:id])

    @lab.mark_as_read! :for => current_user

    @active_school_day = most_recent_day_for_material(@lab)
    load_prev_and_next_day
  end

  def edit_preview
    @lab = Lab.find(params[:id])
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(params[:lab])

    respond_to do |format|
      if @lab.save
        if params[:last_page].nil?
          format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
          format.json { render json: @lab, status: :created, location: @lab }
        elsif params[:last_page].empty?
          format.html { redirect_to new_school_day_path + "?lab_added=#{@lab.id}#labs", notice: 'Lab was successfully created.' }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:last_page])) + "?lab_added=#{@lab.id}#labs", notice: 'Lab was successfully created.' }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /labs/1
  # PUT /labs/1.json
  def update
    @lab = Lab.find(params[:id])

    respond_to do |format|
      if @lab.update_attributes(params[:lab])
        if request.referrer.split('/').last == "preview"
          format.html { redirect_to lab_preview_path(@lab), notice: 'Lab was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab = Lab.find(params[:id])
    @lab.destroy

    respond_to do |format|
      format.html { redirect_to labs_url, notice: "Lab was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
