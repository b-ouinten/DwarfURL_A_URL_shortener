class Url < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :content, presence: true
  validates :alias, uniqueness: true
end
