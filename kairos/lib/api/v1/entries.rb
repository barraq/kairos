module API
  module V1
    class Entries < Grape::API
      before { authenticate! }

      resource :entries do

        helpers do
          def interval_from_date params
            (year, month, day) = params[:date].split('-').map { |e| e.to_i }

            from = Date.new *[year, month, day].compact
            to = Date.today

            if day
              from = from.beginning_of_week
              to = from.end_of_week
            elsif month
              to = from.end_of_month
            else
              to = from.end_of_year
            end

            from..to
          end
        end

        desc "Return list of all entries"
        get do
          @entries = Entry.all()

          @entries = paginate @entries
          present @entries, with: Entities::Entry
        end

        desc "Return list of entries for specific user and given date"
        get ':date/users/:id' do
          @entries = Entry.where(user_id: params[:id].to_i, date: interval_from_date(params))

          if @entries
            present @entries, with: API::Entities::Entry
          else
            no_found!
          end
        end

        desc "Return list of entries for specific group and given date"
        get ':date/groups/:id' do
          @entries = Entry.where(group: params[:id].to_i, date: interval_from_date(params))

          if @entries
            present @entries, with: API::Entities::Entry
          else
            no_found!
          end
        end

        desc "Return list of entries for specific project and given date"
        get ':date/projects/:id' do
          @entries = Entry.where(project: params[:id].to_i, date: interval_from_date(params))

          if @entries
            present @entries, with: API::Entities::Entry
          else
            no_found!
          end
        end

        desc "Return list of entries for specific issue and given date"
        get ':date/issues/:id' do
          @entries = Entry.where(issue: params[:id].to_i, date: interval_from_date(params))

          if @entries
            present @entries, with: API::Entities::Entry
          else
            no_found!
          end
        end
      end
    end
  end
end