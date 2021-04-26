class Url < ApplicationRecord
  # Associations
  belongs_to :user, optional: true
  
  # Validations
  validates :url_content, presence: true, uniqueness: { message: "already exist !" }
  validates :alias, uniqueness: { message: "already exist !" }

  # Extra
  extend FriendlyId
  friendly_id :alias, use: :slugged
end
