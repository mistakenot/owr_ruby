class ReviewsController < ApplicationController
  def index
  end

  def create
    @title = Title.find(params[:title_id])
    @review = @title.reviews.create(review_params)
    redirect_to title_path(@title)
  end

  private
    def review_params
      params.require(:review).permit(:content)
    end
end
