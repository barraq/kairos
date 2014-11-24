class Entry < ActiveRecord::Base
  extend ActiveSupport::Concern

  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :activity, :class_name => 'Activity', :foreign_key => 'activity_id'
  validates_presence_of :date, :duration, :user, :group
end
