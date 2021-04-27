class Url < ApplicationRecord
  # Associations
  belongs_to :user, optional: true
  
  # Validations
  validates :url_content, presence: true, uniqueness: { message: "already exist !" }
  validates :alias, uniqueness: { message: "already exist !" }

  # Friendly_id gem
  extend FriendlyId
  friendly_id :alias, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
end
