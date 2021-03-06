class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    @links = Link.where(user_id: current_user.id)
  end

  def new
    @link = Link.new
  end

  def create
    link = Link.new(
                    user_id: current_user.id,
                    slug: params[:slug],
                    target_url: params[:target_url]
                    )

    link.save

    redirect_to "/links/#{link.id}"
  end


  def show
    @link = Link.find(params[:id])

    unless current_user.id == @link.user_id
      redirect_to '/'
    end

  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    link = Link.find(params[:id])
    link.assign_attributes(
                           slug: params[:slug],
                           target_url: params[:target_url]
      )
    link.save

    redirect_to "/links/#{link.id}"

  end

  def destroy
    link = Link.find(params[:id])
    link.delete

    redirect_to '/'
  end

end
