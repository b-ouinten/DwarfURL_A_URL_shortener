class Offline::UrlsController < ApplicationController
  before_action :handle_alias, only: :create
  before_action :set_urls, except: [:new, :create]
  
  def index

  end

  def new
    @url = Url.new
  end

  def create
    params = permitted_url_params
    params[:_alias] = @alias
    @url = Url.new params

    errors = check_validity(params)[:errors]
    if errors.empty?
      push_to_cookie_at :dwarfURLs, params.to_h
      flash[:success] = 'DwarfURL generated successfully !'
      redirect_to offline_my_dwarfURLs_path
    else
      flash[:alert] = "#{errors} !" 
      render :new
    end

  end

  def show
    _alias = params[:id]
    @url = @urls.keep_if { _1["_alias"] == _alias }.last
    
    redirect_to @url["link"]
  end
  
  def destroy
    _alias = params[:id]
    @urls.delete_if do |x|
      x["_alias"] == _alias
    end

    cookies.permanent[:dwarfURLs] = JSON.generate @urls
    redirect_to offline_my_dwarfURLs_path
  end

  private

  def permitted_url_params
    params.require(:url).permit :link, :_alias
  end

  def set_urls
    @urls = pull_cookie_at :dwarfURLs
  end

  def handle_alias
    @alias = permitted_url_params[:_alias]
    alias_is_empty = @alias.nil? || @alias.gsub(/\s+/, '').empty?
    if alias_is_empty
      new_alias = ''
      loop do
        new_alias = generate_random_string(8)
        break if not alias_exists? new_alias
      end

      @alias = new_alias
    else
      @alias = @alias.parameterize preserve_case: true
    end
  end

  def check_validity(params)
    errors = []
    errors << 'Link already exist' if link_exists? params[:link]
    errors << 'Alias already exist' if alias_exists? params[:_alias]
    { errors: errors.join(' and ') }
  end

  def link_exists?(link)
    urls = pull_cookie_at :dwarfURLs
    urls.any? { _1["link"].eql? link }
  end
  
  def alias_exists?(_alias)
    urls = pull_cookie_at :dwarfURLs
    (urls.any? { _1["_alias"].eql? _alias }) || (not Url.where(_alias: _alias).empty?)
  end
end
