class SchoolDaysController < ApplicationController
  # GET /school_days
  # GET /school_days.json
  def index
    @school_days = SchoolDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @school_days }
    end
  end

  # GET /school_days/1
  # GET /school_days/1.json
  def show
    @school_day = SchoolDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @school_day }
    end
  end

  # GET /school_days/new
  # GET /school_days/new.json
  def new
    @school_day = SchoolDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @school_day }
    end
  end

  # GET /school_days/1/edit
  def edit
    @school_day = SchoolDay.find(params[:id])
  end

  # POST /school_days
  # POST /school_days.json
  def create
    @school_day = SchoolDay.new(params[:school_day])

    respond_to do |format|
      if @school_day.save
        if @school_day.post_id.nil?
          redirect_to 'potds/new'
        else
        format.html { redirect_to @school_day, notice: 'School day was successfully created.' }
        format.json { render json: @school_day, status: :created, location: @school_day }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @school_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /school_days/1
  # PUT /school_days/1.json
  def update
    @school_day = SchoolDay.find(params[:id])

    respond_to do |format|
      if @school_day.update_attributes(params[:school_day])
        format.html { redirect_to @school_day, notice: 'School day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @school_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_days/1
  # DELETE /school_days/1.json
  def destroy
    @school_day = SchoolDay.find(params[:id])
    @school_day.destroy

    respond_to do |format|
      format.html { redirect_to school_days_url }
      format.json { head :no_content }
    end
  end
end
