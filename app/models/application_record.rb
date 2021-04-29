class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  CHARSET = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a.freeze
  
  def generate_random_string(size)
    Array.new(size) { CHARSET.sample }.join
  end
end
