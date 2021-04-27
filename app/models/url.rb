class Url < ApplicationRecord
  # Callbacks
  before_validation :handle_alias
  
  # Associations
  belongs_to :user, optional: true
  
  # Validations
  validates :link, presence: true, uniqueness: { message: "already exist !" }
  validates :alias, uniqueness: { message: "already exist !" }
  
  # Gems
  # Friendly_id gem
  extend FriendlyId
  friendly_id :alias, use: :slugged
  
  def should_generate_new_friendly_id?
    new_record?
  end
  
  def normalize_friendly_id(string)
    string
  end

  private
  
  def handle_alias
    alias_is_empty = self.alias.gsub(/\s+/, '').empty?
    if alias_is_empty
      new_alias = ''
      loop do
        new_alias = generate_random_string(8)
        break if Url.where(alias: new_alias).empty?
      end

      self.alias = new_alias
    else
      self.alias = self.alias.strip.gsub(/\s+/, '-')
    end
  end
end
