class HomesController < ApplicationController
  def top
    @all_ranks = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end
  
  def about
  end
end
