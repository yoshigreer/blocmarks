class LikesController < ApplicationController
  def index
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      redirect_to [@bookmark.topic, @bookmark], notice: "Bookmark liked."
    else
      flash.now[:alert] = "Error. Please try again."
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = Like.where(id: params[:id]).first


    if like.destroy
      flash[:notice] = "\"#{@bookmark.url}\" unliked."
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash.now[:alert] = "There was an error, please try again."
      render :show
    end
  end
end
