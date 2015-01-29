class ApplicationController < ActionController::Base
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # From https://github.com/plataformatec/devise/wiki/How-To:-Simple-Token-Authentication-Example
  # https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
  def authenticate_user_from_token!
    user_token = if params[:authenticity_token].presence
                   params[:authenticity_token].presence
                 elsif params[:private_token].presence
                   params[:private_token].presence
                 end
    user = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end

  def gitlab_access_configured!
    if current_user.gitlab_token.nil?
      redirect_to profiles_url, alert: "Please configure Gitlab private token"
    end
  end
end
