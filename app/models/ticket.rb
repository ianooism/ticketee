class Ticket < ApplicationRecord
  belongs_to :project
  
  belongs_to :author, class_name: :User
  
  belongs_to :state
  before_validation :set_state_as_default, on: :create
  
  has_many :comments, dependent: :delete_all
  
  has_and_belongs_to_many :subscribers, class_name: 'User'
  after_create :subscribe_author
  
  has_and_belongs_to_many :tags, -> { distinct.order('created_at asc') }
  def tag_names
    @tag_names = join_tag_names
  end
  def tag_names=(names)
    @tag_names = names
    set_tags(names)
  end
  
  validates :name, presence: true
  
  validates :description, presence: true
  
  private
    
    def set_state_as_default
      self.state = State.default
    end
    
    def join_tag_names
      if tags
        tag_names = []
        tags.each do |tag|
          tag_names << tag.name
        end
        tag_names.join(' ')
      end
    end

    def set_tags(names)
      names.split.each do |name|
        self.tags << Tag.find_or_initialize_by(name: name)
      end
    end
    
    def subscribe_author
      self.subscribers << author
    end
end
