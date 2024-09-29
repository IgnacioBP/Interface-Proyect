class StaticPagesController < ApplicationController
    def home
        @tweets = Tweet.all.includes(:user)
        @reaction_levels = ReactionLevel.all
    end
end