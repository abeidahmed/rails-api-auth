class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create!(
      username: params[:user][:username],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )

    if @user.save
      log_in(@user)
      render json: {
        user: @user,
        status: :created,
        logged_in: true
      }
    else
      render json: @user.errors.full_messages, status: 401
    end
  end

  def update
    @user = User.find(params[:id])
    if @user && @user.update_attributes(user_params)
      render json: {
        user: @user,
        updated: true
      }
    elsif !@user
      render json: ['Could not locate user'], status: 400
    else
      render json: @user.errors.full_messages, status: 401
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      render json: { message: "Successfully deleted account!" }
    else
      render ["Could not find user"]
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
