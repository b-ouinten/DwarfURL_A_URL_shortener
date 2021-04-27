class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def generate_random_string(size)
    charset = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a
    Array.new(size) { charset.sample }.join
  end
end
