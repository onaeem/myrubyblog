class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @category = Category.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, flash[:success] => "Your Post has been saved"
    else
      render "new"
    end
  end
  def post_params
    # we construct a strong parameters whitelist below
    # require(:post) means that the `params` hash MUST contain a :post key
    # permit(:title, :body, ...) = here we enumerate the attributes which we will accept from the form parameters; it acts as a whitelist
    params.require(:post).permit(:title, :body, :category_id)
  end

  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_path, flash[:success] => "Your Post has been updated"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, flash[:success] => "Your Post has been deleted"
  end

end
