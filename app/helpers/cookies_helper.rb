module CookiesHelper
  def push_to_cookie_at(key, item)
    cookie = pull_cookie_at key
    cookie.push item
    cookies.permanent[key] = JSON.generate(cookie)
  end

  def pull_cookie_at(key)
    cookies[key] ? JSON.parse(cookies[key]) : []
  end
end