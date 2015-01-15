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

  def update_gitlab_private_token
    if current_user.update_gitlab_authentication_token!(params[:token])
      flash[:notice] = t('profiles.message.token_successfully_updated')
    else
      flash[:alert] = t('profiles.message.token_failed_update')
    end

    redirect_to profiles_path
  end

  private

  def user
    @user = current_user
  end
end
