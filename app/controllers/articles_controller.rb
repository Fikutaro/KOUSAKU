class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    redirect_to articles_path
  end

  def edit
  end

  private
  def article_params
    params.require(:article).permit(:title, :article_image, :preface, :body, :material, :production_time, :difficulty)
  end

end
