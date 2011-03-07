class Event < ActiveRecord::Base
  default_scope order('start_at ASC')
  
  scope :current, where(['start_at < ? and end_at >= ?', Time.now, Time.now])
  scope :upcoming, where(['start_at >= ?', Time.now])
  scope :featured, where(['featured IS NOT NULL and featured = ?', true])
  scope :not_featured, where(['featured IS NULL or featured = ?', false])
  scope :archive, where(['end_at < ?', Time.now])
  
  acts_as_indexed :fields => [:title, :venue_name, :venue_address, :ticket_link, :description]

  validates :title, :presence => true, :uniqueness => true
  validates :ticket_price, :numericality => true, :allow_blank => true
  validates :ticket_link, :format => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :allow_blank => true
  validate :ends_after_start
  
  has_friendly_id :title, :use_slug => true
  
  belongs_to :image
  
  def current?
    end_at >= Time.now
  end
  
  def upcoming?
    start_at >= Time.now
  end
  
  def archived?
    end_at < Time.now
  end
  
  def featured?
    featured == true
  end
  
  def status
    "current" if current?
    "coming up" if upcoming?
    "archived" if archived?
  end
  
  def next
    Event.where(['end_at >= ? AND start_at > ?', Time.now, self.start_at]).first
  end
  
  def prev
    Event.where(['end_at >= ? AND start_at < ?', Time.now, self.start_at]).reverse.first
  end
  
  private
  
  def ends_after_start
    errors.add(:base, "End at date must be after the start at date") if end_at < start_at
  end

end
