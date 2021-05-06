module CookiesHelper
  def push_to_cookie_at(key, item)
    cookie = pull_cookie_at key
    cookie.unshift item
    cookies.permanent[key] = JSON.generate(cookie)
  end

  def pull_cookie_at(key)
    cookies[key] ? JSON.parse(cookies[key]) : []
  end

  def inject_cookie_urls_into_db
    urls = pull_cookie_at :dwarfURLs
    current_user.urls << urls.reverse.map { Url.new(_1) }
    cookies.delete :dwarfURLs
  end
end