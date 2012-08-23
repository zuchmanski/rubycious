class Point < ActiveRecord::Base

  attr_accessible nil

  validates_presence_of :user_id, :article_id
  validates_uniqueness_of :user_id, :scope => :article_id

  belongs_to :user
  belongs_to :article, :counter_cache => true

end
