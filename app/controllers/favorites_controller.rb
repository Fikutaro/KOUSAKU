class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    if @article.user_id != current_user.id   # 投稿者本人以外に限定
      @favorite = Favorite.create(user_id: current_user.id, article_id: @article.id)
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: @article.id)
    @favorite.destroy
  end

  def index
    favorites = Favorite.where(user_id: current_user.id).pluck(:article_id)  # ログイン中のユーザーのお気に入りのarticle_idカラムを取得
    @favorite_list = Article.find(favorites)
  end

  
end
