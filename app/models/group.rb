class Group < ApplicationRecord
  has_and_belongs_to_many :operations
  belongs_to :user

  validates :name, presence: true
  validates :icon, presence: true
end