class UrlsController < ApplicationController
  def index
    
  end
  
  def new
    
  end

  def create
    @url = Url.new(permitted_url_params)

    if @url.save
      flash[:success] = 'DwarfUrl generated successfully !'
      redirect_to urls_path
    else
      flash[:alert] = @url.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @url = Url.friendly.find(params[:id])
  end

  def permitted_url_params
    params.require(:url).permit(:url_content, :alias).merge({ :user => current_user })
  end
end
