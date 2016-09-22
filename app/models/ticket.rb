class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: :User
  belongs_to :state
  
  has_many :comments, dependent: :delete_all
  has_and_belongs_to_many :tags, -> { distinct.order('created_at asc') }
  
  validates :name, presence: true
  validates :description, presence: true
  
  attr_accessor :tag_names
  
  def tag_names= (names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end
  
  before_validation :set_default_state, on: :create
  
  private
  
    def set_default_state
      self.state ||= State.default
    end
end
