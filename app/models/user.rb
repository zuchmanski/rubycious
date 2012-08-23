class User < ActiveRecord::Base

  has_many :articles
  has_many :points
  has_many :voted_articles, :through => :points, :source => 'article'

  def self.create_with_omniauth(auth)
    u = User.new(:uid => auth["uid"], :email => auth["info"]["email"], :username => auth["info"]["nickname"])
    u.valid? ? (u.save; u) : false
  end

end