require 'csv'

class Entry < ActiveRecord::Base
  extend ActiveSupport::Concern

  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :activity, :class_name => 'Activity', :foreign_key => 'activity_id'

  validates_presence_of :date, :duration, :user, :activity, :group

  validates :duration, numericality: { greater_than: 0.0 }
  validates :group, numericality: { only_integer: true }
  validates :description, length: { maximum: 144 }
  validates :project, numericality: { only_integer: true }, allow_nil: true
  validates :issue, numericality: { only_integer: true }, allow_nil: true

  def date=(value)
    begin
      if /\d{1,2}\/\d{1,2}\/\d{4}/.match(value)
        write_attribute :date, Date.strptime(value, '%d/%m/%Y').strftime("%Y-%m-%d")
      else
        write_attribute :date, Date.strptime(value, '%Y-%m-%d').strftime("%Y-%m-%d")
      end
    rescue
      errors[:date] = 'date is invalid'
    end
  end

  # Import uploaded `file` data into `user` entries.
  def self.import(file, user)
    return if file.nil?

    processed = {
        skipped: 0,
        imported: 0
    }

    CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
      begin
        params = row.to_hash
        Entry.create! date: params[:date],
                      user: user,
                      duration: params[:duration].to_f,
                      activity: Activity.find_by(name: params[:activity].to_s),
                      group: params[:group].to_i,
                      project: params[:project].to_i,
                      issue: params[:issue].to_i,
                      description: params[:description].to_s
      rescue
        processed[:skipped] += 1
      else
        processed[:imported] += 1
      end
    end

    processed
  end
end
