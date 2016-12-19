class HomeController < ApplicationController
  def index
    @posts = Post.last(3)
  end

  def about
  end
end
