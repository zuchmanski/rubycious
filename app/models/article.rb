require 'uri'

class Article < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  TAGS_REGEXP = /#\w+/
  URL_REGEXP = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  TWITTER_TEMPLATE = ->(article) { %{ "article.title"  } }

  default_scope :order => "created_at DESC"

  attr_accessible :title, :url, :body

  validates :title, :presence => true, :length => { :in => 2..60 }
  validates :url, :presence => true, :format => { :with => URL_REGEXP }
  validates :body, :presence => true, :length => { :in => 6..160 }

  after_save :create_tags

  has_many :articles_tags
  has_many :tags, :through => :articles_tags
  has_many :points
  belongs_to :user

  scope :verified, where(:verified => true)
  scope :unverified, where(:verified => false)

  paginates_per 25

  def hostname
    URI(self.url).host
  end

  def voted_by?(user)
    self.points.where(:user_id => user).count > 0
  end

  def verify!
    self.update_attribute(:verified, true)
  end

  def create_tags
    self.body.scan(TAGS_REGEXP).each do |tag|
      tag_name = tag[1..-1].downcase
      tag = Tag.find_or_create_by_name(tag_name)
      self.tags << tag if self.tags.where(:name => tag_name).count == 0
    end
  end

end
