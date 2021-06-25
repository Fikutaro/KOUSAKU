class HomesController < ApplicationController
  def top
    # お気に入りの多い記事順で表示
    @all_ranks = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end
  
  def about
  end
end
