require 'devise'

class User < ActiveRecord::Base
  include TokenAuthenticatable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  before_save :ensure_authentication_token
  alias_attribute :private_token, :authentication_token
end
