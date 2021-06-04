class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), success: "更新しました"
    else
      flash.now[:danger] = '更新に失敗しました。'
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :nickname, :email, :profile_image)
  end
end
