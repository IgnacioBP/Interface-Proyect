class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      @tweets = @user.tweets.includes(:hashtags)
  
      if params[:query].present?
        @tweets = @tweets.joins(:hashtags).where(hashtags: { name: params[:query] })
      end
    end
  end
  