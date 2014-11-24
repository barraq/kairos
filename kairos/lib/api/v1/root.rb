Dir["#{Rails.root}/lib/api/v1/*.rb"].each {|file| require file}

module API
  module V1
    class Root < Grape::API
      version 'v1', using: :path, vendor: 'yeastlab'
      format :json

      mount API::V1::Activities
      mount API::V1::Entries
      mount API::V1::Time
    end
  end
end