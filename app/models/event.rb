class Event < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :venue_name, :venue_address, :ticket_link, :description]

  validates :title, :presence => true, :uniqueness => true
  validates :ticket_price, :numericality => true
  
  belongs_to :image
end
