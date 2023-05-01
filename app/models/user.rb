class User < ApplicationRecord
    has_many :operations
    has_many :groups
  
    validates :name, presence: true
  end