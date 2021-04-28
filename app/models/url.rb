class Url < ApplicationRecord
  # Associations
  belongs_to :user
  
  # Validations
  validates :link, 
    presence: true, 
    uniqueness: { message: "already exist !" }
  validates :_alias, uniqueness: { message: "already exist !" }

  # Callbacks
  before_validation :handle_alias
  
  # Gems
  # Friendly_id gem
  extend FriendlyId
  friendly_id :_alias, use: :slugged
  
  def should_generate_new_friendly_id?
    new_record?
  end
  
  def normalize_friendly_id(string)
    string
  end

  private
  
  def handle_alias
    alias_is_empty = self._alias.nil? || self._alias.gsub(/\s+/, '').empty?
    if alias_is_empty
      new_alias = ''
      loop do
        new_alias = generate_random_string(8)
        break if Url.where(_alias: new_alias).empty?
      end

      self._alias = new_alias
    else
      self._alias = self._alias.strip.gsub(/\s+/, '-')
    end
  end
end
