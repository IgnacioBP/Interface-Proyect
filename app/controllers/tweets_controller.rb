class TweetsController < ApplicationController
    # Ensure only logged-in users can create, update, and delete tweets
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  
    # GET /tweets
    def index
        @tweets = Tweet.all
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
      @tweet = Tweet.new(tweet_params)
      @tweet.user = current_user
      if @tweet.save
        redirect_to @tweet, notice: 'Tweet guardado con éxito.'
      else
        flash.now[:alert] = 'Hubo un problema al guardar el tweet.'
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
  