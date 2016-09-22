class Ticket < ApplicationRecord
  belongs_to :project
  
  belongs_to :author, class_name: :User
  
  belongs_to :state
  before_validation :set_state, on: :create
  
  has_many :comments, dependent: :delete_all
  
  has_and_belongs_to_many :tags, -> { distinct.order('created_at asc') }
  attr_accessor :tag_names
  def tag_names=(names)
    @tag_names = names
    set_tags(names)
  end
  
  validates :name, presence: true
  
  validates :description, presence: true
  
  private
  
    def set_state
      self.state = State.default
    end
    
    def set_tags(names)
      names.split.each do |name|
        self.tags << Tag.find_or_initialize_by(name: name)
      end
    end
end
