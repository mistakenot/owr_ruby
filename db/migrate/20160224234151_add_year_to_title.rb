class AddYearToTitle < ActiveRecord::Migration
  def change
    add_column :titles, :year, :int
  end
end
