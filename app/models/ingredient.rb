class Ingredient < ApplicationRecord
  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end