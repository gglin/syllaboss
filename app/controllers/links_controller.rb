class LinksController < ApplicationController

  load_and_authorize_resource

  # GET /links
  # GET /links.json
  def index
    # if params[:search].present?
    #   @search = Link.search do
    #     fulltext params[:search]
    #   end
    #   @links = @search.results
    # else
    #   @links = Link.all
    # end
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    @commentable = @link
    @comments = @commentable.comments
    @comment = Comment.new

    @link.mark_as_read! :for => current_user

    @link.comments.each do |comment|
      comment.mark_as_read! :for => current_user
    end
    
    @active_school_day = most_recent_day_for_material(@link)
    load_prev_and_next_day

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new
    @active_school_day = SchoolDay.find(params[:day]) unless params[:day].nil? || params[:day].empty?
    load_prev_and_next_day
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])

    @link.mark_as_read! :for => current_user

    @active_school_day = most_recent_day_for_material(@link)
    load_prev_and_next_day
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(params[:link])
    @link.title=(params[:link] [:title])
    respond_to do |format|
      if @link.save
        if params[:last_page].nil?
          format.html { redirect_to @link, notice: 'Link was successfully created.' }
          format.json { render json: @link, status: :created, location: @link }
        elsif params[:last_page].empty?
          format.html { redirect_to new_school_day_path + "?link_added=#{@link.id}#links", notice: 'Link was successfully created.' }
        else
          format.html { redirect_to edit_school_day_path(SchoolDay.find(params[:last_page])) + "?link_added=#{@link.id}#links", notice: 'Link was successfully created.' }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
