class ArticlesTag < ActiveRecord::Base

  belongs_to :tag
  belongs_to :article

end
