class Activity < ActiveRecord::Base
  validates :name, uniqueness: true
end
