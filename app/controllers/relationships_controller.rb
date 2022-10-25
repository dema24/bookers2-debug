class RelationshipsController < ApplicationController
  def followings
    user = User.find(params[:user_id])
    @user = user.followings
    @users = @user.all
  end

  def followers
    user =User.find(params[:user_id])
    @user = user.followers
    @users = @user.all
  end

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

end
