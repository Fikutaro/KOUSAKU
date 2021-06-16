class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :profile_image

  validates :last_name, presence: true, length: { maximum: 100 }
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :kana_last_name, presence: true, length: { maximum: 100 }
  validates :kana_first_name, presence: true, length: { maximum: 100 }
  validates :nickname, presence: true, length: { maximum: 100 }

end
