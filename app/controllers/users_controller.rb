class UsersController < ApplicationController
  def index
    users = User.all

    # ユーザー名絞り込み
    if params[:name].present?
      users = users.get_by_name params[:name]
    end

    # 性別絞り込み
    if params[:gender].present?
      users = users.get_by_gender params[:gender]
    end

    @users = users.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to@user
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to @user
  end

  def user_params
    params.require(:user).permit(:name,:gender,:birthday,:hometown,:remarks)
  end
end
