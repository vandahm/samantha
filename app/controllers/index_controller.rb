class IndexController < ApplicationController
  def index
    @posts = Post.paginated_list(params[:page])
  end

  def permalink
    @post = Post.find_by(:slug => params[:slug])
  end
end
