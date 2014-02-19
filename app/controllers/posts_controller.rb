class PostsController < ApplicationController
  include Resourced
  include Scopable

  def index
    find_resource
    respond_with_resource
  end

  def show
    find_resource
    respond_with_resource
  end

  def new
    new_resource
    respond_with_resource
  end

  def create
    new_resource
    flash_notice :create if create_resource
    respond_with_resource
  end

  def edit
    find_resource
    respond_with_resource
  end

  def update
    find_resource
    flash_notice :update if update_resource
    respond_with_resource
  end

  def destroy
    find_resource
    flash_notice :destroy if destroy_resource
    respond_with_resource
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end