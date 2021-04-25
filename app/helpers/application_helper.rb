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
end
