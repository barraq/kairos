require 'devise'

class User < ActiveRecord::Base
  include TokenAuthenticatable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  validates :gitlab_authentication_token, length: { minimum: 10, maximum: 30 }, format: { with: /\A[A-Za-z0-9+-\/]+\z/ }

  before_save :ensure_authentication_token
  alias_attribute :private_token, :authentication_token
  alias_attribute :gitlab_token, :gitlab_authentication_token

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :gitlab_authentication_token
  end
end
