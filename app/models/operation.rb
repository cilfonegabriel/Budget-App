class Operation < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :groups
  
    validates :name, presence: true
    validates :author, presence: true
    validates :amount, presence: true
  end