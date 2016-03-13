class ReviewsController < ApplicationController
  def index
  end

  def create
    @title = Title.find(params[:title_id])
    @review = @title.reviews.create(review_params)

    if user_signed_in?
      @review.user_id = current_user.id
      @review.save
    end

    redirect_to title_path(@title)
  end

  private
    def review_params
      params.require(:review).permit(:content, :user)
    end
end
