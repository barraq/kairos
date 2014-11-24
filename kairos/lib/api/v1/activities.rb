module API
  module V1
    class Activities < Grape::API
      before { authenticate! }

      resource :activities do

        desc "Return list of activities"
        get do
          Activity.all()
        end

        desc "Create a new activity"
        params do
          requires :name, type: String
          requires :description, type: String
        end
        post do
          activity = Activity.new(name: params[:name], description: params[:description])

          if activity.valid?
            activity.save()
            present activity, with: API::Entities::Activity
          else
            render_api_error!("Activity already exists", 409);
          end
        end

        desc "Update an activity"
        params do
          requires :id, type: Integer
          optional :name, type: String
          optional :description, type: String
        end
        put do
          activity = Activity.find(params[:id])
          not_found!('Activity not found') unless activity

          attrs = attributes_for_keys [:name, :description]

          if attrs.empty?
            render_api_error!('Required parameters "name" or "description" ' \
                            'missing',
                              400)
          end

          if activity.update(attrs)
            present activity, with: API::Entities::Activity
          else
            render_validation_error!(activity)
          end
        end
      end
    end
  end
end