class Api::V1::SessionsController < ApplicationController
  def create
    # @user = User.find_by(username: params[:user][:username].downcase)
    @user = User.find_by_credentials(params[:user][:username].downcase, params[:user][:password])
    if @user
      log_in(@user)
      render "api/v1/users/show"
    else
      render json: ["Nope. Wrong credentials!"], status: 401
    end
  end

  def destroy
    log_out!
    render json: ["Successfully logged out!"]
  end
end