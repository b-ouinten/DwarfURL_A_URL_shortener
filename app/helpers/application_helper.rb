module ApplicationHelper
  CHARSET = (('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a).freeze
  
  def generate_random_string(size)
    Array.new(size) { CHARSET.sample }.join
  end
  
  def flash_class(type)
    case type
      when 'notice' then 'alert-info'
      when 'success' then 'alert-success'
      when 'alert' then 'alert-warning'
      when 'danger' then 'alert-danger'
      when 'error' then 'alert-danger'
    end
  end
end
