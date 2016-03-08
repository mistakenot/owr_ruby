class VotesController < ApplicationController
  def create
    @review = Review.find(vote_params[:review_id])
    @title = Title.find(@review.title_id)
    @vote = Vote.new(vote_params)

    if !Vote.find_by user_id: current_user.id, review_id: @review.id
      @vote.save
      redirect_to title_path(@title)
    else
      render plain: "Already voted."
    end
  end

  def new
  end

  private
    def vote_params
      params[:vote][:user_id] = current_user.id
      params.require(:vote).permit(:user_id, :review_id)
    end
end
