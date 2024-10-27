# app/controllers/hashtags_controller.rb
class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(name: params[:name])
    @tweets = @hashtag.tweets.includes(:user, :hashtags) if @hashtag
    @reaction_levels = ReactionLevel.all
  end

  def search
    @query = params[:query]
    @hashtag = Hashtag.find_by(name: @query)
    @reaction_levels = ReactionLevel.all

    if @hashtag
      @tweets = @hashtag.tweets.includes(:user, :hashtags)
      # Si `user_id` está presente, filtra por tweets de ese usuario
      @tweets = @tweets.where(user_id: params[:user_id]) if params[:user_id].present?
      render :show
    else
      @tweets = []
      flash[:alert] = "No se encontraron tweets con el hashtag ##{@query}"
      render :show
    end
  end
end
