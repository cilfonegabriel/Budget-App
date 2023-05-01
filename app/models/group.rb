class Group < ApplicationRecord
  has_and_belongs_to_many :operations
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true

  def value
    value = 0
    operations&.each do |op|
      value += op.amount
    end
    value
  end
end
