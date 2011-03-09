require 'acts_as_commentable'

class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'
  
  validates :name, :presence => true
  validates :comment, :presence => true
  validates :commentable, :presence => true
  
  acts_as_commentable
  alias_attribute :replies, :comments
  
  def commentable?
    not commentable.is_a?(Comment)
  end

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  # belongs_to :user
  
end
