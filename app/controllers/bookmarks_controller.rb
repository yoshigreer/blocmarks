class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new(params.require(:bookmark).permit(:url))
    @bookmark.topic = @topic

    authorize @bookmark

    if @bookmark.save
      redirect_to [@topic, @bookmark], notice: "Bookmark was saved successfully."
    else
      flash.now[:alert] = "Error creating Bookmark. Please try again."
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.url = params[:bookmark][:url]

    authorize @bookmark

    if @bookmark.save
      redirect_to [@bookmark.topic, @bookmark], notice: "Bookmark was saved successfully."
    else
      flash.now[:alert] = "Error creating Bookmark. Please try again."
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    authorize @bookmark


    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = "There was an error deleting the bookmark."
      render :show
    end
  end
end
