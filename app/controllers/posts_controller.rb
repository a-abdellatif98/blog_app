class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  # GET /posts
  def index
    @posts = Post.all
    Rails.logger.info('Fetched all posts from the database')
    render json: @posts
  end

  # GET /posts/1
  def show
    Rails.logger.info("Fetched post with ID #{params[:id]} from the database")
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      Rails.logger.info("Created a new post with ID #{params[:id]}")
      render json: @post, status: :created, location: @post
    else
      Rails.logger.error('Failed to create a new post: ' + @post.errors.full_messages.join(', '))
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      Rails.logger.info("Updated post with ID #{params[:id]}")
      render json: @post
    else
      Rails.logger.error('Failed to create a new post: ' + @post.errors.full_messages.join(', '))
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :published)
  end
end
