class UrlsController < ApplicationController
  def index
  end

  def create
    @url = Url.new(permitted_url_params)

    if @url.save
      flash[:success] = 'DwarfUrl generated successfully !'
      redirect_to @url
    else
      flash[:alert] = @url.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  def show
    @url = Url.friendly.find(params[:id])
  end

  def permitted_url_params
    params.require(:url).permit(:url_content, :alias).merge({ :user => current_user })
  end
end
