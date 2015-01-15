class AddGitlabAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gitlab_authentication_token, :string
  end
end
