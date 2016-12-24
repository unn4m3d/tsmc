# Posts controller
class PostsController < ApplicationController
  def index
  end

  def new
  end

  def create
    if can? :create, Post
      post = Post.create(
        title: params[:post][:title],
        text: params[:post][:text],
        user: current_user
      )
      redirect_to post_path post
    else
      errors.add(:user, 'You are not permitted to do this')
    end
  end

  def view
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    unless can? :update, @post
      errors.add(:user, 'You are not permitted to do this')
      redirect_to root_path
    end
  end

  # rubocop:disable AbcSize
  def commit
    @post = Post.find(params[:id])
    if can? :update, @post
      @post.text = params[:post][:text]
      @post.title = params[:post][:title]
      @post.save!
      redirect_to post_path @post
    else
      errors.add(:post, 'You are not permitted to do this')
    end
  end
  # rubocop:enable AbcSize

  def delete
    @post = Post.find(params[:id])
    if can? :delete, @post
      @post.delete!
      redirect_to root_path
    else
      errors.add(:post, 'You are not permitted to do this')
    end
  end
end
