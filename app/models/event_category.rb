class EventCategory < ActiveRecord::Base
  default_scope order('name ASC')
  
  has_many :event_categorizations
  has_many :events, :through => :event_categorizations
  
  validates :name, :presence => true
  
  has_friendly_id :name, :use_slug => true
end
