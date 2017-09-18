class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @tags = Tag.all

    if params[:tag]
      # @posts = Post.tagged_with(params[:tag])
      @posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page])
    elsif params[:term]
      @posts = Post.where('title ILIKE ? OR body ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%").paginate(:page => params[:page]).order('id DESC')
      if @posts.empty?
        flash.now[:notice] = "Your search didn't pull up any results. TRY AGAIN"
      end
    else
      #@posts = Post.all
      @posts = Post.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Successfully created post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Successfully updated post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error updating post!"
      render :edit
    end
  end

  def show
    @tags = Post.find(params[:id]).tags
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to posts_path
    else
      flash[:alert] = "Error updating post!"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :all_tags)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
