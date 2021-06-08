class Article < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :chapters, dependent: :destroy
  attachment :article_image
  
  
  def self.search(keyword)
  where(["title like? OR body like? OR preface like? OR material like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
  
  def save_tags(savearticle_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - savearticle_tags
    new_tags = savearticle_tags - current_tags
    
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end
    
    
    new_tags.each do |new_name|
      article_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << article_tag
    end
  end

  enum difficulty: {
    '選択してください': 0, 'かんたん':1, 'ふつう':2, 'むずかしい':3}
end
