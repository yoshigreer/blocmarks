class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = Bookmark.where(topic_id: @topic.id)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:title))

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def destroy
  @topic = Topic.find(params[:id])

  if @topic.destroy
    flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
    redirect_to action: :index
  else
    flash.now[:alert] = "There was an error deleting the topic."
    render :show
  end
end
end
