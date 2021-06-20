class UsersController < ApplicationController
  before_action :authenticate_user!, {only: [:edit, :update,:destroy]}
  before_action :ensure_current_user, {only: [:edit, :update]}

  def ensure_current_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger]="編集権限がありません"
      redirect_to("/articles")
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page]).per(3)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "会員情報を更新しました"
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :nickname, :email, :profile_image, :introduction)
  end
end
