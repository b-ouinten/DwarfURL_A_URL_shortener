class Url < ApplicationRecord
  # Associations
  belongs_to :user, optional: true

  # Validations
  validates :content, presence: true
  validates :alias, uniqueness: { message: "This alias is already exist " }
end
