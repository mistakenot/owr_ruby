class AddImdbidToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :imdbId, :string
  end
end
