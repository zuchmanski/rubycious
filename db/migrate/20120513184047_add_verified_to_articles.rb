class AddVerifiedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :verified, :boolean, :default => false
  end
end
