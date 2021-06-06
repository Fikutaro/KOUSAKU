class CommentsController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    comment = current_user.comments.new(comment_params)
    comment.article_id = article.id
    comment.save
    redirect_to article_path(article)
  end

  def destroy
    Comment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    redirect_to article_path(params[:article_id])
  end
  
   private

  def comment_params
    params.require(:comment).permit(:comment_content, :comment_image_id)
  end
end
