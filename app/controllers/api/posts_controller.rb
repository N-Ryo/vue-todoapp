class Api::PostsController < ApplicationController

  # GET /posts
  def index
    # 後々のため、更新順で返します
    @posts = Post.order('updated_at DESC')
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      render :show, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render :show, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.fetch(:post, {}).permit(
          :title, :firstContent, :secondContent, :thirdContent, :forthContent, :fifthContent, :rname, :is_display, :status
      )
    end
end
