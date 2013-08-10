class PotdsController < ApplicationController

  load_and_authorize_resource
  
  # GET /potds
  # GET /potds.json
  def index
    if request.referrer.split('/').last == "preview"
      @deleted_from_preview = true
    end

    @potds = Potd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @potds }
    end
  end

  # GET /potds/1
  # GET /potds/1.json
  def show
    @potd = Potd.find(params[:id])
    @from_preview = false

    @commentable = @potd
    @comments = @commentable.comments
    @comment = Comment.new

    @potd.mark_as_read! :for => current_user
    @potd.comments.each do |comment|
      comment.mark_as_read! :for => current_user
    end

    @active_school_day = most_recent_day_for_material(@potd)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @potd }
    end
  end

  def preview
    @potd = Potd.find(params[:id])
    @from_preview = true
    render "show_preview", :layout => "preview"
  end

  # GET /potds/new
  # GET /potds/new.json
  def new
    @potd = Potd.new
    @action = "Create"
    @active_school_day = SchoolDay.find(params[:day]) unless params[:day].nil? || params[:day].empty?
    load_prev_and_next_day

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @potd }
    end
  end

  def new_preview
    @potd = Potd.new
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # GET /potds/1/edit
  def edit
    @potd = Potd.find(params[:id])
    @action = "Update"

    @potd.mark_as_read! :for => current_user

    @active_school_day = most_recent_day_for_material(@potd)
    load_prev_and_next_day
  end

  def edit_preview
    @potd = Potd.find(params[:id])
    @from_preview = true
    render "form_preview", :layout => "preview"
  end

  # POST /potds
  # POST /potds.json
  def create
    @potd = Potd.new(params[:potd].merge :wikipedia => Potd.scrape_pic(params[:potd][:name]), :bio => Potd.scrape_bio(params[:potd][:name]))

    respond_to do |format|
      if @potd.save
        if params[:last_page].nil?
          format.html { redirect_to @potd, notice: 'POTD was successfully created.' }
          format.json { render json: @potd, status: :created, location: @potd }
        elsif params[:last_page].empty?
          format.html { redirect_to new_school_day_path + "?potd_added=#{@potd.id}#potds", notice: 'POTD was successfully created.' }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:last_page])) + "?potd_added=#{@potd.id}#potds", notice: 'POTD was successfully created.' }
        end
      else
        if request.referrer.split('/').last == "preview"
          @from_preview = true
          format.html { render "form_preview", :layout => "preview" }
          format.json { render json: @potd.errors, status: :unprocessable_entity }
        else
          format.html { render action: "new" }
          format.json { render json: @potd.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /potds/1
  # PUT /potds/1.json
  def update
    @potd = Potd.find(params[:id])

    respond_to do |format|
      if @potd.update_attributes(params[:potd].merge :wikipedia => Potd.scrape_pic(params[:potd][:name]), :bio => Potd.scrape_bio(params[:potd][:name]))
        format.html { redirect_to @potd, notice: 'POTD was successfully updated.' }
        format.json { head :no_content }
      else
        if request.referrer.split('/').last == "preview"
          @from_preview = true
          format.html { render "form_preview", :layout => "preview" }
          format.json { render json: @potd.errors, status: :unprocessable_entity }
        else
          format.html { render action: "edit" }
          format.json { render json: @potd.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /potds/1
  # DELETE /potds/1.json
  def destroy
    @potd = Potd.find(params[:id])
    @potd.destroy

    respond_to do |format|
      format.html { redirect_to potds_url, notice: "POTD was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
