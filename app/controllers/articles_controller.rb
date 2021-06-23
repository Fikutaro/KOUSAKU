class ArticlesController < ApplicationController
  before_action :authenticate_user!, {only: [:new,:create, :edit, :update,:destroy]}
  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}

  def ensure_current_user
    @article = Article.find(params[:id])
    if @article.user != current_user
      flash[:danger]="編集権限がありません"
      redirect_to("/articles")
    end
  end

  def index
    @articles = params[:tag_id].present? ? Tag.find(params[:tag_id]).articles.page(params[:page]).per(8) : Article.all.page(params[:page]).per(8).order(created_at: :DESC)
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @articles = Article.search(params[:keyword]).page(params[:page]).per(8)
    @keyword = params[:keyword]
    selection = params[:sort]
    if selection.present?
      @articles = Kaminari.paginate_array(Article.sort(selection)).page(params[:page]).per(8)
    end
    @sorted = params[:sort]
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
      redirect_to articles_path, notice: "記事の投稿ができました"
    else
      @tags = Tag.all
      @tag_map =TagMap.all
      @tag_ranks = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(20).pluck(:tag_id))
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
      redirect_to user_path(current_user.id), notice: "投稿を更新しました"
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
    redirect_to user_path(current_user.id), notice: "投稿を削除しました"
  end

  private

  def article_params
    params.require(:article).permit(:title, :article_image, :preface, :body, :material, :production_time, :difficulty, :video)
  end

end
