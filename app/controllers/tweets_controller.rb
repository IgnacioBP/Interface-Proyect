class TweetsController < ApplicationController
    def index
        @tweets = Tweet.includes(:user, :user_tweet_reactions).map { |tweet| tweet.set_current_user(current_user) }
        @reaction_levels = ReactionLevel.all
    end

    def show
        @tweet = Tweet.find params[:id]
    end

    def new
        @tweet = Tweet.new
    end

    def create
      @tweet = current_user.tweets.new(tweet_params)
      if @tweet.save
        redirect_to root_path, notice: 'Tweet creado exitosamente'
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
      
        if @tweet.react(@reaction_level, current_user)
          render json: {
            tweet_id: @tweet.id,
            reaction_display: render_to_string(
              partial: 'tweets/reaction_display', 
              locals: { 
                tweet: @tweet, 
                reaction_levels: ReactionLevel.all,
                current_user: current_user
              }, 
              formats: [:html]
            )
          }
        else
          render json: { error: 'Error al reaccionar al tweet' }, status: :unprocessable_entity
        ender json: { error: 'Error al reaccionar al tweet' }, status: :unprocessable_entity
        end
    end
      

    private
    def tweet_params
        params.require(:tweet).permit(:body, :hashtags)
    end
end