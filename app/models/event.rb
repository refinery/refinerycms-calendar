class Event < ActiveRecord::Base
  has_many :event_categorizations
  has_many :categories, :through => :event_categorizations, :source => :event_category
  
  default_scope order('start_at ASC')
    
  scope :current, where(['start_at < ? and end_at >= ?', Time.now, Time.now])
  scope :upcoming, where(['start_at >= ?', Time.now])
  scope :featured, where(['featured IS NOT NULL and featured = ?', true])
  scope :not_featured, where(['featured IS NULL or featured = ?', false])
  scope :live, where(['end_at > ?', Time.now])
  
  scope :by_year, lambda { |archive_year|
    where(['start_at between ? and ?', archive_year.beginning_of_year, archive_year.end_of_year])
  }
  
  acts_as_indexed :fields => [:title, :venue_name, :venue_address, :ticket_link, :description]

  validates :title, :presence => true
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
    Event.where(['start_at > ?', start_at]).first
  end
  
  def prev
    Event.where(['start_at < ?', start_at]).reverse.first
  end

  def single_day?
    end_at.blank? || start_at.blank? || (end_at - start_at) < 24*60*60
  end

  def multi_day?
    !single_day?
  end
  
  def self.archive
    with_exclusive_scope { order('start_at DESC').where 'end_at < ?', Time.now }
  end
  
  def self.by_archive archive_date
    with_exclusive_scope { order('start_at DESC').where 'start_at between ? and ?', archive_date.beginning_of_month, archive_date.end_of_month }
  end
  
  def self.for_archive_list
    with_exclusive_scope { order('start_at DESC').where(['end_at < ?', Time.now.beginning_of_month]) }
  end
  
  private
  
  def ends_after_start
    start_at ||= Time.now
    end_at ||= start_at.advance(:hours => 1)
    errors.add(:base, "End at date must be after the start at date") if end_at < start_at
  end

end
