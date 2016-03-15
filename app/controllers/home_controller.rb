class HomeController < ApplicationController
  def _index
  end

  def index
    recent_reviews = Review
      .order(created_at: :desc)
      .take(10)

    title_ids = recent_reviews.map { |r| r.title_id }

    @recently_reviewed = Title.find(title_ids)
    @recent_titles = Title
      .order(created_at: :desc)
      .take(10)
  end
end
