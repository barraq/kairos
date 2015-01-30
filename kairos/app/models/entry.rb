class Entry < ActiveRecord::Base
  extend ActiveSupport::Concern

  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :activity, :class_name => 'Activity', :foreign_key => 'activity_id'

  validates_presence_of :date, :duration, :user, :activity_id, :group

  validates :duration, numericality: { greater_than: 0.0 }
  validates :group, numericality: { only_integer: true }
  validates :project, numericality: { only_integer: true }, allow_nil: true
  validates :issue, numericality: { only_integer: true }, allow_nil: true
end
