class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: :User
  belongs_to :state
  has_many :comments, dependent: :delete_all
  attr_accessor :tag_names
  has_and_belongs_to_many :tags, -> { distinct.order('created_at asc') }
  
  validates :name, presence: true
  validates :description, presence: true
  
  before_validation :set_state_to_default, on: :create
  
  def tag_names=(names)
    @tag_names = names
    set_tags(names)
  end
  
  private
  
    def set_state_to_default
      self.state ||= State.default
    end
    
    def set_tags(names)
      names.split.each do |name|
        self.tags << Tag.find_or_initialize_by(name: name)
      end
    end
end
