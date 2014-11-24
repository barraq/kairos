require 'date'

module API
  module V1
    class Time < Grape::API
      before { authenticate! }

      namespace :time do

        desc "Enter new time entry"
        params do
          requires :day, type: String, regexp: /^\d{4}-\d{2}-\d{2}$/
          requires :duration, type: Float
          requires :group, type: Integer
          optional :activity, type: Integer
          optional :project, type: Integer
          optional :issue, type: Integer
        end
        post '/' do
          entry = Entry.new date: params[:day], user: current_user, duration: params[:duration], group: params[:group]

          if params[:activity]
            if Activity.where(id: params[:activity]).present?
              entry.activity_id = params[:activity]
            else
              render_api_error!("Activity does not exists", 403);
            end
          else
            entry.project = params[:project]
            entry.issue = params[:issue]
          end

          if entry.valid?
            entry.save()
            present entry, with: API::Entities::Entry
          else
            render_api_error!(entry.errors.full_messages.join(', '), 400)
          end
        end
      end
    end
  end
end