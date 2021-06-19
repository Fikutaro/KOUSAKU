class ArticlesController < ApplicationController


  def index
    @articles = params[:tag_id].present? ? Tag.find(params[:tag_id]).articles.page(params[:page]).per(8) : Article.all.page(params[:page]).per(8)
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @articles = Article.search(params[:keyword]).page(params[:page]).per(8)
    @keyword = params[:keyword]
    render "index"
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @article = Article.new
    @tags = Tag.all
    @tag_map =TagMap.all
    @tag_ranks = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(20).pluck(:tag_id))
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    tag_list = params[:article][:tag_ids].split(",")
    if @article.save
      @article.save_tags(tag_list)
      redirect_to articles_path
    else
      @tags = Tag.all
      @tag_map =TagMap.all
      @tag_ranks = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(20).pluck(:tag_id))
      @article.body = "SIZE OVER"
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @tag_list =@article.tags.pluck(:tag_name).join(",")
    @tag_map =TagMap.all
    @tag_ranks = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(20).pluck(:tag_id))
  end

  def update
    @article = Article.find(params[:id])
    tag_list = params[:article][:tag_ids].split(',')
    if @article.update(article_params)
      @article.save_tags(tag_list)
      redirect_to user_path(current_user.id), success: "更新しました"
    else
      @tag_list =@article.tags.pluck(:tag_name).join(",")
      @tag_map =TagMap.all
      @tag_ranks = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(20).pluck(:tag_id))
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def article_params
    params.require(:article).permit(:title, :article_image, :preface, :body, :material, :production_time, :difficulty, :video)
  end

end
