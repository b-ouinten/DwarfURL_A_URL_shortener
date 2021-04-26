class UrlsController < ApplicationController
  def index
  end

  def create
    params = permitted_url_params
    alias_is_empty = params[:alias].gsub(/\s/, '').empty?
    if alias_is_empty
      new_alias = ''
      loop do
        new_alias = generate_random_string(8)
        break if Url.where(alias: new_alias).empty?
      end

      params[:alias] = new_alias
    end
    
    @url = Url.new(params)

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
