class HomeController < ApplicationController
  def _index
  end

  def index
    @recent_reviews = Review
      .order(created_at: :desc)
      .take(10)

    title_ids = @recent_reviews.map { |r| r.title_id }

    @recent_titles = Title.find(title_ids)
  end
end
