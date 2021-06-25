class Article < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :chapters, dependent: :destroy
  attachment :article_image

  validates :title, presence: true, length: { maximum: 50 }
  validates :preface, length: { maximum: 100 }
  validates :material, presence: true, length: { maximum: 500 }
  validates :production_time, presence: true, length: { maximum: 500 }
  validates :difficulty, exclusion: { in: %w(選択してください), message: "を選んでください" }
  validates :body, presence: true

  has_one_attached :video

  def self.search(keyword)
    where(["title like? OR body like? OR preface like? OR material like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    #タイトル、つくりかた、前書き、つかうものから検索 
  end

  def save_tags(savearticle_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - savearticle_tags
    new_tags = savearticle_tags - current_tags

  # 既存のタグがある場合
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

  #同名のタグがない場合、新しいタグ作成 
    new_tags.each do |new_name|
      article_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << article_tag
    end
  end

# 記事の並べ替え
  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return find(Favorite.group(:article_id).order(Arel.sql('count(article_id) desc')).pluck(:article_id))
    end
  end

  enum difficulty: {
    "選択してください": 0, "かんたん":1, "ふつう":2, "むずかしい":3}
end
