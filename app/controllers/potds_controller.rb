class PotdsController < ApplicationController

  load_and_authorize_resource
  
  # GET /potds
  # GET /potds.json
  def index
    # if params[:search].present?
    #   @search = Potd.search do
    #     fulltext params[:search]
    #   end
    #   @potds = @search.results
    # else
    #   @potds = Potd.all
    # end

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

    @commentable = @potd
    @comments = @commentable.comments
    @comment = Comment.new

    @active_school_day = most_recent_day_for_material(@potd)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @potd }
    end
  end

  # GET /potds/new
  # GET /potds/new.json
  def new
    @potd = Potd.new
    @action = "Create"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @potd }
    end
  end

  # GET /potds/1/edit
  def edit
    @potd = Potd.find(params[:id])
    @action = "Update"

    @active_school_day = most_recent_day_for_material(@potd)
    load_prev_and_next_day
  end

  # POST /potds
  # POST /potds.json
  def create
    @potd = Potd.new(params[:potd])

    respond_to do |format|
      if @potd.save
        if params[:last_page].empty?
          format.html { redirect_to @potd, notice: 'POTD was successfully created.' }
          format.json { render json: @potd, status: :created, location: @potd }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:last_page])) }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @potd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /potds/1
  # PUT /potds/1.json
  def update
    @potd = Potd.find(params[:id])

    respond_to do |format|
      if @potd.update_attributes(params[:potd])
        format.html { redirect_to @potd, notice: 'POTD was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @potd.errors, status: :unprocessable_entity }
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
