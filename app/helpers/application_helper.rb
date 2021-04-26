module ApplicationHelper
  def flash_class(type)
    case type
      when 'notice' then 'alert-info'
      when 'success' then 'alert-success'
      when 'alert' then 'alert-warning'
      when 'danger' then 'alert-danger'
      when 'error' then 'alert-danger'
    end
  end

  def generate_random_string(size)
    charset = ('a'..'z').to_a + ('1'..'9').to_a
    Array.new(size) { charset.sample }.join
  end
end
