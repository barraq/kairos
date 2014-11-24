# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Add bower components to assets path
Kairos::Application.configure do
  config.assets.append_path 'vendor/components'
end

# Initialize the Rails application.
Rails.application.initialize!
