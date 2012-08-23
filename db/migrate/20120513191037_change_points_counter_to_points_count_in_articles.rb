class ChangePointsCounterToPointsCountInArticles < ActiveRecord::Migration
  def up
    rename_column :articles, :points_counter, :points_count
  end

  def down
  end
end
