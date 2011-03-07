class Event < ActiveRecord::Base
  default_scope order('start_at ASC')
  
  scope :current, where(['end_at > ?', Time.now])
  scope :upcoming, where(['start_at > ?', Time.now])
  scope :featured, where(['featured IS NOT NULL and featured = ?', true])
  scope :not_featured, where(['featured IS NULL or featured = ?', false])
  
  acts_as_indexed :fields => [:title, :venue_name, :venue_address, :ticket_link, :description]

  validates :title, :presence => true, :uniqueness => true
  validates :ticket_price, :numericality => true
  
  has_friendly_id :title, :use_slug => true
  
  belongs_to :image
  
  
end
