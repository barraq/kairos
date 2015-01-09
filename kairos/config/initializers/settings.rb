# Be sure to restart your server when you modify this file.

class Settings < Settingslogic
  source ENV.fetch('KAIROS_CONFIG') { "#{Rails.root}/config/kairos.yml" }
  namespace Rails.env
end

#
# Kairos
#
Settings['kairos'] ||= Settingslogic.new({})
Settings.kairos['https']               = false if Settings.kairos['https'].nil?
Settings.kairos['host']                ||= 'localhost'
Settings.kairos['port']                ||= Settings.kairos.https ? 443 : 80

#
# Gitlab
#
Settings['gitlab'] ||= Settingslogic.new({})
Settings.gitlab['server_url'] ||= ENV['GITLAB_SERVER_URL']