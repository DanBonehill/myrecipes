class Issue < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :body, presence: true, length: { minimum: 5, maximum: 500 }
  validates :submitted_by, presence: true, length: { minimum: 3, maximum: 30 }
end
