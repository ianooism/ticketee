class Project < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true
end
