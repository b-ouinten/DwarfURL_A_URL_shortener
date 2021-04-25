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
    puts '-' * 60
    puts '-' * 60
  end

  def permitted_url_params
    params.require(:url).permit(:content, :alias).merge({ :user => current_user })
  end
end
