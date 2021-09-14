class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  
  # GET /posts or /posts.json
  def index
    if params[:q] 
      @posts = Post.where('title = ?', params[:q]).or(Post.where('content = ?',params[:q]))
    else 
      @posts = Post.all
      # @posts = Post.all
    end
  end

  # GET /posts/1 or /posts/1.json
  def show

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit

  end

  # POST /posts or /posts.json
  def create
    @posts = Post.all
    @post = Post.new(post_params)
      if @post.save
      respond_to do |format|
        format.js {render nothing: true} 
      end
    end
    # unless @post.save 
    # render json: @post.errors
    # end
    
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @posts = Post.all.order(updated_at: :desc)
    respond_to do |format|
      if @post.update(post_params)
        format.js {render nothing: true} 
        format.html { redirect_to @post, notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.destroy
    @posts = Post.all.order(updated_at: :desc)
    respond_to do |format|
      format.js { render nothing: true }
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :q)
    end
end
