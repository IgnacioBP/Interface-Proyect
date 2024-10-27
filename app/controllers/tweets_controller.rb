class TweetsController < ApplicationController
    # Ensure only logged-in users can create, update, and delete tweets
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  
    # GET /tweets
    def index
        @tweets = Tweet.includes(:user, :user_tweet_reactions).map { |tweet| tweet.set_current_user(current_user) }
        @reaction_levels = ReactionLevel.all
    end
  
    # GET /tweets/:id
    def show
        @tweet = Tweet.find(params[:id])
      end
      
  
    # GET /tweets/new
    def new
      @tweet = Tweet.new
      puts "Rendering new tweet form"
    end
  
    # POST /tweets
    def create
      @tweet = current_user.tweets.new(tweet_params)
      if @tweet.save
        redirect_to root_path, notice: 'Tweet creado exitosamente'
      else
        render :new
      end
    end
  
    # GET /tweets/:id/edit
    def edit
    end
  
    # PATCH/PUT /tweets/:id
    def update
      if @tweet.update(tweet_params)
        redirect_to @tweet, notice: 'Tweet actualizado con éxito.'
      else
        flash.now[:alert] = 'Hubo un problema al actualizar el tweet.'
        render :edit
      end
    end
  
    # DELETE /tweets/:id
    def destroy
      @tweet.destroy
      redirect_to tweets_path, notice: 'Tweet eliminado con éxito.'
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
      end
    end
    
    
        
    private
  
    # Use callbacks to set the tweet for show, edit, update, and destroy actions
    def set_tweet
      @tweet = Tweet.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to tweets_path, alert: 'El tweet que buscas no existe.'
    end
  
    # Strong parameters for tweets
    def tweet_params
      params.require(:tweet).permit(:body, :hashtags)
    end
  end
  