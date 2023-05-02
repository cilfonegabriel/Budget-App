class Group < ApplicationRecord
  has_and_belongs_to_many :operations
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  after_commit :add_default_image, on: %i[create update]

  def value
    value = 0
    operations&.each do |op|
      value += op.amount
    end
    value
  end

  private

  def add_default_image
    return if image.attached?

    image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'placeholder-image.png')),
                 filename: 'placeholder-image.png', content_type: 'image/png')
  end
end
