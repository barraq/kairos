# require helpers
Dir["#{Rails.root}/lib/api/*.rb"].each {|file| require file}

# require API v*
Dir["#{Rails.root}/lib/api/v[1-9]/root.rb"].each {|file| require file}

module API
  class Root < Grape::API
    prefix 'api'

    rescue_from ActiveRecord::RecordNotFound do
      rack_response({'message' => '404 Not found'}.to_json, 404)
    end

    rescue_from :all, :backtrace => true
    #error_formatter :json, API::ErrorFormatter

    format :json
    content_type :txt, "text/plain"

    helpers API::APIHelpers

    mount API::Session

    mount API::V1::Root
    # mount API::V2::Root (next version)
  end
end