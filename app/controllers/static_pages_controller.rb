# app/controllers/static_pages_controller.rb
class StaticPagesController < ApplicationController
  def home
    @tweets = Tweet.includes(:user, :hashtags).order(created_at: :desc)
    @reaction_levels = ReactionLevel.all
  end
end
