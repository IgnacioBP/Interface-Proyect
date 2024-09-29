class TweetsController < ApplicationController
    def index
        @tweets = Tweet.all(created_at: :desc)
        @reaction_levels = ReactionLevel.all
    end

    def show
        @tweet = Tweet.find params[:id]
    end

    def new
        @tweet = Tweet.new
    end

    def create
        tweet = Tweet.new tweet_params
        tweet.user = current_user
        if tweet.save
            redirect_to tweet, notice: 'Tweet guardado con éxito'
        else
            render :new
        end
    end

    def destroy
        tweet = Tweet.find params[:id]
        tweet.destroy
        redirect_to tweets_path, notice: 'Tweet eliminado con éxito'
    end

    def react
        @tweet = Tweet.find(params[:tweet_id])
        @reaction_level = ReactionLevel.find(params[:reaction_level_id])
        @user_reaction = @tweet.user_tweet_reactions.find_or_initialize_by(user: current_user)
        @user_reaction.update(reaction_level: @reaction_level)
        respond_to do |format|
          format.js
        end
         # Líneas de depuración
        puts "Tweet ID: #{@tweet.id}"
        puts "Reaction Level ID: #{@reaction_level.id}"
        puts "User Reaction: #{@user_reaction.inspect}"
    end

    private
    def tweet_params
        params.require(:tweet).permit(:body, :hashtags)
    end
end