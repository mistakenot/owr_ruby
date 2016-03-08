class AddRatingToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :ratings, :decimal
  end
end
