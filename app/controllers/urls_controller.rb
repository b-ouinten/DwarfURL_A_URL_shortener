class UrlsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @urls = current_user.urls.order(created_at: :desc)
  end
  
  def new
    @url = Url.new
  end

  def create
    @url = current_user.urls.new(permitted_url_params)

    if @url.save
      flash[:success] = 'DwarfURL generated successfully !'
      redirect_to urls_path
    else
      flash[:alert] = @url.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @url = Url.friendly.find(params[:id])
    redirect_to @url.link
  end

  def permitted_url_params
    params.require(:url).permit(:link, :alias)
  end
end
