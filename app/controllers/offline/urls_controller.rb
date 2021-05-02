class Offline::UrlsController < ApplicationController
  before_action :handle_alias, only: :create
  
  def index
    @urls = pull_cookie_at(:dwarfURLs).reverse
  end

  def new
    @url = Url.new
  end

  def create
    params = permitted_url_params
    params[:_alias] = @alias
    push_to_cookie_at :dwarfURLs, params.to_h

    redirect_to offline_my_dwarfURLs_path
  end

  def show
    _alias = params[:id]
    @urls = pull_cookie_at :dwarfURLs
    @url = @urls.keep_if do |x|
      x["_alias"] == _alias
    end.last

    redirect_to @url["link"]
  end

  def destroy
  end

  private

  def permitted_url_params
    params.require(:url).permit(:link, :_alias)
  end

  def handle_alias
    @alias = permitted_url_params[:_alias]
    alias_is_empty = @alias.nil? || @alias.gsub(/\s+/, '').empty?
    if alias_is_empty
      new_alias = ''
      loop do
        new_alias = generate_random_string(8)
        break if Url.where(_alias: new_alias).empty?
      end

      @alias = new_alias
    else
      @alias = @alias.parameterize preserve_case: true
    end
  end
end
