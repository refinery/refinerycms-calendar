class EventCategory < ActiveRecord::Base
  has_many :event_categorizations
  has_many :events, :through => :event_categorizations
  
  validates :name, :presence => true
  
  has_friendly_id :name, :use_slug => true
end
