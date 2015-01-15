class ProfilesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_filter :user
  before_action :authenticate_user!

  def show
  end

  def reset_private_token
    if current_user.reset_authentication_token!
      flash[:notice] = t('profiles.message.token_successfully_updated')
    end

    redirect_to profiles_path
  end

  private

  def user
    @user = current_user
  end
end
