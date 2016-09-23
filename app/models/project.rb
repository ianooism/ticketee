class Project < ApplicationRecord
  has_many :tickets, -> { order 'created_at desc' }, dependent: :delete_all
  
  alias_attribute :project_name, :name
  validates :project_name, presence: true, uniqueness: true
  
  validates :description, presence: true
end
