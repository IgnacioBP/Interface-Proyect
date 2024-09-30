class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /comments or /comments.json
  before_action :set_tweet

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @comments = @tweet.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
  end


  def new
    @comment = Comment.new()
  end

  def create

    comment = Comment.new comment_params
    # Busca el tweet al que se va a asociar el comentario
    @tweet = Tweet.find(params[:tweet_id])

    # Asigna el usuario actual al comentario
    comment.user = current_user
    comment.tweet= @tweet
  
    # Guarda el comentario y redirige o renderiza en caso de error
    if comment.save
      redirect_to tweet_comments_path(@tweet), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end
  

  # GET /comments/1/edit
  def edit
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
  
    # Permitir solo los parámetros necesarios para el comentario
    def comment_params
      params.require(:comment).permit(:content)
    end
end
