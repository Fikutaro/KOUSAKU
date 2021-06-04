class Article < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :chapters, dependent: :destroy
  attachment :article_image

  enum difficulty: {
    '選択してください': 0, 'かんたん':1, 'ふつう':2, 'むずかしい':3}
end
