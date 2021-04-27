module UsersHelper
  def current_user_username
    current_user.email.gsub(/@\w+.\w+/, '')
  end
end