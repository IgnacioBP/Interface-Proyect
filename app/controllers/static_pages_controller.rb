# app/controllers/static_pages_controller.rb
class StaticPagesController < ApplicationController
  def home
    @tweets = Tweet.includes(:user, :hashtags).all
    @reaction_levels = ReactionLevel.all
  end
end
